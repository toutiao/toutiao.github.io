# yuedulijie.com — 阅读理解

## Communication

All AI output in this project uses caveman mode: drop filler/articles/pleasantries/hedging. Fragments OK. Short synonyms. Technical terms exact. Code blocks unchanged. This applies to all agents, all tasks, including CI.

**Exception: generated article content.** Chinese summary articles (`_articles/`) stay normal expressive CN. Caveman is for AI ↔ human communication, not published content.

- Jekyll + GitHub Pages (branch `master`, Pages native branch build — **no deploy workflow**, pushed master auto-builds)
- Domain: `yuedulijie.com`
- **Local dev**: Docker (ruby:3.2-slim, `docker compose`), **no** local Ruby/Jekyll needed
- **CI**: `.github/workflows/hn-fetch.yml` (HN 数据抓取 3x daily + hot 突发触发) + `.github/workflows/hn-auto.yml` (每日北京早 8 点 `/hn --auto --batch 2` 生成文章，MiniMax-M3 主力，失败回退 gemini-3.5-flash → deepseek-v4-flash)
- **Sub-site**: [UP-6 英语学习导航](https://up-6.yuedulijie.com) — `github.com/Lax/up-6.yuedulijie.com`

## Project Layout
```
_config.yml       # Site config, collections, permalinks, plugins
_includes/        # Liquid fragments (header, posts/movies/articles/hn-data listing)
_layouts/         # default, post, page, home, hn, archives, per-collection pages
_movies/ (14)     # Movie reviews
_books/ (0)       # Book reviews (empty)
_essays/ (0)      # Essays (empty)
_articles/YYYY/  # HN discussion summary articles, year subdirs (2026/ = ~80 篇)；旧 root 级 15 篇并存
_data/hn/         # HN 抓取缓存（gitignored，只存 GH Actions cache；本地/CI 可见，线上不含）
.hn-archive/      # hn-data 孤儿分支 worktree（唯一存储（二期 P2 起 cache 层退役）：snapshots/threads(含article)/topics/heat/cohort/triggers；gitignored，必须在 _data/ 外防 Jekyll 载入）
scripts/          # hn-fetch.rb (抓取+快照+分层状态机), hn-heat.rb (热度/聚簇/行业/投影), hn-repair.rb (front matter 修复门禁), category_map.json (行业分类表, versioned)
playwright-renderer/  # Playwright 文章渲染服务 (renderer mode, self-hosted)
.opencode/        # agents, skills, designs/hn-signal-architecture.md + phase2.md (事实来源)
assets/           # main.scss (entry, has front matter), main.js, favicon
```
Nav pages (`movies.html`, `books.html`, `articles.html`, `trends.html`) use `nav: true` in front matter. `archives.html` is hardcoded in header, not nav. `trends.html` = 公开话题热度页（行业趋势/话题榜（复波+相关标注）/单讨论 Top，读 `_data/hn_trends.json` 投影，由 hn-heat.rb 每日生成并提交 master）。`hn.html` 已退役（二期 P2）。

## Collections & Permalinks
| Collection | Path | Permalink | Notes |
|---|---|---|---|
| movies | `_movies/` | `/movies/:year/:name` | No default author |
| books | `_books/` | `/books/:year/:name` | No default author |
| essays | `_essays/` | `/essays/:name` | Default author: `深井兵太郎` |
| articles | `_articles/` | `/articles/:year/:name` | No default author |

## Front Matter Patterns
- **Movies**: minimal — usually only `title:`/`excerpt:`/`tagline:` (date 由文件名 `YYYY-MM-DD-` 前缀派生)
- **Articles** (HN summaries): `layout: post`, `title:`/`excerpt:`/`tagline:` 必须用 `>-` block scalar, `date:`, `categories: [articles]`
- **Essays**: default author `深井兵太郎` from `_config.yml`
- **Nav pages**: `layout: <type>`, `title:`, `nav: true`

## File Naming
- `YYYY-MM-DD-title-with-hyphens.md`; movies 加点 `YYYY-MM-DD-title.YEAR.md`
- **Articles**: `_articles/YYYY/YYYY-MM-DD-hn-keywords.md`（年子目录；`scripts/hn-fetch.rb` dedup 用 `_articles/**/*.md` 递归匹配）

## HN 自动管道（事实来源: `.opencode/designs/hn-signal-architecture.md` + `phase2.md`）
两 workflow + skill + 热度引擎，单层存储（hn-data 分支唯一存储，cache 层二期已退役）：
1. `hn-fetch.yml` 3x daily: 抓 HN best → 归档（threads 含 post+comments+article、snapshots 时间序列、registry 分层状态机 active(14d)→watching(周探活)→cold(月)→deep(季)→settled，评论增长可复活）→ hn-data 分支 push；hot 触发双通道（点值阈值 OR 快照差分），触发历史永久化 triggers.json
2. `hn-auto.yml` 每日: hn-data attach → `opencode run /hn --auto`（候选池 registry 驱动，Phase 0 按 heat 特征排序：resurrected 直通/up+expert 加权/spike 降权；MiniMax-M3 主力，回退 gemini-3.5-flash → deepseek-v4-flash）→ `hn-repair.rb` 门禁 → `hn-heat.rb --all`（日榜/聚簇+复波/专家群体/行业分类/published/trends 投影）→ jekyll build 门禁 → git-auto-commit 提交 `_articles/` + `_data/hn_trends.json` → hn-data push
3. 本地: `make fetch url='<hn_url>'` / `make fetch-best` / `make hn-archive-init`；`/hn` 命令（skill Phase 0-3，数据读 `.hn-archive/threads/`）

## Commands
| Command | Action | Agent |
|---|---|---|
| `/test` | `make build` (Docker) — validate site compiles | jekyll-builder |
| `/deploy` | Build → stage → commit (Chinese msg) → push master | git-publisher |
| `/plan` | Analyze project, suggest next work | project-manager |
| `/content` | Audit collections and front matter | content-manager |
| `/evolve` | Self-review agent configs, skills, infrastructure | self-evolve |
| `/hn [url]` | Create HN discussion summary → `_articles/YYYY/` | hn-summarizer |

## Dev Workflow
1. Edit content/config/layout
2. `make build` (or `docker compose run --rm build`) — validates in Docker
3. `make serve` (or `docker compose up jekyll`) — live at http://localhost:4000
4. Commit & push to master — Pages branch build auto-deploys

Build env: `JEKYLL_ENV=production` (build), `development` (serve). Persisted gem volume: `bundle_data`.

**GFW workaround**: If `make build` fails with SSL errors to api.github.com,
create `.env` file (gitignored) in project root:
```
HTTP_PROXY=http://host.docker.internal:64540
HTTPS_PROXY=http://host.docker.internal:64540
NO_PROXY=localhost,127.0.0.1,.local
```
Docker compose reads `.env` automatically.

## Commit Style
Conventional commits in Chinese: `feat:`, `fix:`, `style:`, `docs:`, `refactor:` prefixes. Always build first. `make deploy msg='...'` does build → `git add -A` → commit → push in one step.

## CI Runs
- 等待 GitHub Actions run 结束用 `gh run watch <run_id> --exit-status`，不要 sleep 循环。

## Dev Environment Rules (Hard)

**Never modify** git/SSh/GitHub CLI configuration when git operations fail. Report the error instead.

- `git config --global`, `git config --system`: **denied** — modifying global/user-level git settings is forbidden
- `git remote set-url`, `git remote add`, `git remote remove`: **denied** — the remote URL is pre-configured and coordinated with SSH/gh CLI
- `gh auth`: **denied** — GitHub CLI authentication is pre-configured
- `~/.ssh/config`: **do not edit** — SSH configuration is pre-configured
- `~/.gitconfig`: **do not edit** — global git config is pre-configured
- The local git, GitHub CLI, and SSH configs work together for normal `fetch`/`push`/`clone`. Do not assume they need fixing when a specific operation fails (e.g., timeout, auth error).

If a git operation fails with an auth or network error, report the error message to the user and stop. Do not try to "fix" the environment.

## First Principles (Hard)

Before any change to pipelines (scripts/*.rb, CI workflows, deployment), decompose the system to its irreducible components and validate each assumption:

1. **State each atomic assumption** (e.g., "article 引文行尾 `[c:id]` 为真实 HN comment ID")
2. **What violates it?** (e.g., "agent fabricates an ID, or real ID paired with rewritten text")
3. **Which layer catches the violation?** (e.g., "hn-repair.rb Algolia 验证 id 存在+作者匹配；文本级漂移仅 agent 自检 → WARN")
4. **If undetected, blast radius?** (e.g., "fabricated quote published as real HN comment")

Template:
```
Assumption: ______
Violated by: ______
Caught by: ______
Blast radius if missed: ______
```

Every assumption needs at least one catching layer. If any assumption has zero catching layers, the design is incomplete — do not proceed.

## Adversarial Review Gate (Hard)

Before committing any change to pipelines or automation, run adversarial review:

1. **Attack the output**: Given the new code, what is the worst valid output it would accept?
2. **Attack the threshold**: Can an adversary craft inputs that pass all checks but produce bad content?
3. **Attack the failure mode**: When the system fails, does it fail safe (no output) or unsafe (bad output)?

Output the review as:
```
Adversarial Review:
  Attack 1: <scenario> → <outcome> → [BLOCKED / WARN / MISSED]
  Attack 2: <scenario> → <outcome> → [BLOCKED / WARN / MISSED]
  Risk accepted: <list of residual risks with justification>
  Gate: [PASS / FAIL]
```

The gate passes only if:
- No MISSED high-severity attacks remain
- All residual risks documented with explicit acceptance rationale

## Constraints
- **API budget**: GEMINI/DEEPSEEK keys have usage limits. Keep max 3 retries; fallback is 1 retry (gemini → deepseek).
- **Test first**: Any change to scripts/*.rb or the skill must be tested with a real HN URL locally before CI deployment.
- **Build gate**: Every change must pass `make build` (Docker Jekyll compile).
- **Adversarial gate**: Per sections above — run adversarial review before committing.

## Plugin
Only `jekyll-seo-tag`. HTML compression via `compress_html` in `_config.yml` (production only).
