---
description: 自审 AI 协作层 — 双运行时配置、skills、hooks、workflows、scripts
---

审查全部 agent 配置与基础设施，找出并落地改进：

**双运行时栈**（改动保持单一数据源纪律）：
- opencode（CI 生成链）：`.opencode/agents/*.md`、`.opencode/skills/*/SKILL.md`、`opencode.jsonc`
- ZCode（交互 harness）：`.zcode/agents/*.md`、`.zcode/commands/*.md`、`.zcode/config.json`、`.zcode/hooks/guard.rb`
- skill 正文唯一真源在 `.opencode/skills/`；`.zcode/skills/*/SKILL.md` 是只读 symlink — 禁止在 .zcode 侧建实体 skill 文件

**基础设施**：`AGENTS.md`、`Makefile`、`Dockerfile`、`docker-compose.yml`、`.github/workflows/hn-*.yml`、`.github/actions/*`、`scripts/*.rb`

重点找：
- 两个栈之间的 front matter/指令漂移
- 过时指令（对照 `.opencode/designs/*.md` 架构事实：cache 层退役、.hn-archive 唯一存储、多源）
- 权限/工具配置不一致
- 死配置、冗余、文档漂移

改 Jekyll 可见内容过 `make build`；改管道过 AGENTS.md 第一性原理 + 对抗审查门；最后跑 `ruby scripts/check-cli.rb` 确认调用处一致。
