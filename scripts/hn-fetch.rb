#!/usr/bin/env ruby
# frozen_string_literal: true

# HN Data Fetcher — fetch HN discussions + target articles into the hn-data
# archive (sole storage since phase 2; the GH Actions cache layer is retired).
#
# Usage:
#   ruby scripts/hn-fetch.rb --lists [--force] [--jobs N]
#                            [--fetch-articles-simple] [--skip-articles] [--timeout N]
#   ruby scripts/hn-fetch.rb --url <hn_url> [--force] [--fetch-articles-simple]
#   ruby scripts/hn-fetch.rb --fetch-article-url <url> [--timeout N]
#   ruby scripts/hn-fetch.rb --fill-missing [--jobs N]
#   ruby scripts/hn-fetch.rb --poll-watching   # tiered liveness poll (watch/cold/deep)
#   ruby scripts/hn-fetch.rb --hot-check [--daily-max N]   # dual-channel burst trigger
#
# Archive layer (hn-data branch working copy, env HN_ARCHIVE_DIR):
#   snapshots/YYYY/MM.jsonl     score/comment time series (append-only)
#   threads/YYYY/WNN/<id>.yaml  post + merged comments (permanent)
#   topics.json                 thread registry with tiered status machine
#                               active (14d) / watching (weekly poll) /
#                               cold (monthly) / deep (quarterly) / settled
#   triggers.json               hot-dispatch history (permanent)

require 'net/http'
require 'uri'
require 'json'
require 'yaml'
require 'nokogiri'
require 'reverse_markdown'
require 'date'
require 'fileutils'
require 'optparse'
require 'time'
require 'set'

RENDERER_URL = ENV.fetch('RENDERER_URL', 'http://localhost:3000')

$stdout.sync = true
$print_mutex = Mutex.new

CACHE_DIR = '_data/hn'
SCORE_THRESHOLD = 80
MAX_DEFAULT = 30          # per HN list page (lists are 30 rows/page)
BEST_PAGES = 2            # /best p1-p2: established high-score threads
NEWS_PAGES = 2            # /news p1-p2: front-page risers incl. 50-79pt leads
LEAD_SCORE_MIN = 50       # news-only threads below SCORE_THRESHOLD are tracked as
                          # "leads" (registry + snapshot only, no per-thread fetch);
                          # list rows under this floor are dropped entirely
COMMENT_THRESHOLD = 0
COMMENT_CAP = 100
ARTICLE_TRUNCATE = 8000
HN_API_BASE = 'https://hacker-news.firebaseio.com/v0'
ALGOLIA_API = 'https://hn.algolia.com/api/v1'

# ── Archive layer (cold storage working copy, synced to hn-data branch) ──
# Lives OUTSIDE _data/ on purpose: Jekyll loads _data/**/*.yaml into site.data
# for every build — archived threads would bloat it unboundedly.
ARCHIVE_DIR = ENV.fetch('HN_ARCHIVE_DIR', '.hn-archive')
REGISTRY_PATH = File.join(ARCHIVE_DIR, 'topics.json')
PUBLISHED_PATH = File.join(ARCHIVE_DIR, 'published.json')
SNAPSHOTS_DIR = File.join(ARCHIVE_DIR, 'snapshots')
THREADS_DIR = File.join(ARCHIVE_DIR, 'threads')

# Observation-set state machine: a thread with any delta (score/comments)
# within this window stays active; after that it degrades through liveness
# tiers — watching (14-45d, weekly poll) -> cold (45-180d, monthly poll) ->
# deep (>180d, quarterly poll) -> settled (terminal, data kept forever).
ACTIVE_WINDOW = 14 * 24 * 3600
POLL_INTERVALS = { 'watching' => 7 * 24 * 3600, 'cold' => 30 * 24 * 3600, 'deep' => 90 * 24 * 3600 }.freeze
POLL_CAPS = { 'watching' => 500, 'cold' => 1000, 'deep' => 2000 }.freeze
WATCHING_COLD_AGE = 45 * 24 * 3600   # no delta beyond this -> cold
COLD_DEEP_AGE = 180 * 24 * 3600      # no delta beyond this -> deep
POLL_BATCH_MAX = 40                  # max polls per --poll-watching run (load spread)
TRIGGERS_PATH = File.join(ARCHIVE_DIR, 'triggers.json')

# Dual-channel hot trigger: point-value channel (legacy) + snapshot-delta channel
HOT_DELTA_SCORE = 80        # score gained since previous snapshot (typically 8h)
HOT_DELTA_AGE_MAX_HOURS = 72
HOT_DELTA_SCORE_MIN = 100

# Per-domain concurrency limit for simple article fetch
MAX_PER_DOMAIN = 2
REDIRECT_CODES = %w[301 302 303 307 308].freeze
MAX_REDIRECTS = 5
$domain_mutex = Mutex.new
$domain_conns = {}
$domain_cv = ConditionVariable.new

# ── API (thread-safe, per-request HTTP) ──

def api_get_json(url, open_timeout: 10, read_timeout: 15)
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = uri.scheme == 'https'
  http.open_timeout = open_timeout
  http.read_timeout = read_timeout
  resp = http.request(Net::HTTP::Get.new(uri.request_uri))
  body = resp.body
  # Pin the encoding explicitly: Net::HTTP tagging varies across ruby/nokogiri
  # versions, and a mis-tagged body later decodes UTF-8 as Latin-1 (mojibake
  # with C1 controls that even breaks Jekyll's _data YAML parse).
  body = body.force_encoding('UTF-8') unless body.encoding == Encoding::UTF_8
  JSON.parse(body)
rescue => e
  raise "API fetch failed #{url}: #{e.message}"
end

def firebase_get(endpoint)
  api_get_json("#{HN_API_BASE}/#{endpoint}")
end

def algolia_get(endpoint)
  api_get_json("#{ALGOLIA_API}/#{endpoint}")
rescue => e
  warn "Algolia API error #{endpoint}: #{e.message}" if $stderr.tty?
  nil
end

# ── Stories ──

def fetch_stories_algolia
  cutoff = (Time.now.to_i - 48 * 3600).to_s
  data = algolia_get("search?tags=story&hitsPerPage=#{MAX_DEFAULT}&numericFilters=points>=80,created_at_i>=#{cutoff}")
  return nil unless data && data['hits']
  data['hits'].map { |h|
    {
      'id' => h['objectID'],
      'title' => h['title'] || '',
      'url' => h['url'],
      'hn_url' => "https://news.ycombinator.com/item?id=#{h['objectID']}",
      'score' => h['points'] || 0,
      'author' => h['author'] || '',
      'descendants' => h['num_comments'] || 0,
      'created_at_i' => h['created_at_i'],
      'posted_at' => h['created_at_i'] ? Time.at(h['created_at_i']).utc.iso8601 : nil,
    }
  }
end

def fetch_stories_firebase
  cutoff_48h = Time.now.to_i - 48 * 3600
  ids = firebase_get('beststories.json')
  ids.first(MAX_DEFAULT * 2).map do |id|
    item = firebase_get("item/#{id}.json")
    next unless item && item['type'] == 'story' && item['score'] && item['score'] >= SCORE_THRESHOLD
    next if item['time'] && item['time'] < cutoff_48h
    {
      'id' => id.to_s,
      'title' => item['title'] || '',
      'url' => item['url'],
      'hn_url' => "https://news.ycombinator.com/item?id=#{id}",
      'score' => item['score'],
      'author' => item['by'] || '',
      'descendants' => item['descendants'] || 0,
      'created_at_i' => item['time'],
      'posted_at' => item['time'] ? Time.at(item['time']).utc.iso8601 : nil,
    }
  end.compact.first(MAX_DEFAULT)
end

# ── Scrape list pages (primary source: /best no time limit catches slow-burn,
#    /news catches front-page risers before they clear SCORE_THRESHOLD) ──

SCRAPE_RETRIES = 3
SCRAPE_RETRY_DELAY = 3

def scrape_list_page(path, min_score)
  uri = URI("https://news.ycombinator.com#{path}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.open_timeout = 10
  http.read_timeout = 15
  resp = http.request(Net::HTTP::Get.new(uri))
  return nil unless resp.code.to_i == 200

  body = resp.body
  # HN serves UTF-8; pin it before Nokogiri — its charset sniffing on
  # untagged (ASCII-8BIT) input mis-decodes UTF-8 as Latin-1 on some
  # nokogiri builds, corrupting titles into C1-control mojibake.
  body = body.force_encoding('UTF-8') unless body.encoding == Encoding::UTF_8
  doc = Nokogiri::HTML(body)
  stories = []
  dupes = Set.new

  doc.css('tr.athing').each do |row|
    id = row['id']
    next unless id
    next if dupes.include?(id)
    dupes.add(id)

    title_el = row.at_css('.titleline > a')
    next unless title_el

    subrow = row.next_element
    score_el = subrow&.at_css('.score')
    score = score_el ? score_el.text[/\d+/].to_i : 0
    next if score < min_score

    # Comment count + author from the subtext row. The comments link is the
    # item-link whose text says "N comments" / "discuss" — NOT the first item
    # link, which is the age ("1 day ago" used to parse as descendants=1,
    # breaking freshness so every listed thread refetched every run).
    comments_link = subrow&.css('a[href^="item?"]').find { |a|
      a.text.match?(/comment/i) || a.text.strip == 'discuss'
    }
    descendants = comments_link ? (comments_link.text[/\d+/] || 0).to_i : 0
    author = subrow&.at_css('.hnuser')&.text || ''

    # age title attr carries the exact UTC creation time (verified against the
    # Firebase item API) — no relative-text parsing needed
    age_el = subrow&.at_css('.age')
    posted_at = age_el && age_el['title'] ? "#{age_el['title']}Z" : nil

    a = title_el
    stories << {
      'id' => id,
      'title' => a.text.strip,
      'url' => a['href'].start_with?('item?') ? nil : a['href'],
      'hn_url' => "https://news.ycombinator.com/item?id=#{id}",
      'score' => score,
      'author' => author,
      'descendants' => descendants,
      'posted_at' => posted_at,
    }
    break if stories.length >= MAX_DEFAULT
  end

  stories
end

# Scrape several pages of one list, dedupe by id; nil when every page fails.
def scrape_list_pages(list, pages, min_score)
  stories = []
  seen = Set.new
  pages.times do |p|
    path = p.zero? ? "/#{list}" : "/#{list}?p=#{p + 1}"
    page = nil
    SCRAPE_RETRIES.times do |i|
      begin
        page = scrape_list_page(path, min_score)
        break if page && page.any?
      rescue => e
        warn "  Scrape attempt #{i + 1}/#{SCRAPE_RETRIES} #{path}: #{e.message}"
        sleep SCRAPE_RETRY_DELAY * (i + 1)
      end
    end
    return nil if page.nil? && stories.empty?
    Array(page).each { |s| next if seen.include?(s['id']); seen.add(s['id']); stories << s }
  end
  stories.empty? ? nil : stories
end

def fetch_stories_best
  scrape_list_pages('best', BEST_PAGES, SCORE_THRESHOLD) ||
    Array(fetch_stories_algolia) || Array(fetch_stories_firebase)
end

# News tier is best-effort: on scrape failure it silently degrades (the best
# chain above already carries its own Algolia/Firebase fallback for the same host).
def fetch_stories_news
  scrape_list_pages('news', NEWS_PAGES, LEAD_SCORE_MIN)
end

# ── Comments ──

def flatten_comments(children)
  (children || []).select { |c| c['type'] == 'comment' }.flat_map { |c|
    [{
      'id' => c['id'].to_s,
      'parent_id' => (c['parent_id'] || '0').to_s,
      'author' => c['author'] || 'anonymous',
      'text' => c['text'] || '',
      'score' => c['points'] || 0,
      'posted_at' => c['created_at'] ? Time.parse(c['created_at']).utc.iso8601 : nil,
    }] + flatten_comments(c['children'])
  }
end

def fetch_discussion_algolia(post_id)
  data = algolia_get("items/#{post_id}")
  return nil unless data
  comments = flatten_comments(data['children'])
  active = comments.select { |c| c['score'] >= COMMENT_THRESHOLD }
  if active.length > 20
    active = active.sort_by { |c| -c['score'] }.first(COMMENT_CAP)
  end
  DiscussionResult.new(
    data['title'] || '',
    data['url'],
    data['points'] || 0,
    data['author'] || '',
    data['created_at'] ? Time.parse(data['created_at']).utc.iso8601 : nil,
    active,
    comments.length,
  )
end

def parse_comments_firebase(ids)
  comments = []
  ids.each do |cid|
    c = firebase_get("item/#{cid}.json")
    next unless c && c['type'] == 'comment' && c['text'] && !c['text'].empty?
    text = Nokogiri::HTML(c['text']).text.strip
    next if text.empty?
    comments << {
      'id' => cid.to_s,
      'parent_id' => c['parent'].to_s,
      'author' => c['by'] || 'anonymous',
      'text' => text,
      'score' => c['score'] || 0,
      'posted_at' => c['time'] ? Time.at(c['time']).utc.iso8601 : nil,
    }
  end
  comments
end

def fetch_discussion_firebase(post_id)
  item = firebase_get("item/#{post_id}.json")
  return nil unless item

  comments = item['kids'] ? parse_comments_firebase(item['kids']) : []
  active = comments.select { |c| c['score'] >= COMMENT_THRESHOLD }
  if active.length > 20
    active = active.sort_by { |c| -c['score'] }.first(COMMENT_CAP)
  end

  DiscussionResult.new(
    item['title'] || '',
    item['url'],
    item['score'] || 0,
    item['by'] || '',
    item['time'] ? Time.at(item['time']).utc.iso8601 : nil,
    active,
    comments.length,
  )
end

def fetch_discussion(post_id)
  fetch_discussion_algolia(post_id) || fetch_discussion_firebase(post_id)
end

DiscussionResult = Struct.new(:post_title, :post_url, :score, :author, :posted_at, :comments, :raw_comment_count)

# ── Browser fetch (for article JS rendering, requires renderer service) ──

def fetch_with_browser(url, js_render: false)
  uri = URI("#{RENDERER_URL}/render")
  params = { url: url }
  params[:js_render] = '1' if js_render
  uri.query = URI.encode_www_form(params)
  resp = Net::HTTP.get_response(uri)
  [resp.code.to_i, resp.body.force_encoding('UTF-8')]
rescue => e
  raise "Browser fetch failed for #{url}: #{e.message}"
end

# ── Article extraction (renderer-based, requires browser service) ──

def extract_article(url)
  result = {
    'url' => url,
    'title' => nil,
    'fetch_status' => nil,
    'content' => nil,
    'error' => nil,
    'fetched_at' => Time.now.utc.iso8601
  }

  if url.nil? || url.empty?
    result['fetch_status'] = 'skipped'
    return result
  end

  begin
    _, html = fetch_with_browser(url, js_render: true)
    doc = Nokogiri::HTML(html)

    result['title'] = doc.at_css('title')&.text&.strip

    doc.css(
      'script, style, nav, footer, header, aside, noscript, iframe, ' \
      '.sidebar, .nav, .menu, .comments, .comment-list, .related-posts'
    ).each(&:remove)

    article_el = doc.at_css(
      'article, main, [role="main"], .article, .post-content, ' \
      '.entry-content, .content, .post, .blog-post, #content'
    )
    body = article_el || doc.at_css('body') || doc

    markdown = ReverseMarkdown.convert(body.inner_html, unknown_tags: :drop)
    markdown = markdown.gsub(/\n{3,}/, "\n\n").strip

    result['content'] = markdown[0, ARTICLE_TRUNCATE]
    if result['content'] && result['content'].length >= MIN_ARTICLE_CHARS
      result['fetch_status'] = 'success'
    else
      result['fetch_status'] = 'error'
      result['error'] = "insufficient content (#{(result['content'] || '').length} chars)"
    end
  rescue => e
    msg = e.message || ''
    if msg.include?('403') || msg.include?('Forbidden')
      result['fetch_status'] = 'blocked'
    elsif msg.include?('404') || msg.include?('Not Found')
      result['fetch_status'] = 'not_found'
    else
      result['fetch_status'] = 'error'
    end
    result['error'] = msg[0, 500]
  end

  result
end

# ── Simple article extraction (pure HTTP, no renderer) ──

JS_BLOCKER_PATTERNS = [
  /enable.{0,30}javascript/i,
  /checking your browser/i,
  /verifying your browser/i,
  /\bcloudflare\b.{0,50}(challenge|security|ray\s*id)/i,
  /attention required/i,
  /verify.{0,20}(you are|you're) human/i,
  /prove.{0,10}(''?you'?re?|human)/i,
  /challenge[-_ ]?platform/i,
  /captcha\.(com|net|challenge)/i,
  /<meta\s[^>]*http-equiv=["']refresh["']/i,
].freeze

# js_blocker only applies to short pages — articles with substantial visible
# text never legitimately present these phrases, and long pages containing
# incidental challenge vocabulary are not challenge pages.
JS_BLOCKER_MAX_TEXT = 3000

SOFT_404_PATTERNS = [
  /page\s+not\s+found/i,
  /this\s+page\s+could\s+not\s+be\s+found/i,
  /404\s*(not\s*)?found/i,
].freeze

MIN_ARTICLE_CHARS = 200
MIN_PRINTABLE_RATIO = 0.80

def printable_ratio(text)
  printable = text.count(" -~\n\r\t")
  total = text.length
  total > 0 ? printable.to_f / total : 0.0
end

def content_passes_gates(body, url)
  return :empty if body.nil? || body.empty?

  doc = Nokogiri::HTML(body)

  # Strip non-visible payloads BEFORE challenge detection — script/style text
  # (e.g. "captcha_site_key" config, document.write footers) is not content
  # and must not trip the JS-wall gate.
  doc.css('script, style, noscript, iframe, template').each(&:remove)
  visible = doc.text.strip

  return :empty if visible.empty?

  # JS blocker / challenge detection (visible text only, short pages only)
  if visible.length < JS_BLOCKER_MAX_TEXT &&
     JS_BLOCKER_PATTERNS.any? { |p| visible.match?(p) }
    return :js_blocker
  end

  # Soft 404 via title + h1
  title = doc.at_css('title')&.text || ''
  h1 = doc.at_css('h1')&.text || ''
  combined = title + ' ' + h1
  return :soft_404 if SOFT_404_PATTERNS.any? { |p| combined.match?(p) }

  # Strip HTML, check plain text length
  text = visible
  return :too_short if text.length < MIN_ARTICLE_CHARS

  # Check printable character ratio
  return :binary if printable_ratio(text) < MIN_PRINTABLE_RATIO

  :pass
end

def extract_article_simple(url, open_timeout: 10, read_timeout: 20)
  result = {
    'url' => url,
    'title' => nil,
    'fetch_status' => nil,
    'content' => nil,
    'error' => nil,
    'fetched_at' => Time.now.utc.iso8601
  }

  return result.merge('fetch_status' => 'skipped') if url.nil? || url.empty?

  begin
    uri = URI(url)
    unless uri.is_a?(URI::HTTP)
      return result.merge('fetch_status' => 'skipped', 'error' => "non-http scheme: #{uri.scheme}")
    end

    resp = nil
    MAX_REDIRECTS.succ.times do      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.open_timeout = open_timeout
      http.read_timeout = read_timeout
      http.max_retries = 0

      request = Net::HTTP::Get.new(uri.request_uri)
      request['User-Agent'] = 'Mozilla/5.0 (compatible; yuedulijie.com/1.0; HN article fetcher)'
      request['Accept'] = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
      request['Accept-Language'] = 'en-US,en;q=0.5'

      resp = http.request(request)
      break unless REDIRECT_CODES.include?(resp.code)

      loc = resp['Location'].to_s
      target = loc.start_with?('http://', 'https://') ? URI(loc) : URI.join(uri, loc)
      unless target.is_a?(URI::HTTP)
        return result.merge('fetch_status' => 'skipped', 'error' => "redirect to non-http scheme: #{target.scheme}")
      end
      uri = target
      result['url'] = uri.to_s
    end

    # Gate 1: HTTP status
    code = resp.code.to_i
    unless code == 200
      status = case code
               when 403 then 'blocked'
               when 404 then 'not_found'
               else 'error'
               end
      return result.merge('fetch_status' => status, 'error' => "HTTP #{code}")
    end

    # Gate 2: Content-Type must be HTML
    content_type = (resp['Content-Type'] || '').downcase
    unless content_type.start_with?('text/html', 'application/xhtml+xml')
      return result.merge('fetch_status' => 'skipped', 'error' => "non-html content-type: #{content_type}")
    end

    body = resp.body
    body.force_encoding('UTF-8')
    unless body.valid_encoding?
      body = body.encode('UTF-8', invalid: :replace, undef: :replace)
    end

    # Gates 3-6: content quality
    gate = content_passes_gates(body, url)
    unless gate == :pass
      return result.merge('fetch_status' => 'error', 'error' => "gate: #{gate}")
    end

    # Parse article
    doc = Nokogiri::HTML(body)
    result['title'] = doc.at_css('title')&.text&.strip

    doc.css(
      'script, style, nav, footer, header, aside, noscript, iframe, ' \
      '.sidebar, .nav, .menu, .comments, .comment-list, .related-posts'
    ).each(&:remove)

    sem_el = doc.at_css(
      'article, main, [role="main"], .article, .article-wrapper, ' \
      '.article-body, .article-content, .post-content, .postBody, ' \
      '.entry-content, .content, .post, .blog-post, #content'
    )

    # Heuristic fallback: the block element containing the most paragraph
    # text is most likely the article body. Semantic hit only wins when it
    # actually holds paragraph text (e.g. apple newsroom <main> is empty).
    para_len = lambda { |el| el.css('p').map(&:text).join.length }

    heur_el = begin
      candidates = doc.css('div, section').filter_map do |el|
        next unless para_len.call(el) >= MIN_ARTICLE_CHARS
        [el, para_len.call(el), el.ancestors.size]
      end
      best = candidates.max_by { |_el, p_len, depth| [p_len, -depth] }
      best&.first
    end

    heur_len = heur_el ? para_len.call(heur_el) : 0
    sem_len = sem_el ? para_len.call(sem_el) : 0
    article_el = if heur_len > sem_len && heur_len >= MIN_ARTICLE_CHARS
                   heur_el
                 else
                   sem_el || doc.at_css('body') || doc
                 end

    content_source = article_el

    markdown = ReverseMarkdown.convert(content_source.inner_html, unknown_tags: :drop)
    markdown = markdown.gsub(/\n{3,}/, "\n\n").strip

    # ReverseMarkdown swallows heavily-nested/unusual markup on some sites
    # (e.g. apple newsroom hidden copy-text). Fall back to structural block
    # extraction when the conversion is thin but paragraph text is not.
    if markdown.length < MIN_ARTICLE_CHARS * 2
      blocks = content_source.css(
        'h1, h2, h3, h4, h5, p, li, blockquote, pre, figcaption'
      ).filter_map do |x|
        t = x.text.gsub(/\s+/, ' ').strip
        t.empty? ? nil : [x.name, t]
      end
      plain = blocks.map { |tag, t|
        case tag
        when /^h[1-5]$/ then "\n#{'#' * tag[1].to_i} #{t}"
        when 'li' then "- #{t}"
        when 'blockquote' then "> #{t}"
        else t
        end
      }.join("\n\n").gsub(/\n{3,}/, "\n\n").strip
      markdown = plain if plain.length > markdown.length
    end

    result['content'] = markdown[0, ARTICLE_TRUNCATE]
    if result['content'] && result['content'].length >= MIN_ARTICLE_CHARS
      result['fetch_status'] = 'success'
    else
      result['fetch_status'] = 'error'
      result['error'] = "insufficient content (#{(result['content'] || '').length} chars)"
    end
  rescue Net::OpenTimeout, Net::ReadTimeout => e
    result['fetch_status'] = 'error'
    result['error'] = "timeout: #{e.message[0, 100]}"
  rescue => e
    result['fetch_status'] = 'error'
    result['error'] = e.message[0, 500]
  end

  result
end

# ── Per-domain concurrency limiter ──

def with_domain(domain)
  $domain_mutex.synchronize do
    $domain_conns[domain] ||= 0
    while $domain_conns[domain] >= MAX_PER_DOMAIN
      $domain_cv.wait($domain_mutex)
    end
    $domain_conns[domain] += 1
  end

  yield
ensure
  $domain_mutex.synchronize do
    current = $domain_conns[domain]
    $domain_conns[domain] = current && current > 0 ? current - 1 : 0
    $domain_cv.broadcast
  end
end

# ── Archive path helpers ──

def week_key(date = Date.today)
  year = date.cwyear.to_s
  week = date.cweek.to_s.rjust(2, '0')
  [year, "W#{week}"]
end

def archived_thread_path(id, reg = nil)
  e = reg && reg['threads'][id.to_s]
  if e && e['week']
    p = File.join(THREADS_DIR, e['week'], "#{id}.yaml")
    return p if File.exist?(p)
  end
  Dir.glob(File.join(THREADS_DIR, '*', 'W*', "#{id}.yaml")).first
end

def load_archived_thread(id, reg = nil)
  path = archived_thread_path(id, reg)
  return nil unless path
  YAML.safe_load_file(path, permitted_classes: [Time]) rescue nil
end

# Keep the richer of old/new article extraction results
def merge_article(old, new)
  return old if new.nil?
  return new if old.nil?
  old_ok = old['fetch_status'] == 'success'
  new_ok = new['fetch_status'] == 'success'
  return old if old_ok && (!new_ok || (new['content'] || '').length <= (old['content'] || '').length)
  new
end

# One-time bridge: adopt article.yaml from the retired cache layer (P1 archives
# lacked article content). CI self-heals without this — freshness requires an
# article, so missing ones get refetched on the first P2 run.
def legacy_cache_article(id)
  f = Dir.glob(File.join(CACHE_DIR, '*', 'W*', id, 'article.yaml')).first
  return nil unless f
  YAML.safe_load_file(f, permitted_classes: [Time]) rescue nil
end

# ── Core fetch (archive-based, no writes — caller archives) ──

ARTICLE_FRESH_STATES = %w[success skipped blocked not_found].freeze

def fetch_and_cache(reg, hn_url, known_meta: nil, force: false, article_mode: :renderer,
                    simple_timeout: 20)
  post_id = known_meta ? known_meta['id'] : hn_url[/\d+/]
  return [:error, nil, "no post_id extracted from #{hn_url}"] unless post_id

  archived = load_archived_thread(post_id, reg)

  # Freshness: comment count unchanged since last fetch AND article resolved.
  # Threads lacking an article (pre-P2 archives) refetch once and self-heal.
  if !force && known_meta && archived
    a_status = archived['article'] && archived['article']['fetch_status']
    if known_meta['descendants'] == archived['post']['raw_comment_count'].to_i &&
       ARTICLE_FRESH_STATES.include?(a_status)
      return [:cached, { 'post' => archived['post'],
                         'comments' => { 'comments' => archived['comments'] },
                         'article' => archived['article'] }, nil]
    end
  end

  disc = fetch_discussion(post_id)
  unless disc
    if archived && Array(archived['comments']).any?
      return [:cached, { 'post' => archived['post'],
                         'comments' => { 'comments' => archived['comments'] },
                         'article' => archived['article'] }, nil]
    end
    return [:error, nil, "failed to fetch discussion for #{post_id}"]
  end

  article_url = disc.post_url || known_meta&.dig('url')

  post_data = {
    'id' => post_id,
    'title' => disc.post_title,
    'url' => article_url,
    'hn_url' => hn_url,
    'score' => known_meta ? known_meta['score'] : disc.score,
    'author' => known_meta ? known_meta['author'] : disc.author,
    'posted_at' => disc.posted_at,
    'fetched_at' => Time.now.utc.iso8601,
    'article_url' => article_url,
    'article_fetch_status' => nil,
    'article_fetched_at' => nil,
    'raw_comment_count' => disc.raw_comment_count,
  }

  old_article = archived && archived['article']

  article_data = case article_mode
                 when :skip
                   old_article || { 'fetch_status' => 'skipped' }

                  when :simple
                    domain = URI.parse(article_url.to_s).host rescue nil
                    attempt = if domain
                                with_domain(domain) do
                                  extract_article_simple(article_url, read_timeout: simple_timeout)
                                end
                              else
                                extract_article_simple(article_url, read_timeout: simple_timeout)
                              end
                    merged = merge_article(old_article, attempt)
                    # Same guard as before: a thin simple-mode extraction that is
                    # much shorter than what we had is likely a degraded page.
                    if attempt['fetch_status'] == 'success' && old_article &&
                       old_article['fetch_status'] == 'success' &&
                       (attempt['content'] || '').length < 1000 &&
                       (old_article['content'] || '').length > (attempt['content'] || '').length
                      old_article
                    else
                      merged
                    end

                 else # :renderer
                   if !force && old_article && old_article['fetch_status'] == 'success' &&
                      old_article['url'] == article_url
                     old_article
                   else
                     extract_article(article_url)
                   end
                 end

  post_data['article_fetch_status'] = article_data['fetch_status']
  post_data['article_fetched_at'] = article_data['fetched_at'] if article_data['fetched_at']

  [:fetched, { 'post' => post_data, 'comments' => { 'comments' => disc.comments },
               'article' => article_data }, nil]
end

# ── stdout summary ──

def print_result_line(result)
  return unless result

  post = result['post']
  return unless post

  id = post['id']
  title = post['title'] || ''
  score = post['score'] || 0
  comments = result['comments']
  active_count = comments ? comments['comments'].length : 0
  raw_count = post['raw_comment_count'] || 0
  article = result['article']
  astat = article ? (article['fetch_status'] || 'unknown') : 'unknown'
  article_chars = (article && article['content']) ? article['content'].length : 0

  parts = []
  parts << "#{id} \"#{title[0, 60]}\" (#{score} pts)"
  parts << "raw:#{raw_count} active:#{active_count}#{active_count == 0 ? ' ⚠' : ''}"

  case astat
  when 'success'      then parts << "article #{article_chars} chars"
  when 'skipped'      then parts << 'no article URL'
  when 'blocked'      then parts << 'article blocked'
  when 'not_found'    then parts << 'article 404'
  when 'error'        then parts << 'article error'
  when 'unknown'      then parts << 'article unknown'
  end

  $print_mutex.synchronize do
    puts "  #{parts.join(' — ')}"
  end
end

# ── Parallel processing ──

def process_stories_parallel(reg, stories, force: false, article_mode: :renderer,
                             jobs: 5, simple_timeout: 20)
  queue = Queue.new
  stories.each { |s| queue << s }
  results_queue = Queue.new

  workers = Array.new(jobs) do
    Thread.new do
      loop do
        story = queue.pop(true) rescue nil
        break unless story
        status, result, err = fetch_and_cache(
          reg,
          story['hn_url'],
          known_meta: story,
          force: force,
          article_mode: article_mode,
          simple_timeout: simple_timeout,
        )
        results_queue << { status: status, result: result, err: err, story: story }
      end
    end
  end

  workers.each(&:join)

  stats = { fetched: 0, cached: 0, articles_ok: 0, errors: 0, error_details: [], fetched_results: [] }

  until results_queue.empty?
    entry = results_queue.pop(true) rescue nil
    break unless entry

    case entry[:status]
    when :cached
      stats[:cached] += 1
      print_result_line(entry[:result])
    when :fetched
      stats[:fetched] += 1
      print_result_line(entry[:result])
      stats[:fetched_results] << entry[:result] if entry[:result]
      stats[:articles_ok] += 1 if entry[:result]&.dig('article', 'fetch_status') == 'success'
    when :error
      stats[:errors] += 1
      stats[:error_details] << "  ✗ #{entry[:story]['id']}: #{entry[:err]}"
    end
  end

  stats
end

# ── Fill missing articles (renderer, archive-based) ──

def fill_missing_articles(jobs: 3)
  paths = Dir.glob(File.join(THREADS_DIR, '*', 'W*', '*.yaml'))
  puts "Scanning #{paths.length} archived threads..."

  to_fill = paths.filter_map do |path|
    t = (YAML.safe_load_file(path, permitted_classes: [Time]) rescue nil)
    next unless t && t['post']
    status = t['article'] ? t['article']['fetch_status'] : 'missing'
    next if %w[success skipped].include?(status)
    url = t['post']['article_url'] || t['post']['url']
    next unless url
    puts "  #{t['post']['id']}: #{status}, needs fill"
    path
  end

  if to_fill.empty?
    puts 'All archived articles have content. Nothing to fill.'
    return
  end

  puts "Found #{to_fill.length} articles to fill"

  ru = RENDERER_URL
  begin
    resp = Net::HTTP.get_response(URI("#{ru}/health"))
    unless resp.code.to_i == 200
      puts "Renderer unhealthy (HTTP #{resp.code}). Skip fill."
      return
    end
  rescue => e
    puts "Renderer unreachable: #{e.message}. Skip fill."
    return
  end
  puts 'Renderer healthy.'

  queue = Queue.new
  to_fill.each { |entry| queue << entry }
  results_mutex = Mutex.new
  results = { filled: 0, skipped: 0, errors: 0 }

  threads = Array.new([jobs, to_fill.length].min) do
    Thread.new do
      loop do
        entry = queue.pop(true) rescue nil
        break unless entry
        fill_one_article(entry, results, results_mutex)
      end
    end
  end

  threads.each(&:join)

  puts "\nFill summary: #{results[:filled]} filled, #{results[:skipped]} skipped, #{results[:errors]} errors"
end

def fill_one_article(path, results, mutex)
  t = (YAML.safe_load_file(path, permitted_classes: [Time]) rescue nil)
  return unless t && t['post']
  post_id = t['post']['id']
  article_url = t['post']['article_url'] || t['post']['url']

  unless article_url
    mutex.synchronize { results[:skipped] += 1 }
    puts "  #{post_id}: no URL, skip"
    return
  end

  old = t['article']
  old_chars = (old && old['content']) ? old['content'].length : 0

  puts "  #{post_id}: fetching #{article_url[0, 80]}..."

  article = extract_article(article_url)

  if article['fetch_status'] == 'success' && article['content'] && !article['content'].strip.empty?
    new_chars = article['content'].length

    # Renderer should produce >= existing content. If not, keep old.
    if new_chars < old_chars && old_chars > 0
      puts "  #{post_id}: renderer got LESS (#{new_chars} < #{old_chars}), keep existing"
      mutex.synchronize { results[:skipped] += 1 }
      return
    end

    t['article'] = article
    t['post']['article_fetch_status'] = 'success'
    t['post']['article_fetched_at'] = article['fetched_at']
    tmp = path + '.tmp'
    File.write(tmp, YAML.dump(t))
    File.rename(tmp, path)

    gained = new_chars - old_chars
    suffix = gained > 0 ? " (+#{gained})" : ''
    puts "  #{post_id}: filled (#{new_chars} chars#{suffix})"
    mutex.synchronize { results[:filled] += 1 }
  else
    reason = article['fetch_status'] || 'unknown'
    puts "  #{post_id}: renderer failed (#{reason})"
    mutex.synchronize { results[:errors] += 1 }
  end
end

# ── Hot check (velocity burst trigger for CI) ──

HOT_SCORE_MIN = 200
HOT_AGE_MAX_HOURS = 8
HOT_VELOCITY_MIN = 20.0

def load_trigger_state
  if File.exist?(TRIGGERS_PATH)
    data = (JSON.parse(File.read(TRIGGERS_PATH)) rescue nil)
    return data if data.is_a?(Hash) && data['triggered'].is_a?(Array)
  end
  # One-time bridge from the old cache-resident trigger state (2-week TTL hole:
  # trigger history used to evaporate with the week cache entry)
  legacy = Dir.glob(File.join(CACHE_DIR, '*', 'W*', '.triggers.yaml')).filter_map { |f|
    YAML.safe_load_file(f, permitted_classes: [Time]) rescue nil
  }.flat_map { |s| Array(s['triggered']) }
  legacy.empty? ? { 'triggered' => [] } : { 'triggered' => legacy }
end

def hot_check(daily_max: 2, max_age_hours: HOT_AGE_MAX_HOURS,
              score_min: HOT_SCORE_MIN, velocity_min: HOT_VELOCITY_MIN)
  state = load_trigger_state
  triggered_ids = Array(state['triggered'])
  triggered_id_set = triggered_ids.map { |t| t.is_a?(Hash) ? t['id'] : t }.compact
  today = Time.now.utc.strftime('%Y-%m-%d')
  today_count = triggered_ids.count { |t| t.is_a?(Hash) && t['date'] == today }

  known_article_ids = known_published_ids
  reg = load_registry

  hot = []
  # Channel 1 — point-value: registry-driven (no cache dependency)
  reg['threads'].each do |id, e|
    next if known_article_ids.include?(id) || triggered_id_set.include?(id)
    next unless e['posted_at']
    hours = ((Time.now.utc - (Time.parse(e['posted_at'].to_s) rescue nil)) / 3600.0) rescue nil
    next unless hours && hours >= 0 && hours <= max_age_hours
    score = e['last_score'].to_i
    next if score < score_min
    velocity = score / [hours, 0.5].max
    next if velocity < velocity_min
    hot << {
      'id' => id, 'title' => e['title'], 'score' => score,
      'age_hours' => hours.round(2), 'velocity' => velocity.round(1),
      'hn_url' => e['hn_url'],
    }
  end

  # Channel 2 — snapshot delta: score burst since previous sample (typically 8h),
  # catches risers that never satisfied the point-value channel (e.g. day-2 posts
  # outside the 8h age window)
  hot_ids = hot.map { |h| h['id'] }
  reg['threads'].each do |id, e|
    next if known_article_ids.include?(id) || triggered_id_set.include?(id)
    next if hot_ids.include?(id)
    next unless e['posted_at']
    hours = ((Time.now.utc - (Time.parse(e['posted_at'].to_s) rescue nil)) / 3600.0) rescue nil
    next unless hours && hours >= 0 && hours <= HOT_DELTA_AGE_MAX_HOURS
    next if e['last_score'].to_i < HOT_DELTA_SCORE_MIN

    hist = snapshot_history(id)
    next unless hist.length >= 2
    prev, last = hist[-2], hist[-1]
    gap_h = ((Time.parse(last['t']) - Time.parse(prev['t'])) / 3600.0) rescue next
    next unless gap_h > 0.5
    delta = last['s'] - prev['s']
    next unless delta >= HOT_DELTA_SCORE

    hot << {
      'id' => id,
      'title' => e['title'],
      'score' => e['last_score'].to_i,
      'age_hours' => hours.round(2),
      'velocity' => (delta / gap_h).round(1),
      'hn_url' => e['hn_url'],
      'reason' => "delta +#{delta} pts/#{gap_h.round(1)}h",
    }
  end

  hot.sort_by! { |h| -h['velocity'] }

  budget = daily_max - today_count
  hot.first([budget, 0].max).each do |h|
    puts "TRIGGER #{h['hn_url']}"
    triggered_ids << { 'id' => h['id'], 'date' => today, 'at' => Time.now.utc.iso8601 }
  end

  if hot.none?
    warn 'HOT: none'
  else
    hot.each { |h|
      reason = h['reason'] ? " #{h['reason']}" : ''
      warn "  #{h['velocity']} pts/h (#{h['score']} pts, #{h['age_hours']}h)#{reason} #{h['title'].to_s[0, 60]} [#{h['id']}]"
    }
  end

  if !File.exist?(TRIGGERS_PATH) || triggered_ids != Array(state['triggered'])
    FileUtils.mkdir_p(ARCHIVE_DIR)
    tmp = TRIGGERS_PATH + '.tmp'
    File.write(tmp, JSON.pretty_generate(
      'triggered' => triggered_ids.last(200),
      'updated_at' => Time.now.utc.iso8601
    ) + "\n")
    File.rename(tmp, TRIGGERS_PATH)
  end
  0
end

# ── Archive layer: registry (topics.json), snapshots, thread files ──

def load_registry
  if File.exist?(REGISTRY_PATH)
    data = (JSON.parse(File.read(REGISTRY_PATH)) rescue nil)
    return data if data.is_a?(Hash) && data['threads'].is_a?(Hash)
  end
  { 'version' => 1, 'updated_at' => nil, 'threads' => {} }
end

def save_registry(reg)
  reg['version'] ||= 1
  reg['updated_at'] = Time.now.utc.iso8601
  FileUtils.mkdir_p(ARCHIVE_DIR)
  tmp = REGISTRY_PATH + '.tmp'
  File.write(tmp, JSON.pretty_generate(reg) + "\n")
  File.rename(tmp, REGISTRY_PATH)
end

def registry_entry_for(reg, item)
  id = item['id'].to_s
  e = reg['threads'][id]
  unless e
    yr, wk = week_key
    e = {
      'title' => nil, 'url' => nil, 'hn_url' => nil, 'posted_at' => nil,
      'source' => item['source'] || 'hn',
      'week' => "#{yr}/#{wk}",
      'first_seen' => Time.now.utc.iso8601,
      'last_activity' => Time.now.utc.iso8601,
      'last_score' => 0, 'last_comment_count' => 0,
      'status' => 'active', 'last_polled' => nil, 'poll_streak' => 0,
    }
    reg['threads'][id] = e
  end
  e
end

def registry_update_from_stories(reg, stories, fetched_posts)
  now_s = Time.now.utc.iso8601

  stories.each do |s|
    e = registry_entry_for(reg, s)
    e['title'] ||= s['title']
    e['url'] = s['url'] if s['url']
    e['hn_url'] ||= s['hn_url']
    # leads never get a discussion fetch, so the list-scrape time (exact UTC,
    # see scrape_list_page) is their only posted_at — hot channels require it
    e['posted_at'] ||= s['posted_at']
    delta = s['score'].to_i != e['last_score'].to_i ||
            (s['descendants'].to_i > 0 && s['descendants'].to_i != e['last_comment_count'].to_i)
    e['last_score'] = s['score'].to_i if s['score'].to_i > 0
    e['last_comment_count'] = s['descendants'].to_i if s['descendants'].to_i > 0
    next unless delta
    e['last_activity'] = now_s
    e['status'] = 'active'
    e['poll_streak'] = 0
  end

  fetched_posts.each do |p|
    next unless p
    e = registry_entry_for(reg, p)
    e['title'] ||= p['title']
    e['url'] ||= p['url']
    e['hn_url'] ||= p['hn_url']
    e['posted_at'] ||= p['posted_at']
    e['last_score'] = p['score'].to_i if p['score'].to_i > 0
    e['last_activity'] = now_s
    e['status'] = 'active'
    e['poll_streak'] = 0
  end

  # active -> watching once no delta for ACTIVE_WINDOW (14d observation window,
  # NOT a data TTL: watching/cold/deep tiers are polled and can resurrect)
  reg['threads'].each_value do |e|
    next unless e['status'] == 'active'
    la = (Time.parse(e['last_activity'].to_s) rescue nil)
    e['status'] = 'watching' if la && (Time.now.utc - la) > ACTIVE_WINDOW
  end

  # Published threads are never candidates again — flag for registry-driven selection
  published = known_published_ids
  reg['threads'].each do |id, e|
    e['published'] = published.include?(id) unless e['published'] == true
  end

  reg
end

def append_snapshots(stories)
  return if stories.nil? || stories.empty?
  now = Time.now.utc
  path = File.join(SNAPSHOTS_DIR, now.strftime('%Y'), "#{now.strftime('%m')}.jsonl")
  FileUtils.mkdir_p(File.dirname(path))

  existing = {}
  if File.exist?(path)
    File.readlines(path).each do |line|
      obj = (JSON.parse(line) rescue nil)
      next unless obj
      (existing[obj['id'].to_s] ||= {})[obj['t'].to_s] = true
    end
  end

  t = now.iso8601
  new_rows = 0
  File.open(path, 'a') do |f|
    stories.each do |s|
      id = s['id'].to_s
      next if existing.dig(id, t)
      f.puts({ 'id' => id, 't' => t, 's' => s['score'].to_i, 'c' => s['descendants'].to_i }.to_json)
      new_rows += 1
    end
  end
  puts "  Snapshots: +#{new_rows} rows -> #{path}" if new_rows > 0
end

def snapshot_history(id, months: 2)
  now = Time.now.utc
  rows = []
  months.times do |back|
    m = Date.new(now.year, now.month, 1) >> -back
    path = File.join(SNAPSHOTS_DIR, m.strftime('%Y'), "#{m.strftime('%m')}.jsonl")
    next unless File.exist?(path)
    File.readlines(path).each do |line|
      obj = (JSON.parse(line) rescue nil)
      next unless obj && obj['id'].to_s == id.to_s
      rows << { 't' => obj['t'], 's' => obj['s'].to_i, 'c' => obj['c'].to_i }
    end
  end
  rows.sort_by { |r| r['t'] }
end

# Merge post + comments + article into the permanent thread archive; comments
# merge by id so resurrected refetches append new arrivals without losing old
# ones; article keeps the richer of old/new.
def archive_thread(reg, post_data, comments_data, article_data = nil)
  return nil unless post_data && post_data['id']
  id = post_data['id'].to_s
  e = registry_entry_for(reg, post_data)
  e['title'] ||= post_data['title']
  e['url'] ||= post_data['url']
  e['hn_url'] ||= post_data['hn_url']
  e['posted_at'] ||= post_data['posted_at']
  e['last_score'] = post_data['score'].to_i if post_data['score'].to_i > 0
  e['last_comment_count'] = post_data['raw_comment_count'].to_i if post_data['raw_comment_count']

  path = File.join(THREADS_DIR, e['week'].to_s, "#{id}.yaml")
  FileUtils.mkdir_p(File.dirname(path))

  prev = File.exist?(path) ? (YAML.safe_load_file(path, permitted_classes: [Time]) rescue nil) : nil

  merged = {}
  Array(prev && prev['comments']).each { |c| merged[c['id'].to_s] = c }
  Array(comments_data && comments_data['comments']).each { |c| merged[c['id'].to_s] = c }
  comments = merged.values.sort_by { |c| c['posted_at'].to_s }

  article = merge_article(prev && prev['article'], article_data)
  article ||= legacy_cache_article(id) if prev && !prev.key?('article')

  tmp = path + '.tmp'
  File.write(tmp, YAML.dump({
    'post' => post_data,
    'comments' => comments,
    'article' => article,
    'archived_at' => Time.now.utc.iso8601,
  }))
  File.rename(tmp, path)
  path
end

# Tiered liveness poll: watching (weekly) / cold (monthly) / deep (quarterly).
# One light Firebase item fetch per due thread; comment growth => full refetch,
# merge archive, resurrect to active. Tier aging + FIFO caps bound the budget.
def poll_watching
  reg = load_registry
  now = Time.now.utc

  # Tier aging (no delta): watching >45d -> cold, cold >180d -> deep
  reg['threads'].each_value do |e|
    la = (Time.parse(e['last_activity'].to_s) rescue nil)
    next unless la
    age = now - la
    if e['status'] == 'watching' && age > WATCHING_COLD_AGE
      e['status'] = 'cold'
      e['poll_streak'] = 0
    elsif e['status'] == 'cold' && age > COLD_DEEP_AGE
      e['status'] = 'deep'
      e['poll_streak'] = 0
    end
  end

  # FIFO caps: overflow demotes oldest-activity threads one tier (deep -> settled)
  POLL_CAPS.each do |tier, cap|
    ids = reg['threads'].select { |_id, e| e['status'] == tier }
    overflow = ids.length - cap
    next unless overflow > 0
    ids.sort_by { |_id, e| e['last_activity'].to_s }.first(overflow).each do |id, e|
      e['status'] = tier == 'deep' ? 'settled' : (tier == 'watching' ? 'cold' : 'deep')
      warn "REGISTRY: #{tier} overflow (#{cap}), demoted #{id} -> #{e['status']}"
    end
  end

  due = reg['threads'].select { |_id, e|
    interval = POLL_INTERVALS[e['status']]
    # liveness polling is HN-only for now (Firebase item API); lobsters threads
    # refresh via their own hottest pass while active
    interval && !_id.start_with?('lo-') &&
      (e['last_polled'].nil? ||
       (now - (Time.parse(e['last_polled'].to_s) rescue now)) >= interval)
  }.sort_by { |_id, e| e['last_polled'].to_s }

  if due.empty?
    puts 'Poll: no threads due for liveness check.'
    return
  end

  polled = 0
  resurrected = 0
  aged = 0
  due.first(POLL_BATCH_MAX).each do |id, e|
    item = (firebase_get("item/#{id}.json") rescue nil)
    unless item
      warn "Poll: fetch failed for #{id}, will retry next run"
      next
    end
    polled += 1
    e['last_polled'] = now.iso8601
    e['last_score'] = item['score'].to_i if item['score']

    descendants = item['descendants'].to_i
    if descendants > e['last_comment_count'].to_i
      disc = fetch_discussion(id)
      if disc
        gained = descendants - e['last_comment_count'].to_i
        post_data = {
          'id' => id,
          'title' => item['title'] || e['title'],
          'url' => item['url'],
          'hn_url' => e['hn_url'] || "https://news.ycombinator.com/item?id=#{id}",
          'score' => item['score'].to_i,
          'author' => item['by'] || '',
          'posted_at' => e['posted_at'] || (item['time'] ? Time.at(item['time']).utc.iso8601 : nil),
          'fetched_at' => now.iso8601,
          'raw_comment_count' => disc.raw_comment_count,
        }
        archive_thread(reg, post_data, { 'comments' => disc.comments })
        e['status'] = 'active'
        e['last_activity'] = now.iso8601
        e['poll_streak'] = 0
        e['last_comment_count'] = disc.raw_comment_count
        resurrected += 1
        warn "RESURRECTED #{id} \"#{post_data['title'].to_s[0, 50]}\" +#{gained} comments"
      end
    else
      e['poll_streak'] = e['poll_streak'].to_i + 1
      aged += 1
    end
  end

  save_registry(reg)
  counts = reg['threads'].values.group_by { |e| e['status'] }.transform_values(&:length)
  warn "Poll: #{polled} polled, #{resurrected} resurrected, #{aged} quiet, " \
       "#{due.length - polled} deferred. Registry: #{counts.map { |k, v| "#{k}=#{v}" }.sort.join(' ')}"
end

# ── Published dedup map (published.json fast path, _articles scan fallback) ──

def scan_published_ids_from_articles
  Dir.glob('_articles/**/*.md').flat_map { |f|
    File.read(f).to_enum(:scan, /hn_id:\s*"?(?<hn>\d+)"?|item\?id=(?<hn2>\d+)|lobste\.rs\/s\/(?<lo>[a-z0-9]+)/).map { Regexp.last_match }
        .map { |m| m[:hn] || m[:hn2] || (m[:lo] ? "lo-#{m[:lo]}" : nil) }
        .compact
  }.uniq
end

def known_published_ids
  if File.exist?(PUBLISHED_PATH)
    data = (JSON.parse(File.read(PUBLISHED_PATH)) rescue nil)
    return Set.new(data['hn_ids'].keys.map(&:to_s)) if data.is_a?(Hash) && data['hn_ids']
  end
  Set.new(scan_published_ids_from_articles)
end

# ── CLI ──

def run
  options = {
    mode: nil, url: nil, force: false,
    jobs: 5, fetch_articles_simple: false, skip_articles: false,
    timeout: 20
  }

  OptionParser.new do |opts|
    opts.banner = "Usage: ruby scripts/hn-fetch.rb [options]"
    opts.on('--lists', "Fetch HN list pages (/best x#{BEST_PAGES} + /news x#{NEWS_PAGES}, tiered sampling)") {
      options[:mode] = :lists
    }
    opts.on('--url URL', 'Fetch single HN post') { |v| options[:mode] = :url; options[:url] = v }
    opts.on('--fetch-article-url URL', 'Fetch single article URL, print content to stdout, exit') { |v|
      options[:mode] = :fetch_article_url; options[:url] = v
    }
    opts.on('--force', 'Force re-fetch, ignore cache') { options[:force] = true }
    opts.on('--jobs N', Integer, "Parallel workers (default: 5)") { |v| options[:jobs] = v }
    opts.on('--fetch-articles-simple', 'Use simple HTTP fetch (no renderer) for articles') {
      options[:fetch_articles_simple] = true
    }
    opts.on('--skip-articles', 'Skip article fetching entirely') {
      options[:skip_articles] = true
    }
    opts.on('--timeout N', Integer, "Read timeout in seconds for simple article fetch (default: 20)") { |v|
      options[:timeout] = v
    }
    opts.on('--fill-missing', 'Scan cache and fill missing articles via renderer') {
      options[:mode] = :fill_missing
    }
    opts.on('--poll-watching', 'Liveness poll for watching threads (resurrect on comment growth)') {
      options[:mode] = :poll_watching
    }
    opts.on('--hot-check', 'Scan cache for high-velocity stories, print TRIGGER lines, update state') {
      options[:mode] = :hot_check
    }
    opts.on('--daily-max N', Integer, "Max new hot triggers per day (default: 2)") { |v|
      options[:daily_max] = v
    }
    opts.on('-h', '--help') { puts opts; exit }
  end.parse!

  # ── --fetch-article-url mode: single URL to stdout ──
  if options[:mode] == :fetch_article_url
    result = extract_article_simple(options[:url],
                                    open_timeout: 8, read_timeout: options[:timeout])
    if result['fetch_status'] == 'success'
      puts result['content']
    else
      warn "ERROR: #{result['error'] || result['fetch_status']}"
      exit 1
    end
    return
  end

  # ── --fill-missing mode ──
  if options[:mode] == :fill_missing
    fill_missing_articles(jobs: options[:jobs])
    return
  end

  # ── --poll-watching mode ──
  if options[:mode] == :poll_watching
    poll_watching
    return
  end

  # ─-- --hot-check mode ──
  if options[:mode] == :hot_check
    hot_check(daily_max: options[:daily_max] || 2)
    return
  end

  unless options[:mode]
    warn "ERROR: use --lists, --url, --fetch-article-url, --fill-missing, --poll-watching, or --hot-check"
    exit 1
  end

  now = Time.now.utc
  puts "=" * 50
  puts "HN Data Fetcher"
  puts "Mode: #{options[:mode]}"
  puts "Date: #{now.strftime('%Y-%m-%d %H:%M UTC')}"
  puts "Jobs: #{options[:jobs]}"
  puts "=" * 50

  # ── --url mode: single HN post ──
  if options[:mode] == :url
    unless options[:url].match?(/news\.ycombinator\.com/)
      warn "ERROR: expected HN URL"
      exit 1
    end
    article_mode = options[:skip_articles] ? :skip :
                   options[:fetch_articles_simple] ? :simple : :renderer
    puts "\nFetching..."
    reg = load_registry
    status, result, err = fetch_and_cache(
      reg,
      options[:url],
      force: options[:force],
      article_mode: article_mode,
      simple_timeout: options[:timeout],
    )
    if status == :error
      warn "ERROR: #{err}"
      exit 1
    end
    print_result_line(result)

    archive_thread(reg, result['post'], result['comments'], result['article'])
    e = reg['threads'][result['post']['id'].to_s]
    if e
      e['last_activity'] = Time.now.utc.iso8601
      e['status'] = 'active'
      e['poll_streak'] = 0
    end
    save_registry(reg)

    puts "\nDone!"
    return
  end

  # ── --lists mode: /best p1-p2 (full tier) + /news p1-p2 (risers; >=80 full,
  #    50-79 lead = registry + snapshot only) ──
  puts "\n[1/3] Fetching HN lists (/best x#{BEST_PAGES}, /news x#{NEWS_PAGES})..."
  best_stories = fetch_stories_best
  puts "  best: #{best_stories.length} stories (score >= #{SCORE_THRESHOLD})"
  news_stories = fetch_stories_news
  full_news = []
  leads = []
  if news_stories
    best_ids = Set.new(best_stories.map { |s| s['id'] })
    news_extra = news_stories.reject { |s| best_ids.include?(s['id']) }
    full_news = news_extra.select { |s| s['score'] >= SCORE_THRESHOLD }
    leads = news_extra.select { |s| s['score'] < SCORE_THRESHOLD }
    puts "  news: #{news_stories.length} kept (score >= #{LEAD_SCORE_MIN}); " \
         "+#{full_news.length} full-fetch, +#{leads.length} leads (#{LEAD_SCORE_MIN}-#{SCORE_THRESHOLD - 1})"
  else
    warn '  news: scrape failed — degraded to best-only this run'
  end

  stories = best_stories + full_news                     # full-fetch tier
  sampled = (best_stories + Array(news_stories)).uniq { |s| s['id'] }  # snapshot/registry tier

  published = known_published_ids
  fresh = stories.reject { |s| published.include?(s['id']) }
  puts "  Dedup: #{stories.length - fresh.length} already in _articles/, #{fresh.length} remaining"

  stories.first(8).each do |s|
    url_tag = s['url'] ? ' [link]' : ' [text]'
    puts "    [#{s['score']}] #{s['title'][0, 70]}#{url_tag}"
  end
  leads.first(5).each do |s|
    puts "    [lead #{s['score']}] #{s['title'][0, 70]}"
  end

  article_mode = options[:skip_articles] ? :skip :
                 options[:fetch_articles_simple] ? :simple : :renderer

  puts "\n[2/3] Fetching discussions... (parallel: #{options[:jobs]} workers, article mode: #{article_mode})"

  reg = load_registry
  stats = process_stories_parallel(
    reg,
    stories,
    force: options[:force],
    article_mode: article_mode,
    jobs: options[:jobs],
    simple_timeout: options[:timeout],
  )

  unless stats[:error_details].empty?
    stats[:error_details].each { |line| warn line }
  end

  # ── Archive layer: snapshots + registry state machine + thread files ──
  # sampled (not stories): leads get time-series + registry rows too — that is
  # the whole point of the news tier (delta hot channel works off these)
  fetched_results = stats.delete(:fetched_results) || []
  append_snapshots(sampled)
  registry_update_from_stories(reg, sampled, fetched_results.map { |r| r['post'] })
  archived = fetched_results.map { |r| archive_thread(reg, r['post'], r['comments'], r['article']) }.compact
  save_registry(reg)
  counts = reg['threads'].values.group_by { |e| e['status'] }.transform_values(&:length)
  puts "  Archive: #{archived.length} threads updated, snapshots #{sampled.length} sampled"
  puts "  Registry: #{counts.map { |k, v| "#{k}=#{v}" }.sort.join(' ')}"

  puts "\n---"
  puts "Summary: #{stats[:fetched]} fetched, #{stats[:cached]} cached, #{stats[:articles_ok]} articles, #{stats[:errors]} errors"
end

# Entry point — skipped when required as a library (multi-source fetchers like
# lobsters-fetch.rb reuse the archive/article/registry layers defined above).
run unless ENV['HN_FETCH_AS_LIB'] == '1'
