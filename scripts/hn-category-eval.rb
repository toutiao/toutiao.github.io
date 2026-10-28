#!/usr/bin/env ruby
# frozen_string_literal: true

# Category classification eval harness — keyword map vs LLM (AIHOT SelectBench
# analog, single-shot). Built now; run when enough threads have accumulated.
#
# Workflow:
#   1. ruby scripts/hn-category-eval.rb --sample 100
#        -> .hn-archive/eval/sample-<date>.jsonl  {id, title, url, keyword_category}
#        -> .hn-archive/eval/prompt-<date>.txt    classification prompt
#   2. LLM step (manual / future workflow):
#        opencode run "读取 .hn-archive/eval/sample-<date>.jsonl 与
#        prompt-<date>.txt，为每行输出 {\"id\":..., \"category\":...} 到
#        .hn-archive/eval/llm-<date>.jsonl，仅输出 jsonl 不写其他" --auto
#   3. ruby scripts/hn-category-eval.rb --grade <date>
#        -> agreement %, disagreement table, category distribution diff
#   4. (optional) --gold <file> to adjudicate disagreements: {id: category}
#
# No API keys needed for steps 1/3. Step 2 spends one LLM call per sample line.

require 'json'
require 'optparse'
require 'date'
require 'fileutils'

# Production classifier, required as lib — eval must grade the SAME matcher
# hn-heat.rb uses (a duplicated classifier here once had its own stopword list
# and its own host extraction, quietly drifting from prod).
ENV['HN_HEAT_AS_LIB'] = '1'
require_relative 'hn-heat'

EVAL_DIR = File.join(ARCHIVE_DIR, 'eval')

options = { sample: nil, grade: nil, gold: nil }
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby scripts/hn-category-eval.rb --sample N | --grade <date> [--gold file]'
  opts.on('--sample N', Integer, 'Draw N most-recent threads, write sample + prompt') { |v| options[:sample] = v }
  opts.on('--grade DATE', 'Grade llm-<DATE>.jsonl against sample-<DATE>.jsonl') { |v| options[:grade] = v }
  opts.on('--gold FILE', 'Adjudication map {id: category} (optional)') { |v| options[:gold] = v }
end.parse!

abort 'use --sample N or --grade <date>' if options[:sample].nil? && options[:grade].nil?

def load_category_names
  JSON.parse(File.read(CATEGORY_MAP_PATH))['categories'].map { |c| c['name'] } + ['other']
end

if options[:sample]
  reg = JSON.parse(File.read(REGISTRY_PATH))
  cmap = load_category_map

  classify = ->(title, url) { category_of(title, url, cmap) }

  pool = reg['threads'].values.sort_by { |e| e['first_seen'].to_s }.reverse
  sample = pool.first(options[:sample])

  date = Date.today.strftime('%Y-%m-%d')
  FileUtils.mkdir_p(EVAL_DIR)
  sample_path = File.join(EVAL_DIR, "sample-#{date}.jsonl")
  prompt_path = File.join(EVAL_DIR, "prompt-#{date}.txt")

  File.open(sample_path, 'w') do |f|
    sample.each do |e|
      f.puts(JSON.generate({
        'id' => e['hn_url'] || e['id'], 'title' => e['title'], 'url' => e['url'],
        'keyword_category' => classify.call(e['title'], e['url']),
      }))
    end
  end

  cats = load_category_names.join(', ')
  File.write(prompt_path, <<~PROMPT)
    你是技术新闻分类器。把每条讨论标题归入且仅归入以下类别之一：
    #{cats}

    规则：
    - 只依据标题与 URL 域名判断，不猜测内容
    - 拿不准 → other
    - 输出 JSONL，每行 {"id":"<原样返回>","category":"<类别>"}
  PROMPT

  puts "Sample: #{sample.size} threads -> #{sample_path}"
  puts "Prompt: #{prompt_path}"
  puts 'Next: run the LLM step (see script header), then --grade'
end

if options[:grade]
  date = options[:grade]
  sample_path = File.join(EVAL_DIR, "sample-#{date}.jsonl")
  llm_path = File.join(EVAL_DIR, "llm-#{date}.jsonl")
  abort "missing #{sample_path}" unless File.exist?(sample_path)
  abort "missing #{llm_path} (run the LLM step first)" unless File.exist?(llm_path)

  sample = File.readlines(sample_path).filter_map { |l| JSON.parse(l) rescue nil }.to_h { |r| [r['id'], r] }
  llm = File.readlines(llm_path).filter_map { |l| JSON.parse(l) rescue nil }.to_h { |r| [r['id'], r['category']] }
  gold = options[:gold] ? JSON.parse(File.read(options[:gold])) : nil

  agree = 0
  disagree = []
  sample.each do |id, row|
    kw = row['keyword_category']
    lm = llm[id]
    if lm.nil?
      disagree << [id, kw, '(llm missing)', row['title']]
      next
    end
    if kw == lm
      agree += 1
    else
      verdict = gold ? " → #{gold[id] || '?'}" : ''
      disagree << [id, kw, lm, row['title'], verdict].compact
    end
  end

  n = sample.size
  puts "Agreement: #{agree}/#{n} (#{n > 0 ? (agree * 100 / n) : 0}%)"
  unless disagree.empty?
    puts "\nDisagreements (id | keyword | llm | title#{gold ? ' | gold' : ''}):"
    disagree.first(30).each { |row| puts "  #{row.join(' | ')[0, 150]}" }
    puts "  ... #{disagree.size - 30} more" if disagree.size > 30
  end
  puts "\nGold adjudication: fix keyword map (scripts/category_map.json, bump version) or accept LLM side; then re-run."
end
