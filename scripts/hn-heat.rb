#!/usr/bin/env ruby
# frozen_string_literal: true

# HN Heat Engine — deterministic topic-heat derivation from the hn-data archive.
#
# Data flow (all reads/writes against the archive working copy, env HN_ARCHIVE_DIR):
#   threads/YYYY/WNN/<id>.yaml  →  comment arrival histogram (posted_at rebuild)
#   snapshots/YYYY/MM.jsonl     →  score velocity (only source of score history)
#   topics.json                 →  thread registry + topic clusters
#   cohort/WNN.json             →  expert commenter cohort (rolling 14d)
#   heat/YYYY-MM-DD.json        →  daily per-thread heat snapshot (rule_version'd)
#   _data/hn_trends.json        →  public projection (whitelisted fields only)
#   _data/hn_trends_7.json      →  7d companion (window-summed heat ranking)
#   _data/hn_trends_90.json     →  90d companion (window-summed heat ranking)
#   published.json              →  hn_id → article map (replaces _articles scans)
#
# Usage:
#   ruby scripts/hn-heat.rb --all                # cohort + day heat + clusters + projections
#   ruby scripts/hn-heat.rb --recompute          # rebuild every heat day AND topic clusters from raw signals
#   ruby scripts/hn-heat.rb --refresh-published  # rebuild published.json only
#   ruby scripts/hn-heat.rb --all [--window N]   # main window override (default 30)

require 'json'
require 'yaml'
require 'time'
require 'date'
require 'fileutils'
require 'optparse'
require 'set'
require 'uri'

$stdout.sync = true

ARCHIVE_DIR = ENV.fetch('HN_ARCHIVE_DIR', '.hn-archive')
REGISTRY_PATH = File.join(ARCHIVE_DIR, 'topics.json')
PUBLISHED_PATH = File.join(ARCHIVE_DIR, 'published.json')
SNAPSHOTS_DIR = File.join(ARCHIVE_DIR, 'snapshots')
THREADS_DIR = File.join(ARCHIVE_DIR, 'threads')
HEAT_DIR = File.join(ARCHIVE_DIR, 'heat')
COHORT_DIR = File.join(ARCHIVE_DIR, 'cohort')
TRENDS_PATH = ENV.fetch('HN_TRENDS_PATH', '_data/hn_trends.json')
TRENDS_PATH_7 = ENV.fetch('HN_TRENDS_PATH_7', '_data/hn_trends_7.json')
TRENDS_PATH_90 = ENV.fetch('HN_TRENDS_PATH_90', '_data/hn_trends_90.json')
# Companion windows written alongside the main projection every run; ranked by
# window-summed heat (the main file ranks by today's heat — the "now" view,
# companions answer "what was big this week / this quarter")
TRENDS_AUX_WINDOWS = { 7 => TRENDS_PATH_7, 90 => TRENDS_PATH_90 }.freeze
TRENDS_WINDOW_MAX = TRENDS_AUX_WINDOWS.keys.max
CATEGORY_MAP_PATH = ENV.fetch('HN_CATEGORY_MAP', File.join(__dir__, 'category_map.json'))

RULE_VERSION = 'v3'
WEIGHTS = { 'comment_vel' => 0.35, 'score_vel' => 0.25, 'expert' => 0.25, 'depth' => 0.15 }.freeze

COHORT_WINDOW_DAYS = 14   # rolling window for expert cohort membership
COHORT_MIN_THREADS = 2    # authors on >= 2 tracked threads within window = cohort
TOP_COMMENTS_FOR_EXPERT = 30
CLUSTER_MAX_AGE_DAYS = 60 # only threads posted within this window participate in clustering
CLUSTER_PAIR_MAX_GAP_DAYS = 30
TRENDS_WINDOW_DAYS_DEFAULT = 30
TRENDS_TOP_TOPICS = 50
TRENDS_TOP_THREADS = 20
TREND_DELTA_EPS = 0.15    # |delta| below this = flat
MIN_HEAT_FOR_ENTRY = 0.05

# Topic waves: >= 7d quiet gap splits the aggregated comment timeline; each
# segment with >= MIN_WAVE_COMMENTS arrivals counts as a wave (recurrence).
WAVE_GAP_DAYS = 7
MIN_WAVE_COMMENTS = 5

# Related topics: expert overlap >= max(3, 1% of cohort) = strong (cohort);
# single shared keyword = weak (keyword). Display-only, never merged.
RELATED_EXPERT_MIN = 3
RELATED_MAX = 3

STOPWORDS = %w[
  show ask hn tell the a an and or of to in for on with is are was were be been
  at by from as that this it its new how why what when where your you my our
  their about into over after before more most other some such no not only own
  same so than too very can will just dont should now using use used vs via
  get got make made all any because been being between during each few he her
  here him his i me she them then there these they we which while who whom
  why would could up down out off again further once
].freeze

# Tokens that recur across many UNRELATED stories: mega-brands, ubiquitous
# tech nouns, news-title filler. Two threads whose shared tokens are ALL from
# this set are different stories ("Google does X" vs "Google does Y") and
# never merge; a merge needs >= 1 distinctive shared token (or same story URL).
GENERIC_TOPIC_TOKENS = %w[
  google apple microsoft amazon meta facebook instagram whatsapp twitter
  youtube reddit linkedin netflix spotify tesla nvidia intel amd samsung ibm
  oracle adobe mozilla cloudflare
  openai anthropic gemini claude chatgpt gpt deepseek llama mistral qwen kimi
  ai llm llms model models agent agents
  data app apps api apis web internet online software hardware computer
  computers code coding programmer programming language languages framework
  open source free tech technology digital mobile cloud server servers
  browser phone android ios iphone windows mac linux docker python
  javascript typescript rust golang java
  says said report reports reporting reveal reveals revealed just like think
  people time world year years big small good bad best worst giant huge
  million billion millions billions video guide thing things together
  bringing inside story
].freeze

# ── Loaders ──

def load_registry
  if File.exist?(REGISTRY_PATH)
    data = (JSON.parse(File.read(REGISTRY_PATH)) rescue nil)
    return data if data.is_a?(Hash) && data['threads'].is_a?(Hash)
  end
  { 'version' => 1, 'updated_at' => nil, 'threads' => {}, 'topics' => [] }
end

def save_registry(reg)
  reg['version'] ||= 1
  reg['updated_at'] = Time.now.utc.iso8601
  FileUtils.mkdir_p(ARCHIVE_DIR)
  tmp = REGISTRY_PATH + '.tmp'
  File.write(tmp, JSON.pretty_generate(reg) + "\n")
  File.rename(tmp, REGISTRY_PATH)
end

def load_threads
  threads = {}
  Dir.glob(File.join(THREADS_DIR, '*', 'W*', '*.yaml')).each do |f|
    data = (YAML.safe_load_file(f, permitted_classes: [Time]) rescue nil)
    next unless data.is_a?(Hash)
    id = (data['post'] && data['post']['id'] || File.basename(f, '.yaml')).to_s
    threads[id] = { 'post' => data['post'] || {}, 'comments' => Array(data['comments']) }
  end
  threads
end

def snapshot_map(months: 3)
  now = Time.now.utc
  map = Hash.new { |h, k| h[k] = [] }
  months.times do |back|
    m = Date.new(now.year, now.month, 1) >> -back
    path = File.join(SNAPSHOTS_DIR, m.strftime('%Y'), "#{m.strftime('%m')}.jsonl")
    next unless File.exist?(path)
    File.readlines(path).each do |line|
      obj = (JSON.parse(line) rescue nil)
      next unless obj
      map[obj['id'].to_s] << { 't' => Time.parse(obj['t']), 's' => obj['s'].to_i, 'c' => obj['c'].to_i }
    end
  end
  map.each_value { |rows| rows.sort_by! { |r| r['t'] } }
  map
end

# ── Expert cohort (professional participation proxy) ──

def build_cohort(threads, reg, now = Time.now.utc)
  window_start = now - COHORT_WINDOW_DAYS * 86400
  authors = Hash.new { |h, k| h[k] = { 'threads' => Set.new, 'comments' => 0 } }

  reg['threads'].each do |id, e|
    next unless e['last_activity'] && Time.parse(e['last_activity']) >= window_start
    t = threads[id]
    next unless t
    src = e['source'] || 'hn'
    t['comments'].each do |c|
      next unless c['posted_at']
      next unless Time.parse(c['posted_at']) >= window_start
      a = c['author'].to_s
      next if a.empty? || a == 'anonymous'
      key = "#{src}:#{a}"  # namespace per source: cross-site name collisions
                        # must not fake "expert overlap"
      authors[key]['threads'] << id
      authors[key]['comments'] += 1
    end
  end

  cohort = authors.select { |_a, st| st['threads'].size >= COHORT_MIN_THREADS }
  yr, wk = nil, nil
  now_str = now.strftime('%G-W%V')
  payload = {
    'week' => now_str,
    'window_days' => COHORT_WINDOW_DAYS,
    'min_threads' => COHORT_MIN_THREADS,
    'generated_at' => now.iso8601,
    'cohort' => cohort.keys.sort,
    'members' => cohort.transform_values { |st| { 'threads' => st['threads'].size, 'comments' => st['comments'] } },
  }
  FileUtils.mkdir_p(COHORT_DIR)
  File.write(File.join(COHORT_DIR, "#{now_str}.json"), JSON.pretty_generate(payload) + "\n")
  Set.new(cohort.keys)
end

def load_cohort(now = Time.now.utc)
  # Latest cohort file within the current or previous ISO week
  now_str = now.strftime('%G-W%V')
  prev_str = (now - 7 * 86400).strftime('%G-W%V')
  [now_str, prev_str].each do |wk|
    path = File.join(COHORT_DIR, "#{wk}.json")
    next unless File.exist?(path)
    data = (JSON.parse(File.read(path)) rescue nil)
    return Set.new(data['cohort']) if data && data['cohort']
  end
  nil
end

# ── Per-thread signals ──

def compute_depths(comments)
  by_id = comments.to_h { |c| [c['id'], c] }
  depth = {}
  calc = lambda do |c|
    return depth[c['id']] if depth.key?(c['id'])
    parent = by_id[c['parent_id']]
    depth[c['id']] = parent ? calc.call(parent) + 1 : 1
  end
  comments.each { |c| calc.call(c) }
  depth
end

def percentile(values, p)
  return 0 if values.empty?
  sorted = values.sort
  idx = ((sorted.size - 1) * p).floor
  sorted[idx]
end

# Resurrection: post older than 14d with a >= 7d quiet gap followed by a
# (relatively recent) arrival — the "month-old thread is hot again" case.
def resurrected?(comment_times, posted_at, anchor)
  return false unless posted_at && comment_times.size >= 2
  post_time = Time.parse(posted_at)
  return false if anchor - post_time <= 14 * 86400
  sorted = comment_times.sort
  (1...sorted.size).each do |i|
    next unless sorted[i] - sorted[i - 1] >= 7 * 86400
    return true if anchor - sorted[i] <= 30 * 86400
  end
  false
end

def thread_signals(id, thread, reg_entry, cohort, snapshots, anchor = Time.now.utc)
  # Anchor horizon: a historical-day recompute must only see what existed by
  # that day — every downstream signal (vel/expert/depth/resurrected) derives
  # from this filtered set, else past days inherit future activity as a
  # constant fake floor (pre-birth threads glowed on every historical day).
  posted_at = thread && thread['post'] && thread['post']['posted_at'] || reg_entry && reg_entry['posted_at']
  return nil if posted_at && (Time.parse(posted_at) rescue nil).to_i > anchor.to_i
  comments = thread ? thread['comments'] : []
  comments = comments.select { |c|
    t = c['posted_at'] ? (Time.parse(c['posted_at']) rescue nil) : nil
    t && t <= anchor
  }
  times = comments.filter_map { |c| c['posted_at'] ? Time.parse(c['posted_at']) : nil }

  comment_vel = times.count { |t| t >= anchor - 86400 }

  # Score velocity from snapshot series (24h tail); nil when history too thin
  rows = (snapshots[id] || []).select { |r| r['t'] <= anchor }
  score_vel = nil
  if rows.size >= 2
    win = rows.last(2)
    gap_h = (win[-1]['t'] - win[-2]['t']) / 3600.0
    score_vel = ((win[-1]['s'] - win[-2]['s']) / gap_h).round(2) if gap_h > 0.5
  end

  # Expert ratio: authors of the top-N comments (by score) that are cohort
  # members — author keys namespaced by source (hn:alice vs lobsters:alice)
  src = (reg_entry && reg_entry['source']) || 'hn'
  top = comments.sort_by { |c| -(c['score'] || 0) }.first(TOP_COMMENTS_FOR_EXPERT)
  top_authors = top.map { |c| "#{src}:#{c['author'].to_s}" }
                  .reject { |a| a.end_with?(':') || a.end_with?(':anonymous') }.uniq
  expert_ratio = if cohort && !top_authors.empty?
                   (top_authors & cohort.to_a).size.to_f / top_authors.size
                 else
                   0.0
                 end

  depths = compute_depths(comments).values
  depth_p95 = percentile(depths, 0.95)

  {
    'comment_vel_24h' => comment_vel,
    'total_comments' => comments.size,
    'score_vel' => score_vel,
    'score_confidence' => score_vel ? 'ok' : 'low',
    'expert_ratio' => expert_ratio.round(3),
    'depth_p95' => depth_p95,
    'avg_depth' => (depths.empty? ? 0 : (depths.sum.to_f / depths.size).round(2)),
    'long_tail' => posted_at ? times.count { |t| t - Time.parse(posted_at) >= 7 * 86400 } : 0,
    'resurrected' => resurrected?(times, posted_at, anchor),
  }
end

def heat_value(signals)
  s = {
    'comment_vel' => Math.log(1 + signals['comment_vel_24h']),
    'score_vel' => Math.log(1 + (signals['score_vel'] || 0)),
    'expert' => signals['expert_ratio'] * 3.0,
    'depth' => Math.log(1 + signals['depth_p95']) / 1.5,
  }
  WEIGHTS.sum { |k, w| w * s[k] }.round(3)
end

# ── Daily heat file ──

def heat_path(day)
  File.join(HEAT_DIR, day.strftime('%Y-%m-%d.json'))
end

def compute_day(now, threads, reg, cohort, snapshots, day: nil)
  anchor = now
  entries = []
  reg['threads'].each do |id, e|
    next if e['status'] == 'settled' && day.nil? # daily run: settled threads still get
    # recomputed on --recompute (historical), but skipped for fresh days to save IO

    sig = thread_signals(id, threads[id], e, cohort, snapshots, anchor)
    next unless sig # thread not yet born at this day's anchor (recompute only)
    heat = heat_value(sig)
    next if heat < MIN_HEAT_FOR_ENTRY

    post = threads[id] ? threads[id]['post'] : {}
    entries << {
      'id' => id,
      'title' => e['title'] || post['title'],
      'hn_url' => e['hn_url'] || post['hn_url'],
      'status' => e['status'],
      'source' => e['source'] || 'hn',
      'category' => e['category'] || 'other',
      'posted_at' => e['posted_at'] || post['posted_at'],
      'heat' => heat,
      'signals' => sig,
    }
  end
  entries.sort_by! { |e| -e['heat'] }
  {
    'rule_version' => RULE_VERSION,
    'computed_at' => now.utc.iso8601,
    'entries' => entries,
  }
end

def write_day_heat(payload, day)
  FileUtils.mkdir_p(HEAT_DIR)
  tmp = heat_path(day) + '.tmp'
  File.write(tmp, JSON.pretty_generate(payload) + "\n")
  File.rename(tmp, heat_path(day))
end

def load_day_heat(day)
  path = heat_path(day)
  return nil unless File.exist?(path)
  JSON.parse(File.read(path))
rescue JSON::ParserError
  nil
end

def annotate_trends(entries, prev_entries)
  prev_heat = prev_entries ? prev_entries.each_with_object({}) { |e, h| h[e['id']] = e['heat'] } : {}
  now = Time.now.utc
  entries.each do |e|
    delta = prev_heat.key?(e['id']) ? (e['heat'] - prev_heat[e['id']]).round(3) : nil
    e['delta_24h'] = delta
    e['trend'] =
      if e['signals']['resurrected']
        'resurrected'
      elsif delta.nil?
        posted = e['posted_at'] ? (Time.parse(e['posted_at']) rescue nil) : nil
        posted && (now - posted) <= 3 * 86400 ? 'new' : 'flat'
      elsif delta > TREND_DELTA_EPS
        'up'
      elsif delta < -TREND_DELTA_EPS
        'down'
      else
        'flat'
      end
  end
  entries
end

# ── Deterministic industry categories (versioned keyword map, recomputable) ──

def load_category_map
  data = (JSON.parse(File.read(CATEGORY_MAP_PATH)) rescue nil)
  return { 'version' => 'none', 'categories' => [] } unless data.is_a?(Hash)
  data
end

def category_of(title, url, cmap, tags = [])
  # collapse spaced compounds so "data center" hits the "datacenter" keyword
  normalized = title.to_s.downcase.gsub(/\bdata\s*cent(?:er|re)s?\b/, 'datacenter')
  tokens = Set.new(topic_tokens(normalized) + Array(tags).map(&:to_s))
  host = begin
    URI.parse(url.to_s).host.to_s.downcase
  rescue StandardError
    ''
  end
  cmap['categories'].each do |cat|
    return cat['name'] if Array(cat['domains']).any? { |d| host.include?(d) }
    return cat['name'] if Array(cat['keywords']).any? { |k| tokens.include?(k) }
  end
  'other'
end

def assign_categories!(reg, threads, cmap)
  reg['category_version'] = cmap['version']
  reg['threads'].each do |id, e|
    tags = threads.dig(id, 'post', 'tags') || []
    e['category'] = category_of(e['title'] || threads.dig(id, 'post', 'title'), e['url'], cmap, tags)
  end
end

# ── Topic clustering: incremental merge into persistent topic entities ──

def topic_tokens(title)
  title.to_s.downcase.gsub(/[^a-z0-9\s]/, ' ').split.reject { |t|
    t.length < 3 || STOPWORDS.include?(t) || t =~ /^\d+$/
  }
end

def pair_same_topic?(tokens_a, tokens_b, posted_a, posted_b)
  shared = tokens_a & tokens_b
  return false if shared.empty?
  # Brand/common-noun overlap alone never implies one story: require >= 1
  # distinctive shared token (generic set: mega-brands + ubiquitous tech words)
  return false if shared.all? { |t| GENERIC_TOPIC_TOKENS.include?(t) }
  union = (tokens_a | tokens_b).size
  gap = (posted_a && posted_b) ? (posted_a - posted_b).abs : 0
  return false if gap > CLUSTER_PAIR_MAX_GAP_DAYS * 86400
  shared.size >= 2 || (shared.size == 1 && shared.size.to_f / union >= 0.5)
end

# Same story URL (host+path, query/trailing slash stripped) = strongest
# same-topic signal: covers cross-source reposts whose titles get reworded.
def canonical_url(u)
  return '' if u.to_s.empty?
  uri = (URI.parse(u.to_s) rescue nil)
  return '' unless uri && uri.host
  host = uri.host.downcase.sub(/\Awww\./, '')
  path = uri.path.to_s.sub(/\/+\z/, '')
  "#{host}#{path}"
end

def same_topic?(a, b)
  return true if !a[:url_key].empty? && a[:url_key] == b[:url_key]
  pair_same_topic?(a[:tokens], b[:tokens], a[:posted], b[:posted])
end

# Wave detection on a topic's aggregated comment timeline: segments separated
# by >= WAVE_GAP_DAYS quiet gaps, each with >= MIN_WAVE_COMMENTS arrivals.
def topic_wave_segments(thread_ids, threads)
  times = thread_ids.filter_map { |id|
    th = threads[id]
    th && th['comments']
  }.flatten
   .filter_map { |c| c['posted_at'] ? Time.parse(c['posted_at']) : nil }
   .sort
  return [] if times.size < MIN_WAVE_COMMENTS * 2
  segments = []
  seg = [times.first]
  times.each_cons(2) do |a, b|
    if b - a >= WAVE_GAP_DAYS * 86400
      segments << seg if seg.size >= MIN_WAVE_COMMENTS
      seg = []
    end
    seg << b
  end
  segments << seg if seg.size >= MIN_WAVE_COMMENTS
  segments.map { |s| { 's' => s.first.iso8601[0, 10], 'e' => s.last.iso8601[0, 10], 'n' => s.size } }
end

# Incremental: existing topics persist (stable topic_id, membership only grows);
# unclaimed recent threads match existing topics first, then cluster among
# themselves. Waves/keywords recomputed from full member set each run.
def merge_topics(threads, reg, now = Time.now.utc)
  topics = Array(reg['topics']).map { |t| t.dup }

  member_index = {}
  topics.each { |t| Array(t['hn_ids']).each { |id| member_index[id] = t } }

  candidates = reg['threads'].map { |id, e|
    posted = e['posted_at'] ? (Time.parse(e['posted_at']) rescue nil) : nil
    next nil unless posted && (now - posted) <= CLUSTER_MAX_AGE_DAYS * 86400
    next nil if member_index.key?(id)
    toks = topic_tokens(e['title'] || threads.dig(id, 'post', 'title') || '')
    next nil if toks.empty?
    { id: id, tokens: toks, posted: posted, first_seen: e['first_seen'],
      url_key: canonical_url(e['url']) }
  }.compact

  # Pass 1: join existing topics (member-token match, pairwise rule)
  member_posted = lambda { |id|
    p = reg['threads'][id] && reg['threads'][id]['posted_at']
    p ? (Time.parse(p) rescue nil) : nil
  }
  topics.each do |t|
    t['_tokens'] = Array(t['hn_ids']).map { |id|
      topic_tokens(reg['threads'][id] && reg['threads'][id]['title'] || '')
    }
    t['_urls'] = Set.new(Array(t['hn_ids']).filter_map { |id|
      k = canonical_url(reg['threads'][id] && reg['threads'][id]['url'])
      k.empty? ? nil : k
    })
  end
  joined = Set.new
  candidates.each do |c|
    topics.each do |t|
      next if joined.include?(c[:id])
      url_hit = !c[:url_key].empty? && t['_urls'].include?(c[:url_key])
      tok_hit = t['_tokens'].any? { |toks| pair_same_topic?(c[:tokens], toks, c[:posted], member_posted.call(t['hn_ids'].last)) }
      next unless url_hit || tok_hit
      t['hn_ids'] << c[:id]
      t['_tokens'] << c[:tokens]
      t['_urls'] << c[:url_key] unless c[:url_key].empty?
      t['last_seen'] = now.iso8601
      joined << c[:id]
      break
    end
  end

  # Pass 2: union-find among remaining candidates -> new topic entities
  rest = candidates.reject { |c| joined.include?(c[:id]) }
  parent = rest.each_with_object({}) { |c, h| h[c[:id]] = c[:id] }
  find = lambda do |x|
    parent[x] = x if parent[x].nil?
    parent[x] == x ? x : (parent[x] = find.call(parent[x]))
  end
  rest.each_with_index do |a, i|
    ((i + 1)...rest.size).each do |j|
      b = rest[j]
      ra, rb = find.call(a[:id]), find.call(b[:id])
      next if ra == rb
      parent[ra] = rb if same_topic?(a, b)
    end
  end
  groups = Hash.new { |h, k| h[k] = [] }
  rest.each { |c| groups[find.call(c[:id])] << c }
  groups.each_value do |members|
    next unless members.size >= 2
    members.sort_by! { |m| m[:posted] }
    topics << {
      'topic_id' => "t-#{members.first[:id]}",
      'hn_ids' => members.map { |m| m[:id] },
      'first_seen' => members.first[:first_seen],
      'last_seen' => now.iso8601,
    }
  end

  # Refresh derived fields; drop underscore scratch keys; keep only >= 2 members
  topics.map! do |t|
    t['hn_ids'].uniq!
    next nil if t['hn_ids'].size < 2
    all_tokens = t['hn_ids'].map { |id| topic_tokens(reg['threads'][id] && reg['threads'][id]['title'] || '') }
    shared = all_tokens.reduce { |acc, toks| acc & toks }
    t['keywords'] = (shared.empty? ? (all_tokens.first || []) : shared).first(5)
    t['waves'] = topic_wave_segments(t['hn_ids'], threads)
    t.delete_if { |k, _| k.start_with?('_') }
    t
  end.compact!
  topics.sort_by { |t| -t['hn_ids'].size }
end

# ── Public projection (whitelist only — never raw comment text) ──

def refresh_published
  require 'time'
  map = {}
  Dir.glob('_articles/**/*.md').each do |f|
    content = File.read(f)
    fm = content[%r{\A---\s*\n(.*?)\n---}m, 1] || ''
    date = fm[/^date:\s*['"]?(\d{4}-\d{2}-\d{2})/, 1] || File.basename(f)[/\d{4}-\d{2}-\d{2}/]
    slug = File.basename(f, '.md')
    ids = content.to_enum(:scan, /hn_id:\s*"?(?<hn>\d+)"?|item\?id=(?<hn2>\d+)|lobste\.rs\/s\/(?<lo>[a-z0-9]+)/).map { Regexp.last_match }
                 .map { |m| m[:hn] || m[:hn2] || (m[:lo] ? "lo-#{m[:lo]}" : nil) }
                 .compact.uniq
    ids.each do |id|
      # permalink /articles/:year/:name has NO trailing slash (site-wide:
      # post.url is slash-less too); the directory-style "/.../" form 404s on
      # Pages — keep in sync with _config.yml
      map[id] = { 'date' => date, 'slug' => slug, 'url' => "/articles/#{date.to_s[0, 4]}/#{slug}" }
    end
  end
  FileUtils.mkdir_p(ARCHIVE_DIR)
  File.write(PUBLISHED_PATH, JSON.pretty_generate({
    'updated_at' => Time.now.utc.iso8601,
    'hn_ids' => map,
  }) + "\n")
  puts "Published map: #{map.size} articles indexed -> #{PUBLISHED_PATH}"
  map
end

def load_published
  return {} unless File.exist?(PUBLISHED_PATH)
  data = (JSON.parse(File.read(PUBLISHED_PATH)) rescue nil)
  data && data['hn_ids'] || {}
end

# Resolve "%m-%d" curve labels to day offsets from the first point. Labels are
# year-agnostic; a label that jumps backwards (12-31 -> 01-01) rolls one year
# forward, so windows crossing New Year stay monotonic.
def curve_day_offsets(curve)
  offsets = []
  prev = nil
  curve.each do |p|
    m, d = p['d'].to_s.split('-').map(&:to_i)
    cur = (m.between?(1, 12) && d.between?(1, 31)) ? Date.new(2000, m, d) : nil
    if cur.nil?
      offsets << (offsets[-1] || 0)
      next
    end
    cur = cur.next_year if prev && cur < prev
    offsets << (prev ? (cur - prev).to_i + offsets[-1] : 0)
    prev = cur
  end
  offsets
end

def sparkline_points(curve, width: 100, height: 28, pad: 2)
  return '' if curve.empty?
  hs = curve.map { |p| p['h'] }
  max_h = [hs.max, 0.001].max
  # x follows real elapsed days, not point index — quiet gaps stay gaps, so a
  # recurring topic (wave N days later) renders with its true spacing
  offsets = curve_day_offsets(curve)
  span = [offsets.last.to_i, 1].max
  curve.each_with_index.map { |p, i|
    x = curve.size == 1 ? width / 2.0 : pad + (width - 2 * pad) * offsets[i] / span.to_f
    y = height - pad - (height - 2 * pad) * (p['h'] / max_h)
    "#{x.round(1)},#{y.round(1)}"
  }.join(' ')
end

# Per-day thread heat map shared by every projection window (loading 90 day
# files once instead of once per window)
def load_per_day_thread_heat(today_payload, today, max_window)
  map = Hash.new { |h, d| h[d] = {} }
  (max_window - 1).downto(0) do |back|
    d = today - back
    payload = (d == today) ? today_payload : load_day_heat(d)
    next unless payload
    payload['entries'].each { |e| map[d][e['id']] = e['heat'] }
  end
  map
end

def build_trends(threads, reg, today_payload, now = Time.now.utc, window: TRENDS_WINDOW_DAYS_DEFAULT, cohort: nil,
                 path: TRENDS_PATH, per_day: nil)
  published = load_published
  today = now.to_date
  entries = today_payload['entries']

  # Daily curves from historical heat files (shared across windows)
  per_day_thread_heat = per_day || load_per_day_thread_heat(today_payload, today, window)

  # Topic aggregation: persistent cluster topics + singleton topics for uncovered threads
  topics = reg['topics'] || []
  topic_meta = topics.each_with_object({}) { |t, h| h[t['topic_id']] = t }
  topic_of = {}
  topics.each { |t| t['hn_ids'].each { |id| topic_of[id] = t['topic_id'] } }

  heat_by_id = entries.each_with_object({}) { |e, h| h[e['id']] = e }
  topic_members = Hash.new { |h, k| h[k] = [] }
  heat_by_id.each_key do |id|
    topic_members[topic_of[id] || "t-#{id}"] << id
  end

  topic_entries = topic_members.map do |tid, ids|
    members = ids.map { |id| heat_by_id[id] }.compact
    next nil if members.empty?
    heat = members.sum { |m| m['heat'] }.round(3)
    deltas = members.filter_map { |m| m['delta_24h'] }
    delta = deltas.empty? ? nil : deltas.sum.round(3)
    trend = members.any? { |m| m['trend'] == 'resurrected' } ? 'resurrected'
            : members.any? { |m| m['trend'] == 'new' } ? 'new'
            : delta && delta > TREND_DELTA_EPS ? 'up'
            : delta && delta < -TREND_DELTA_EPS ? 'down' : 'flat'
    curve = (window - 1).downto(0).filter_map do |back|
      d = today - back
      v = ids.sum { |id| per_day_thread_heat[d][id] || 0 }.round(3)
      v > 0 ? { 'd' => d.strftime('%m-%d'), 'h' => v } : nil
    end
    rep = members.max_by { |m| m['heat'] }
    # 解读 must match the headline: prefer the representative thread's own
    # article; only fall back to any member article (same-story cluster) —
    # never cross-link a different story's article under this title.
    article = published[rep['id']] || ids.filter_map { |id| published[id] }.max_by { |a| a['date'].to_s }
    meta = topic_meta[tid] || {}
    peak = curve.max_by { |p| p['h'] }
    {
      'topic_id' => tid,
      'title' => rep['title'],
      'keywords' => meta['keywords'] || [],
      'thread_count' => ids.size,
      'heat' => heat,
      'delta_24h' => delta,
      'trend' => trend,
      'waves' => Array(meta['waves']).size,
      'peak_at' => peak && peak['d'],
      'curve' => curve,
      'sparkline' => sparkline_points(curve),
      'threads' => members.map { |m|
        { 'id' => m['id'], 'title' => m['title'], 'hn_url' => m['hn_url'],
          'status' => m['status'], 'heat' => m['heat'], 'trend' => m['trend'],
          'source' => m['source'], 'posted_at' => m['posted_at'] }
      },
      'article' => article,
    }
  end.compact.sort_by { |t| -t['heat'] }
  kept = topic_entries.first(TRENDS_TOP_TOPICS)
  kept.each { |t| t['related'] = related_for(t, kept, threads, cohort) }

  # Industry aggregates (deterministic category map, see category_map.json)
  industries = industry_curves(reg, per_day_thread_heat, kept, today, window)

  counts = reg['threads'].values.group_by { |e| e['status'] }.transform_values(&:length)
  assigned = reg['threads'].count { |_id, e| e['category'] && e['category'] != 'other' }
  projection = {
    'generated_at' => now.utc.iso8601,
    'rule_version' => RULE_VERSION,
    'category_version' => reg['category_version'],
    'window_days' => window,
    'stats' => {
      'threads_tracked' => reg['threads'].size,
      'active' => counts['active'] || 0,
      'watching' => counts['watching'] || 0,
      'cold' => counts['cold'] || 0,
      'deep' => counts['deep'] || 0,
      'settled' => counts['settled'] || 0,
      'topics' => topics.size,
      'cohort_size' => cohort ? cohort.size : nil,
      'category_coverage' => reg['threads'].empty? ? 0 : (assigned * 100 / reg['threads'].size),
    },
    'industries' => industries,
    'topics' => kept,
    'top_threads' => annotate_public(entries.first(TRENDS_TOP_THREADS), published),
  }
  FileUtils.mkdir_p(File.dirname(path))
  tmp = path + '.tmp'
  File.write(tmp, JSON.pretty_generate(projection) + "\n")
  File.rename(tmp, path)
  puts "Trends projection: #{topic_entries.size} topics (#{industries.size} industries), " \
       "top #{kept.size} kept -> #{path}"
  projection
end

# Related topics: display-only graph. Strong edge = expert-cohort overlap
# (same professionals commenting across both topics); weak edge = shared keyword.
def related_for(topic, topic_entries, threads, cohort)
  return [] unless cohort && !cohort.empty?
  expert_authors = lambda do |ids|
    ids.filter_map { |id| t = threads[id] }
       .map { |t| t['comments'].sort_by { |c| -(c['score'] || 0) }.first(TOP_COMMENTS_FOR_EXPERT) }
       .flatten
       .map { |c| c['author'].to_s }
       .reject { |a| a.empty? || a == 'anonymous' }
       .select { |a| cohort.include?(a) }
       .uniq
  end
  threshold = [RELATED_EXPERT_MIN, (cohort.size * 0.01).ceil].max
  my_experts = expert_authors.call(topic['threads'].map { |t| t['id'] })
  return [] if my_experts.empty?
  my_tokens = Set.new(topic_tokens(topic['title']) + Array(topic['keywords']))

  scored = topic_entries.reject { |t| t['topic_id'] == topic['topic_id'] }.filter_map do |t|
    overlap = (my_experts & expert_authors.call(t['threads'].map { |x| x['id'] })).size
    if overlap >= threshold
      { 'topic_id' => t['topic_id'], 'title' => t['title'], 'via' => 'cohort', 'strength' => overlap }
    elsif !(my_tokens & Set.new(topic_tokens(t['title']) + Array(t['keywords']))).empty?
      { 'topic_id' => t['topic_id'], 'title' => t['title'], 'via' => 'keyword', 'strength' => 1 }
    end
  end
  scored.sort_by! { |r| [-r['strength'], r['via'] == 'cohort' ? 0 : 1] }
  scored.first(RELATED_MAX).map { |r| { 'topic_id' => r['topic_id'], 'title' => r['title'], 'via' => r['via'] } }
end

def industry_curves(reg, per_day_thread_heat, topic_entries, today, window)
  cat_of_thread = {}
  reg['threads'].each { |id, e| cat_of_thread[id] = e['category'] || 'other' }
  topic_of_thread = {}
  Array(reg['topics']).each { |t| t['hn_ids'].each { |id| topic_of_thread[id] = t['topic_id'] } }
  topic_heat = topic_entries.each_with_object({}) { |t, h| h[t['topic_id']] = t }

  by_cat = Hash.new { |h, k| h[k] = Hash.new { |h2, k2| h2[k2] = 0.0 } }
  per_day_thread_heat.each do |d, heats|
    heats.each do |id, heat|
      by_cat[cat_of_thread[id] || 'other'][d] += heat
    end
  end

  by_cat.map do |cat, daily|
    today_heat = (daily[today] || 0.0).round(3)
    delta7 = (today_heat - (daily[today - 7] || 0.0)).round(3)
    curve = (window - 1).downto(0).filter_map do |back|
      d = today - back
      v = daily[d].to_f.round(3)
      v > 0 ? { 'd' => d.strftime('%m-%d'), 'h' => v } : nil
    end
    driver_ids = (per_day_thread_heat[today] || {}).keys.select { |id| (cat_of_thread[id] || 'other') == cat }
    drivers = driver_ids.filter_map { |id|
      t = topic_heat[topic_of_thread[id]]
      t ? { 'topic_id' => t['topic_id'], 'title' => t['title'], 'heat' => t['heat'] } : nil
    }.sort_by { |t| -t['heat'] }.uniq { |t| t['topic_id'] }.first(3)
    {
      'category' => cat,
      'heat' => today_heat,
      'delta_7d' => delta7,
      'trend' => delta7 > 0.3 ? 'up' : delta7 < -0.3 ? 'down' : 'flat',
      'curve' => curve,
      'sparkline' => sparkline_points(curve),
      'top_topics' => drivers,
    }
  end.sort_by { |c| -c['heat'] }
end

# ── Companion window projections (7d / 90d): ranked by window-SUMMED heat ──
# Unlike the main projection (built from today's entries — the "now" view),
# companions aggregate the per-day heat series, so a topic that peaked mid-week
# and went quiet today still shows up with its full window weight.

def window_industry_curves(reg, per_day, topic_entries, today, window)
  days = (window - 1).downto(0).map { |back| today - back }
  cat_of_thread = {}
  reg['threads'].each { |id, e| cat_of_thread[id] = e['category'] || 'other' }
  topic_of_thread = {}
  Array(reg['topics']).each { |t| Array(t['hn_ids']).each { |id| topic_of_thread[id] = t['topic_id'] } }
  topic_heat = topic_entries.each_with_object({}) { |t, h| h[t['topic_id']] = t }

  by_cat = Hash.new { |h, k| h[k] = Hash.new(0.0) }
  days.each do |d|
    per_day[d].each do |id, heat|
      by_cat[cat_of_thread[id] || 'other'][d] += heat
    end
  end

  by_cat.map do |cat, daily|
    curve = days.filter_map do |d|
      v = daily[d].to_f.round(3)
      v.positive? ? { 'd' => d.strftime('%m-%d'), 'h' => v } : nil
    end
    heat = curve.sum { |p| p['h'] }.round(3)
    delta7 = ((daily[today] || 0.0) - (daily[today - 7] || 0.0)).round(3)
    drivers = topic_entries.select { |t|
      t['threads'].any? { |th| (cat_of_thread[th['id']] || 'other') == cat }
    }.first(3).map { |t| { 'topic_id' => t['topic_id'], 'title' => t['title'], 'heat' => t['heat'] } }
    {
      'category' => cat,
      'heat' => heat,
      'delta_7d' => delta7,
      'trend' => delta7 > 0.3 ? 'up' : delta7 < -0.3 ? 'down' : 'flat',
      'curve' => curve,
      'sparkline' => sparkline_points(curve),
      'top_topics' => drivers,
    }
  end.sort_by { |c| -c['heat'] }
end

def build_window_projection(threads, reg, per_day, window:, now: Time.now.utc, path:,
                            top: TRENDS_TOP_TOPICS)
  published = load_published
  today = now.to_date
  days = (window - 1).downto(0).map { |back| today - back }

  topics = Array(reg['topics'])
  topic_meta = topics.each_with_object({}) { |t, h| h[t['topic_id']] = t }
  topic_of = {}
  topics.each { |t| Array(t['hn_ids']).each { |id| topic_of[id] = t['topic_id'] } }

  buckets = Hash.new { |h, k| h[k] = [] }
  seen = {}
  days.each do |d|
    per_day[d].each_key do |id|
      next if seen[id]
      seen[id] = true
      buckets[topic_of[id] || "t-#{id}"] << id
    end
  end

  window_heat_of = lambda { |id|
    days.sum { |d| per_day[d][id] || 0 }.round(3)
  }

  topic_entries = buckets.map do |tid, ids|
    curve = days.filter_map do |d|
      v = ids.sum { |id| per_day[d][id] || 0 }.round(3)
      v.positive? ? { 'd' => d.strftime('%m-%d'), 'h' => v } : nil
    end
    next nil if curve.empty?

    today_heat = ids.sum { |id| per_day[today][id] || 0 }.round(3)
    yday_heat = ids.sum { |id| per_day[today - 1][id] || 0 }.round(3)
    delta_24h = (today_heat - yday_heat).round(3)
    rep = ids.max_by { |id| window_heat_of.call(id) }
    rep_entry = reg['threads'][rep] || {}
    posted = rep_entry['posted_at'] ? (Time.parse(rep_entry['posted_at']) rescue nil) : nil
    trend = if posted && (now - posted) <= 3 * 86400 then 'new'
            elsif delta_24h > TREND_DELTA_EPS then 'up'
            elsif delta_24h < -TREND_DELTA_EPS then 'down'
            else 'flat'
            end
    peak = curve.max_by { |p| p['h'] }
    meta = topic_meta[tid] || {}
    # 解读 must match the headline: prefer the representative thread's own article
    article = published[rep] || ids.filter_map { |id| published[id] }.max_by { |a| a['date'].to_s }
    {
      'topic_id' => tid,
      'title' => rep_entry['title'] || meta['keywords'].to_a.first,
      'keywords' => meta['keywords'] || [],
      'thread_count' => ids.size,
      'heat' => curve.sum { |p| p['h'] }.round(3),
      'delta_24h' => delta_24h,
      'trend' => trend,
      'waves' => Array(meta['waves']).size,
      'peak_at' => peak && peak['d'],
      'curve' => curve,
      'sparkline' => sparkline_points(curve),
      'threads' => ids.sort_by { |id| -window_heat_of.call(id) }.filter_map { |id|
        e = reg['threads'][id]
        next nil unless e
        { 'id' => id, 'title' => e['title'], 'hn_url' => e['hn_url'], 'status' => e['status'],
          'source' => e['source'] || 'hn', 'posted_at' => e['posted_at'], 'heat' => window_heat_of.call(id) }
      },
      'article' => article,
    }
  end.compact.sort_by { |t| -t['heat'] }
  kept = topic_entries.first(top)

  industries = window_industry_curves(reg, per_day, kept, today, window)

  counts = reg['threads'].values.group_by { |e| e['status'] }.transform_values(&:length)
  projection = {
    'generated_at' => now.utc.iso8601,
    'rule_version' => RULE_VERSION,
    'category_version' => reg['category_version'],
    'window_days' => window,
    'stats' => {
      'threads_tracked' => reg['threads'].size,
      'active' => counts['active'] || 0,
      'watching' => counts['watching'] || 0,
      'cold' => counts['cold'] || 0,
      'deep' => counts['deep'] || 0,
      'settled' => counts['settled'] || 0,
      'topics' => topics.size,
    },
    'industries' => industries,
    'topics' => kept,
  }
  FileUtils.mkdir_p(File.dirname(path))
  tmp = path + '.tmp'
  File.write(tmp, JSON.pretty_generate(projection) + "\n")
  File.rename(tmp, path)
  puts "Window projection (#{window}d): #{topic_entries.size} topics (#{industries.size} industries), " \
       "top #{kept.size} kept -> #{path}"
  projection
end

def annotate_public(entries, published)
  entries.map { |e|
    {
      'id' => e['id'], 'title' => e['title'], 'hn_url' => e['hn_url'],
      'status' => e['status'], 'source' => e['source'], 'heat' => e['heat'], 'trend' => e['trend'],
      'delta_24h' => e['delta_24h'],
      'comment_vel_24h' => e['signals']['comment_vel_24h'],
      'expert_ratio' => e['signals']['expert_ratio'],
      'total_comments' => e['signals']['total_comments'],
      'article' => published[e['id']],
    }
  }
end

# ── CLI ──

def run
  options = { mode: nil, window: Integer(ENV.fetch('HN_TRENDS_WINDOW', TRENDS_WINDOW_DAYS_DEFAULT)) }
  OptionParser.new do |opts|
    opts.banner = 'Usage: ruby scripts/hn-heat.rb --all [--window N] | --recompute | --refresh-published'
    opts.on('--all', 'Cohort + daily heat + topic merge + trends projection + published map') { options[:mode] = :all }
    opts.on('--recompute', 'Rebuild every heat day and topic clusters from raw signals (after rule change)') { options[:mode] = :recompute }
    opts.on('--refresh-published', 'Rebuild published.json only') { options[:mode] = :refresh_published }
    opts.on('--window N', Integer, "Trends window in days (default: #{TRENDS_WINDOW_DAYS_DEFAULT})") { |v| options[:window] = v }
    opts.on('-h', '--help') { puts opts; exit }
  end.parse!

  unless options[:mode]
    warn 'ERROR: use --all, --recompute, or --refresh-published'
    exit 1
  end

  if options[:mode] == :refresh_published
    refresh_published
    return
  end

  now = Time.now.utc
  reg = load_registry
  threads = load_threads
  snapshots = snapshot_map

  puts "HN Heat Engine — #{RULE_VERSION} | #{threads.size} threads archived, #{reg['threads'].size} registered"

  if options[:mode] == :recompute
    # Topic clusters are derived signals too: rebuild them from scratch so a
    # clustering-rule change (RULE_VERSION bump) re-derives membership — the
    # incremental merge below never splits a stale cluster.
    reg['topics'] = []
    # Re-derive every historical day from raw signals (comment posted_at history
    # + snapshot series), honoring each day's own time anchor.
    earliest = reg['threads'].values.filter_map { |e| e['posted_at'] ? Time.parse(e['posted_at']) : nil }.min
    if earliest
      day = earliest.to_date + 1
      while day <= now.to_date
        anchor = day.to_time + 86399 # end of that day
        payload = compute_day(anchor, threads, reg, nil, snapshots, day: anchor)
        payload['computed_at'] = anchor.utc.iso8601
        write_day_heat(payload, day)
        day += 1
      end
      puts "Recompute: rebuilt heat files from #{earliest.to_date} to #{now.to_date}"
    end
    # fall through to today's fresh pass + trends
  end

  cmap = load_category_map
  assign_categories!(reg, threads, cmap)
  puts "Categories: #{cmap['version']}, coverage #{reg['threads'].count { |_id, e| e['category'] != 'other' }}/#{reg['threads'].size}"

  cohort = build_cohort(threads, reg, now)
  puts "Cohort: #{cohort.size} expert commenters (>= #{COHORT_MIN_THREADS} threads in #{COHORT_WINDOW_DAYS}d)"

  today_payload = compute_day(now, threads, reg, cohort, snapshots)
  prev_payload = load_day_heat(now.to_date - 1)
  annotate_trends(today_payload['entries'], prev_payload && prev_payload['entries'])
  write_day_heat(today_payload, now.to_date)
  puts "Day heat: #{today_payload['entries'].size} entries -> #{heat_path(now.to_date)}"

  reg['topics'] = merge_topics(threads, reg, now)
  save_registry(reg)
  waves = reg['topics'].count { |t| Array(t['waves']).size > 1 }
  puts "Topics: #{reg['topics'].size} multi-thread (#{waves} recurring waves)"

  refresh_published if options[:mode] == :all
  per_day = load_per_day_thread_heat(today_payload, now.to_date, [options[:window], TRENDS_WINDOW_MAX].max)
  build_trends(threads, reg, today_payload, now, window: options[:window], cohort: cohort, per_day: per_day)
  # Companion windows (7d weekly / 90d quarterly), window-summed ranking;
  # skipped when the main window already covers that granularity
  TRENDS_AUX_WINDOWS.each do |days, path|
    next if days == options[:window]
    build_window_projection(threads, reg, per_day, window: days, now: now, path: path)
  end
end

run
