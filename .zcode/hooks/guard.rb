#!/usr/bin/env ruby
# frozen_string_literal: true

# ZCode PreToolUse 守卫 — AGENTS.md「开发环境铁律」机械化层。
#
# 防的事故：agent 遇到认证/网络错误时试图"修环境"——改全局 git 配置、
# 换 remote URL、动 gh auth / SSH config。铁律原文：这些配置协同预置，
# 单点失败 ≠ 环境坏了，只报告不修复。
#
# 协议：stdin 收 JSON（tool_name + tool_input）；exit 0 放行、exit 2 拦截、
# 其余报错。守卫自身故障一律 fail-open（exit 0）——守卫挂了不阻塞会话，
# 铁律还有 AGENTS.md 行文层兜底。
#
# 本地测试：
#   echo '{"tool_name":"Bash","tool_input":{"command":"git config --global x y"}}' | ruby .zcode/hooks/guard.rb  # 期望 exit 2
#   echo '{"tool_name":"Bash","tool_input":{"command":"git status"}}' | ruby .zcode/hooks/guard.rb              # 期望 exit 0

require 'json'

begin
  input = JSON.parse($stdin.read)
  tool = input['tool_name'].to_s
  fields = input['tool_input'] || input['input'] || {}

  violations =
    case tool
    when 'Bash'
      cmd = fields['command'].to_s
      denied = []
      # git config 写全局/系统级（flag 前后夹 args 也抓；容忍 -c 短选项插在中间）
      denied << 'git config --global/--system（铁律：禁止修改全局/系统级 git 配置）' if cmd.match?(/\bgit\b[^|\n;]{0,40}\bconfig\b[^|\n;]*--(?:global|system)\b/)
      denied << 'git remote set-url/add/remove（铁律：remote 已预配置，禁止改动）' if cmd.match?(/\bgit\s+remote\s+(?:set-url|add|remove)\b/)
      denied << 'gh auth（铁律：GitHub CLI 认证已预配置，禁止改动）' if cmd.match?(/\bgh\s+auth\b/)
      # shell 直写受保护文件（重定向/tee/cp/mv/rm 等；读操作如 cat 不拦）
      denied << 'shell 直写 ~/.gitconfig 或 ~/.ssh/config（铁律：不得修改 SSH / git 全局配置）' if cmd.match?(/(?:>|\btee\b|\bcp\b|\bmv\b|\bdd\b|\brm\b|\bchmod\b|\bchown\b|\bsed\s+-i\b)[^|\n;]*(?:\.gitconfig\b|\.ssh\/config\b)/)
      denied
    when 'Edit', 'Write', 'MultiEdit', 'NotebookEdit'
      path = fields['file_path'].to_s
      home = Dir.home
      protected_files = ["#{home}/.ssh/config", "#{home}/.gitconfig"].map { |p| File.expand_path(p) }
      if protected_files.include?(File.expand_path(path))
        ["写入 #{path}（铁律：不得编辑 SSH / git 全局配置）"]
      else
        []
      end
    else
      []
    end

  if violations.any?
    warn "BLOCKED — 违反 AGENTS.md 开发环境铁律: #{violations.join('; ')}。配置失败只报告错误，不修环境。"
    exit 2
  end
rescue StandardError
  exit 0
end
exit 0
