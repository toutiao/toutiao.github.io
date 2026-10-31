---
description: HN 讨论摘要文章生成（scan/URL/--auto/--weekly/--update 全模式）
argument-hint: "[url | --auto | --weekly | --update <url>] [--batch N]"
skills: [hn-discussion-summary, caveman]
---

按 `hn-discussion-summary` skill 执行。参数：`$ARGUMENTS`

| 输入 | 路由 |
|------|------|
| 无参数 | Phase 0 scan（候选池读 `.hn-archive/`）→ 展示候选 → 用户选 → Phase 1-3 |
| URL | 跳过 scan → Phase 1-3 |
| `--auto` | 全自动（与 CI 同款纪律：禁 make build / docker compose / git 提交推送，产出以写文件为止） |
| `--weekly` | Phase W0-W3 热度周报 |
| `--update <url>` | Phase U — 已发布文章追加更新段，不产新文件 |

执行前先 load `chinese-writing-style`（写作风格）。数据一律走 `.hn-archive/`（threads / heat / topics / published），引文逐字 + 真实作者 + `[c:id]`。文章正文用正常书面中文，caveman 只用于对话。
