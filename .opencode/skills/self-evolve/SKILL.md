---
name: self-evolve
description: Agent self-review cycle that audits configs, identifies improvements, and applies them automatically
metadata:
  domain: meta
  cycle: continuous
---

## Scope
Audit and improve:
- `.opencode/agents/*.md` — prompt effectiveness, permission appropriateness, capability gaps
- `.opencode/skills/*/SKILL.md` — description vs actual behavior, discoverability, usefulness
- `opencode.jsonc` commands — template quality, agent routing
- `.zcode/agents/*.md`, `.zcode/commands/*.md`, `.zcode/config.json`, `.zcode/hooks/guard.rb` — ZCode 运行时栈（skill 正文唯一真源在 `.opencode/skills/`，`.zcode/skills/*/SKILL.md` 是只读 symlink，不得在 .zcode 侧建实体文件）
- Infrastructure files: `AGENTS.md`, `Makefile`, `Dockerfile`, `docker-compose.yml`, `.github/workflows/hn-*.yml`
- Workflows — test/deploy pipeline smoothness, automation opportunities

## Process
1. Read all target artifacts and opencode config
2. Compare against actual project needs
3. Identify: missing permissions, outdated prompts, redundant configs, inconsistencies between `.md` front matter and `opencode.jsonc`
4. Apply concrete fixes directly
5. Log what changed and why

## Constraints
- Never delete existing agents without clear justification
- Favor evolution over revolution — small incremental changes
- Log changes in commit messages
