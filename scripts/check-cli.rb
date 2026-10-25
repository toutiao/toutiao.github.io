#!/usr/bin/env ruby
# frozen_string_literal: true

# CLI 一致性守卫 — 调用处（workflows / Makefile / skills / AGENTS.md）用到的
# 每个 flag，必须在对应脚本的 OptionParser 声明中存在。
#
# 防的事故：脚本删/改名选项后忘改调用处 → CI 运行时才爆
# OptionParser::InvalidOption（2026-10-24 `--max` 事故：evolve 清理删了死选项，
# 两个 workflow 仍在传，fetch run 全线失败）。
#
# 另含 workflow 结构守卫：.github/workflows/*.yml 必须可解析且顶级键唯一。
# 防的事故：重复顶级键本地 YAML 解析器静默容忍（取后者），GitHub 严格校验
# 判整个 workflow 无效 → 定时任务静默不跑（2026-10-25 d8a36a1 重复
# concurrency 块，hn-auto/hn-weekly 失效，Actions 页只留路径名红 run）。
#
# Usage: ruby scripts/check-cli.rb   # exit 1 列出漂移；exit 0 通过

require 'yaml'

SCRIPTS = Dir['scripts/*.rb'].select { |f| File.read(f).include?('OptionParser') }
SITES = ['.github/workflows/*.yml', 'Makefile', 'AGENTS.md', '.opencode/skills/*/SKILL.md'].flat_map { |p| Dir[p] }

declared = SCRIPTS.to_h { |s|
  [File.basename(s), File.read(s).scan(/opts\.on\('--([a-z0-9-]+)/).flatten.uniq]
}
names = declared.keys.sort_by(&:length).reverse

bad = []
checked_lines = 0
checked_flags = 0

SITES.sort.each do |f|
  File.foreach(f).with_index do |line, i|
    m = line.match(/(#{names.map { |n| Regexp.escape(n) }.join('|')})/)
    next unless m
    # 只取脚本名之后的 flag，避免同行 docker/git 的 --rm/--hard 混入
    rest = line[m.end(0)..]
    flags = rest.scan(/(?<![\w-])--([a-z][a-z0-9-]*)/).flatten.uniq
    next if flags.empty?
    checked_lines += 1
    script = m[1]
    flags.each do |flag|
      checked_flags += 1
      unless declared[script].include?(flag)
        bad << "#{f}:#{i + 1} #{script} 收到未声明的 --#{flag}"
      end
    end
  end
end

puts "CLI check: #{SITES.size} 个调用文件, #{checked_lines} 条调用行, #{checked_flags} 个 flag 校验, #{SCRIPTS.size} 个脚本声明表"

# ── workflow 结构守卫：YAML 可解析 + 顶级键唯一（重复键 GitHub 判文件无效）──
wf_bad = []
Dir['.github/workflows/*.yml'].sort.each do |f|
  begin
    YAML.load_file(f)
  rescue StandardError => e
    wf_bad << "#{f}: YAML 解析失败 #{e.class}"
    next
  end
  keys = File.readlines(f).map { |l| l[/\A([A-Za-z_.-]+):\s*\z/, 1] }.compact
  dup = keys.tally.select { |_, n| n > 1 }.keys
  wf_bad << "#{f}: 重复顶级键 #{dup.join(',')}" unless dup.empty?
end
puts "Workflow check: #{Dir['.github/workflows/*.yml'].size} 个 workflow, 可解析性与顶级键唯一性校验"

if bad.empty? && wf_bad.empty?
  puts 'PASS — 调用处与脚本声明一致, workflow 结构合法'
else
  warn 'FAIL — 漂移清单:'
  (bad + wf_bad).each { |b| warn "  #{b}" }
  exit 1
end
