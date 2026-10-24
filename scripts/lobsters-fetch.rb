#!/usr/bin/env ruby
# frozen_string_literal: true

# Lobsters fetcher — secondary professional-community source feeding the same
# hn-data archive (multi-source signal layer, phase-2 design). Reuses the HN
# fetcher's archive/registry/article layers via library mode.
#
# Ids are namespaced lo-<short_id>. Registry entries carry source: lobsters.
# Heat/clustering/cohort are source-aware (hn-heat.rb namespaces expert authors
# per source so cross-site username collisions can't fake "expert overlap").
#
# Usage:
#   ruby scripts/lobsters-fetch.rb --hottest [--max N] [--force] [--skip-articles]

ENV['HN_FETCH_AS_LIB'] = '1'
require_relative 'hn-fetch'

require 'nokogiri'

LO_BASE = 'https://lobste.rs'
LO_SCORE_MIN = 10
LO_MAX_DEFAULT = 15
LO_COMMENT_CAP = 100
LO_UA = 'Mozilla/5.0 (compatible; yuedulijie.com/1.0; trend tracker)'

def lo_get(path)
  uri = URI("#{LO_BASE}#{path}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.open_timeout = 10
  http.read_timeout = 20
  req = Net::HTTP::Get.new(uri.request_uri, { 'User-Agent' => LO_UA, 'Accept' => 'application/json' })
  resp = http.request(req)
  raise "HTTP #{resp.code}" unless resp.code.to_i == 200
  JSON.parse(resp.body)
end

def lo_flatten_comments(children, parent = '0', out = [])
  Array(children).each do |c|
    cid = c['short_id'].to_s
    text = Nokogiri::HTML(c['comment'].to_s).text.strip
    out << {
      'id' => "lo-#{cid}",
      'parent_id' => parent == '0' ? '0' : "lo-#{parent}",
      'author' => c['commenting_user'] || 'anonymous',
      'text' => text,
      'score' => c['score'].to_i,
      'posted_at' => c['created_at'] ? Time.parse(c['created_at']).utc.iso8601 : nil,
    } unless text.empty?
    lo_flatten_comments(c['children'], cid, out)
  end
  out
end

def run
  options = { max: LO_MAX_DEFAULT, force: false, skip_articles: false }
  require 'optparse'
  OptionParser.new do |opts|
    opts.banner = 'Usage: ruby scripts/lobsters-fetch.rb --hottest [--max N] [--force] [--skip-articles]'
    opts.on('--hottest', 'Fetch lobste.rs/hottest') {}
    opts.on('--max N', Integer, "Max stories (default: #{LO_MAX_DEFAULT})") { |v| options[:max] = v }
    opts.on('--force', 'Force refetch, ignore freshness') { options[:force] = true }
    opts.on('--skip-articles', 'Skip article extraction') { options[:skip_articles] = true }
  end.parse!

  now = Time.now.utc
  puts '=' * 50
  puts "Lobsters Fetcher — #{now.strftime('%Y-%m-%d %H:%M UTC')}"
  puts '=' * 50

  stories = lo_get('/hottest.json').select { |s| s['score'].to_i >= LO_SCORE_MIN }.first(options[:max])
  puts "#{stories.size} stories (score >= #{LO_SCORE_MIN})"

  reg = load_registry
  fetched = []
  stories.each do |s|
    id = "lo-#{s['short_id']}"
    e = reg['threads'][id]
    disc_url = "#{LO_BASE}/s/#{s['short_id']}"

    unless options[:force]
      if e && e['last_comment_count'] == s['comment_count'].to_i
        archived = load_archived_thread(id, reg)
        a_status = archived && archived['article'] && archived['article']['fetch_status']
        if %w[success skipped blocked not_found].include?(a_status)
          # fresh: refresh snapshot counters only
          e['last_score'] = s['score'].to_i
          puts "  #{id} \"#{s['title'].to_s[0, 50]}\" (#{s['score']} pts) — fresh"
          next
        end
      end
    end

    # full discussion fetch
    comments =
      begin
        disc = lo_get("/s/#{s['short_id']}.json")
        all = lo_flatten_comments(disc['comments'])
        all.sort_by { |c| -c['score'] }.first(LO_COMMENT_CAP)
      rescue => err
        warn "  #{id}: comments fetch failed (#{err.message}), archiving story without comments"
        []
      end

    article_data =
      if options[:skip_articles] || s['url'].to_s.empty?
        { 'fetch_status' => 'skipped' }
      else
        with_domain(URI.parse(s['url']).host) do
          extract_article_simple(s['url'])
        end
      end

    post_data = {
      'id' => id,
      'source' => 'lobsters',
      'title' => s['title'],
      'url' => s['url'],
      'hn_url' => disc_url,
      'score' => s['score'].to_i,
      'author' => s['submitter_user'].to_s,
      'posted_at' => s['created_at'] ? Time.parse(s['created_at']).utc.iso8601 : nil,
      'fetched_at' => now.iso8601,
      'article_url' => s['url'],
      'article_fetch_status' => article_data['fetch_status'],
      'article_fetched_at' => article_data['fetched_at'],
      'raw_comment_count' => s['comment_count'].to_i,
      'tags' => Array(s['tags']),
    }

    archive_thread(reg, post_data, { 'comments' => comments }, article_data)
    e = reg['threads'][id]
    e['source'] = 'lobsters'
    e['last_score'] = s['score'].to_i
    e['last_comment_count'] = s['comment_count'].to_i
    e['last_activity'] = now.iso8601
    e['status'] = 'active'
    fetched << post_data
    a_len = (article_data['content'] || '').length
    puts "  #{id} \"#{s['title'].to_s[0, 50]}\" (#{s['score']} pts, #{s['comment_count']} comments) — article #{article_data['fetch_status']}#{a_len.positive? ? " #{a_len}c" : ''}"
  end

  # snapshots: reuse the append-only series (id/t/s/c shape matches)
  append_snapshots(stories.map { |s|
    { 'id' => "lo-#{s['short_id']}", 'score' => s['score'].to_i, 'descendants' => s['comment_count'].to_i }
  })

  # aging: lobsters threads not seen on hottest for ACTIVE_WINDOW degrade via
  # the shared state machine on the next hn-fetch pass
  save_registry(reg)
  puts "\nSummary: #{fetched.size} fetched/refreshed, registry #{reg['threads'].size} threads"
end

run
