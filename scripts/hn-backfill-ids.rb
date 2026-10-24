#!/usr/bin/env ruby
# frozen_string_literal: true

# Backfill hn_id front matter into legacy articles that predate the hn_id
# convention. Idempotent: skips files that already have hn_id.
#
# Rule (in order):
#   1. 引用帖子 table row labelled "HN 讨论帖" → its item?id= (cluster articles
#      may have several; the first HN row is the primary discussion)
#   2. 引用帖子 section: exactly one unique item?id=
#   3. body: first item?id= (Ask-HN-style articles where the post IS the story)
#
# Usage: ruby scripts/hn-backfill-ids.rb [--dry]

require 'optparse'

dry = false
OptionParser.new { |o| o.on('--dry') { dry = true } }.parse!

stats = { backfilled: 0, skipped_has_id: 0, no_id_found: 0, dry: dry }

Dir.glob('_articles/**/*.md').sort.each do |f|
  content = File.read(f)

  if content =~ /^hn_id:/
    stats[:skipped_has_id] += 1
    next
  end

  fm_end = content.index(/^---\s*$/, 4)
  next unless fm_end

  hn_id =
    # 1. labelled HN row in the 引用帖子 table
    content.scan(/^\|\s*\d+\s*\|[^|]*HN[^|]*\|[^|]*item\?id=(\d+)/).flatten.first ||
    # 2. 引用帖子 section with a single unique id
    begin
      sec = content[/^## 引用帖子.*?(?=^## |\Z)/m] || ''
      ids = sec.scan(/item\?id=(\d+)/).flatten.uniq
      ids.size == 1 ? ids.first : nil
    end ||
    # 3. first body id
    content[/item\?id=(\d+)/, 1]

  if hn_id.nil?
    stats[:no_id_found] += 1
    warn "no id: #{f}"
    next
  end

  fm = content[0...fm_end]
  date_line = fm[/^date:.*$/]
  inject = "hn_id: '#{hn_id}'\n"
  if date_line
    new_fm = fm.sub(date_line) { date_line + "\n" + inject.rstrip }
  else
    new_fm = fm + "\n" + inject
  end
  new_content = new_content = new_fm + content[fm_end..]

  unless dry
    File.write(f, new_content)
  end
  stats[:backfilled] += 1
  puts "#{dry ? '[dry] ' : ''}hn_id=#{hn_id} -> #{f}"
end

puts "\nBackfill: #{stats[:backfilled]} filled, #{stats[:skipped_has_id]} already had id, #{stats[:no_id_found]} without id"
