#!/usr/bin/env ruby
# frozen_string_literal: true

# hn-data archive pruner — policy: article content (target-site full text) is
# the only component whose long-term retention is both bulky and optional
# (re-fetchable on demand; copyright-adjacent). Comments/post/snapshots/heat
# are small and are the signal history: never pruned.
#
# Policy v1 (PRUNE_ARTICLE_DAYS = 365):
#   threads older than N days -> drop 'article' key (post+comments kept intact)
#   everything else -> report only
#
# Usage:
#   ruby scripts/hn-archive-prune.rb            # dry run (default): report only
#   ruby scripts/hn-archive-prune.rb --apply    # execute article stripping
#   ruby scripts/hn-archive-prune.rb --days N   # override age threshold

require 'yaml'
require 'time'
require 'fileutils'
require 'optparse'

ARCHIVE_DIR = ENV.fetch('HN_ARCHIVE_DIR', '.hn-archive')
THREADS_DIR = File.join(ARCHIVE_DIR, 'threads')

PRUNE_ARTICLE_DAYS = 365

options = { apply: false, days: PRUNE_ARTICLE_DAYS }
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby scripts/hn-archive-prune.rb [--apply] [--days N]'
  opts.on('--apply', 'Execute (default: dry run)') { options[:apply] = true }
  opts.on('--days N', Integer, "Age threshold (default: #{PRUNE_ARTICLE_DAYS})") { |v| options[:days] = v }
end.parse!

now = Time.now.utc
cutoff = now - options[:days] * 86400

# ── size report ──
sizes = Dir.children(THREADS_DIR).to_a
puts "Archive report (threshold #{options[:days]}d)#{options[:apply] ? ' [APPLY]' : ' [DRY]'}"
total = Dir.glob(File.join(ARCHIVE_DIR, '**', '*')).select { |f| File.file?(f) }.sum { |f| File.size(f) }
puts format('  total: %.1f MB', total / 1024.0 / 1024.0)
%w[snapshots threads heat cohort].each do |comp|
  d = File.join(ARCHIVE_DIR, comp)
  next unless Dir.exist?(d)
  s = Dir.glob(File.join(d, '**', '*')).select { |f| File.file?(f) }.sum { |f| File.size(f) }
  puts format('  %-10s %.2f MB', comp, s / 1024.0 / 1024.0)
end

# ── candidate scan ──
pruned = 0
freed = 0
skipped_active = 0
Dir.glob(File.join(THREADS_DIR, '*', 'W*', '*.yaml')).each do |path|
  t = (YAML.safe_load_file(path, permitted_classes: [Time]) rescue nil)
  next unless t && t['post']
  art = t['article']
  next unless art && art['content'] && !art['content'].empty?

  posted = t['post']['posted_at'] ? (Time.parse(t['post']['posted_at'].to_s) rescue nil) : nil
  posted ||= File.mtime(path)
  next if posted > cutoff

  bytes = art['content'].length
  if options[:apply]
    t.delete('article')
    t['article_pruned_at'] = now.iso8601
    tmp = path + '.tmp'
    File.write(tmp, YAML.dump(t))
    File.rename(tmp, path)
  end
  pruned += 1
  freed += bytes
  puts "  #{options[:apply] ? 'pruned' : 'would prune'} #{path.sub("#{ARCHIVE_DIR}/", '')} (-#{bytes / 1024} KB)"
end

puts "\n#{options[:apply] ? 'Pruned' : 'Would prune'} #{pruned} articles, freeing ~#{freed / 1024} KB"
puts 'Comments/snapshots/heat never pruned (signal history).' if options[:apply]
