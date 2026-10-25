# yuedulijie.com — 阅读理解

## 沟通规范

本项目所有 AI 输出使用 caveman 模式：去掉客套/虚词/客套话/模糊表述。片段式表达可以。用短同义词。技术术语保持精确。代码块原样不动。适用于所有 agent、所有任务，包括 CI。

**例外：生成的文章内容。** 中文摘要文章（`_articles/`）保持正常书面中文。caveman 模式仅用于 AI ↔ 人类沟通，不用于发布内容。

- Jekyll + GitHub Pages（分支 `master`，Pages 原生分支构建 — **无部署 workflow**，push master 自动构建）
- 域名：`yuedulijie.com`
- **本地开发**：Docker（ruby:3.2-slim，`docker compose`），**无需**本地 Ruby/Jekyll
- **CI**：`.github/workflows/hn-fetch.yml`（HN 多页列表抓取每日 3 次：`/best` ×2 + `/news` ×2 分层采样——≥80 分全量抓取，50–79 分 lead 仅入 registry+快照；+ Lobsters hottest 副源 continue-on-error + hot 突发触发）+ `.github/workflows/hn-auto.yml`（每日北京早 8 点 `/hn --auto --batch 2` 生成文章，MiniMax-M3 主力，失败回退 gemini-3.5-flash → deepseek-v4-flash）+ `.github/workflows/hn-weekly.yml`（周一北京 10:30 `/hn --weekly` 热度周报，单发无回退链）
- **子站**：[UP-6 英语学习导航](https://up-6.yuedulijie.com) — `github.com/Lax/up-6.yuedulijie.com`

## 项目结构
```
_config.yml       # 站点配置、collections、permalink、插件
_includes/        # Liquid 片段（header、posts/movies/articles/trends 列表）
_layouts/         # default、post、page、home、archives、按 collection 的页面
_movies/ (14)     # 影评
_books/ (0)       # 书评（空）
_essays/ (0)      # 随笔（空）
_articles/YYYY/  # HN 讨论摘要文章，年份子目录（2026/ = ~80 篇）；旧 root 级 15 篇并存
_data/hn/         # 已退役的 cache 层残留（二期 P2 起存储统一到 hn-data 分支；可能含旧本地数据，gitignored）
.hn-archive/      # hn-data 孤儿分支 worktree（唯一存储（二期 P2 起 cache 层退役）：snapshots/threads(含article)/topics/heat/cohort/triggers；gitignored，必须在 _data/ 外防 Jekyll 载入）
scripts/          # hn-fetch.rb (多页列表抓取+快照+分层状态机), hn-heat.rb (热度/聚簇/行业/多窗口投影), hn-repair.rb (门禁), lobsters-fetch.rb (Lobsters 副源), hn-backfill-ids.rb (hn_id 回填), hn-archive-prune.rb (年度 prune), hn-category-eval.rb (分类评测), category_map.json (行业分类表, versioned)
playwright-renderer/  # Playwright 文章渲染服务 (renderer mode, self-hosted)
.opencode/        # agents, skills, designs/hn-signal-architecture.md + phase2.md + phase3.md (事实来源)
assets/           # main.scss (入口, 带 front matter), main.js, favicon
```
导航页（`movies.html`、`books.html`、`articles.html`、`trends.html`）在 front matter 用 `nav: true`。`archives.html` 硬编码在 header，不进 nav。`trends.html` = 公开话题热度页（行业趋势/话题榜（复波+相关标注）/单讨论 Top/本周热度（7d 累计）/90 天走势，读 `_data/hn_trends{,_7,_90}.json` 三投影，由 hn-heat.rb 每日生成并提交 master）。`hn.html` 已退役（二期 P2）。

## Collections 与 Permalink
| Collection | 路径 | Permalink | 备注 |
|---|---|---|---|
| movies | `_movies/` | `/movies/:year/:name` | 无默认作者 |
| books | `_books/` | `/books/:year/:name` | 无默认作者 |
| essays | `_essays/` | `/essays/:name` | 默认作者：`深井兵太郎` |
| articles | `_articles/` | `/articles/:year/:name` | 无默认作者 |

## Front Matter 模式
- **Movies**：极简 — 通常只有 `title:`/`excerpt:`/`tagline:`（date 由文件名 `YYYY-MM-DD-` 前缀派生）
- **Articles**（HN 摘要）：`layout: post`，`title:`/`excerpt:`/`tagline:` 必须用 `>-` block scalar，`date:`，`categories: [articles]`
- **Essays**：默认作者 `深井兵太郎`（来自 `_config.yml`）
- **导航页**：`layout: <type>`，`title:`，`nav: true`

## 文件命名
- `YYYY-MM-DD-title-with-hyphens.md`；movies 加点 `YYYY-MM-DD-title.YEAR.md`
- **Articles**：`_articles/YYYY/YYYY-MM-DD-hn-keywords.md`（年份子目录）

## HN 自动管道（事实来源：`.opencode/designs/hn-signal-architecture.md` + `phase2.md` + `phase3.md`）
三 workflow + skill + 热度引擎，单层存储（hn-data 分支唯一存储，cache 层二期已退役）：
1. `hn-fetch.yml` 每日 3 次：抓 HN 多页列表（`--lists`：`/best` ×2 全量层 + `/news` ×2 分层——≥80 分全量、50–79 分 lead 仅 registry+快照）+ Lobsters hottest（副源 continue-on-error）→ 归档（threads 含 post+comments+article、snapshots 时间序列、registry 分层状态机 active(14d)→watching(周探活)→cold(月)→deep(季)→settled，评论增长可复活）→ hn-data 分支 push；hot 触发双通道（点值阈值 OR 快照差分），触发历史永久化 triggers.json
2. `hn-auto.yml` 每日：hn-data attach → `opencode run /hn --auto`（候选池 registry 驱动，Phase 0 按 heat 特征排序：resurrected 直通/up+expert 加权/spike 降权；MiniMax-M3 主力，回退 gemini-3.5-flash → deepseek-v4-flash）→ `hn-repair.rb` 门禁 → `hn-heat.rb --all`（日榜/聚簇+复波/专家群体/行业分类/published/多窗口 trends 投影 7/30/90）→ jekyll build 门禁 → git-auto-commit 提交 `_articles/` + `_data/hn_trends.json` + `_data/hn_trends_7.json` + `_data/hn_trends_90.json` → hn-data push
3. `hn-weekly.yml` 周一 02:30 UTC：`/hn --weekly` 热度周报（单发无回退链）
4. 本地：`make fetch url='<hn_url>'` / `make fetch-hn`（多页列表） / `make lobsters` / `make hn-archive-init` / `make hn-archive-sync`；`/hn` 命令（skill Phase 0-3/W0-W3，数据读 `.hn-archive/threads/`）
   ⚠ 本地 opencode 与 CI 版本 flag 不同：本地 `--auto`（无 `--dir`/`--dangerously-skip-permissions`），CI 反之

## 命令
| 命令 | 作用 | Agent |
|---|---|---|
| `/test` | `make build`（Docker）— 验证站点可编译 | jekyll-builder |
| `/deploy` | 构建 → 暂存 → 提交（中文 message）→ push master | git-publisher |
| `/plan` | 分析项目，建议下一步工作 | project-manager |
| `/content` | 审计 collections 与 front matter | content-manager |
| `/evolve` | 自审 agent 配置、skills、基础设施 | self-evolve |
| `/hn [url]` | 生成 HN 讨论摘要 → `_articles/YYYY/`（`--weekly` 周报模式） | hn-summarizer |

## 开发流程
1. 改内容/配置/布局
2. `make build`（或 `docker compose run --rm build`）— Docker 内验证
3. `make serve`（或 `docker compose up jekyll`）— http://localhost:4000 实时预览
4. 提交并 push master — Pages 分支构建自动部署

构建环境：`JEKYLL_ENV=production`（build）、`development`（serve）。持久化 gem 卷：`bundle_data`。

**GFW workaround**：若 `make build` 对 api.github.com 报 SSL 错误，在项目根建 `.env` 文件（gitignored）：
```
HTTP_PROXY=http://host.docker.internal:64540
HTTPS_PROXY=http://host.docker.internal:64540
NO_PROXY=localhost,127.0.0.1,.local
```
docker compose 自动读取 `.env`。

## 提交风格
中文约定式提交：`feat:`、`fix:`、`style:`、`docs:`、`refactor:` 前缀。必须先 build。`make deploy msg='...'` 一步完成 build → `git add -A` → commit → push。

## CI 运行
- 等 GitHub Actions run 结束用 `gh run watch <run_id> --exit-status`，不要 sleep 循环。

## 开发环境铁律（硬性）

**git/SSH/GitHub CLI 配置在 git 操作失败时一律禁止修改。报告错误即可。**

- `git config --global`、`git config --system`：**禁止** — 不得修改全局/用户级 git 设置
- `git remote set-url`、`git remote add`、`git remote remove`：**禁止** — remote URL 已预配置并与 SSH/gh CLI 协同
- `gh auth`：**禁止** — GitHub CLI 认证已预配置
- `~/.ssh/config`：**不得编辑** — SSH 配置已预配置
- `~/.gitconfig`：**不得编辑** — 全局 git 配置已预配置
- 本地 git、GitHub CLI、SSH 配置协同工作，支撑常规 `fetch`/`push`/`clone`。特定操作失败（如超时、认证错误）不代表环境需要"修复"。

git 操作若遇认证或网络错误：向用户报告错误信息并停止。不要试图"修好"环境。

## 第一性原理（硬性）

改管道（scripts/*.rb、CI workflows、部署）前，把系统分解到不可再分的组件并逐条验证假设：

1. **陈述每条原子假设**（如"文章引文行尾 `[c:id]` 是真实 HN comment ID"）
2. **什么会违反它？**（如"agent 编造 ID，或真实 ID 配了改写文本"）
3. **哪一层捕获违规？**（如"hn-repair.rb Algolia 验证 id 存在+作者匹配；文本级漂移仅 agent 自检 → WARN"）
4. **若未捕获，爆炸半径多大？**（如"编造引文被当作真实 HN 评论发布"）

模板：
```
假设：______
违反场景：______
捕获层：______
漏捕后果：______
```

每条假设至少一层捕获。任何假设零捕获层 = 设计不完整 — 不得继续。

## 对抗审查门（硬性）

提交任何管道/自动化改动前，执行对抗审查：

1. **攻击输出**：给定新代码，它能接受的最坏合法输出是什么？
2. **攻击阈值**：对手能否构造通过全部检查却产出坏内容的输入？
3. **攻击失败模式**：系统失败时是安全失败（无输出）还是危险失败（坏输出）？

输出格式：
```
对抗审查：
  攻击 1：<场景> → <后果> → [BLOCKED / WARN / MISSED]
  攻击 2：<场景> → <后果> → [BLOCKED / WARN / MISSED]
  已接受风险：<残留风险清单 + 接受理由>
  门禁：[PASS / FAIL]
```

门禁通过条件：
- 无 MISSED 高危攻击残留
- 全部残留风险有明确接受理由记录

## 要守住的规则

- **存储** `.hn-archive/` 是唯一存储，必须放在 `_data/` 之外 — Jekyll 会把 `_data/**/*.yaml` 全量载入 `site.data`，归档放进去会拖垮构建
- **存储** 归档数据不进 master；进 master 的只有 `_data/hn_trends.json`、`_data/hn_trends_7.json` 与 `_data/hn_trends_90.json` 三个投影，且只允许白名单字段（主投影 `annotate_public`；伴生窗口投影 registry 元数据）
- **存储** 评论、快照、热度历史永不删除；唯一可清理项是 threads 里的 `article` 正文（>365 天，`scripts/hn-archive-prune.rb --apply`）
- **存储** threads 写入必须幂等：评论按 `id` 合并、快照按 `(t,id)` 去重 — 重跑不得产生重复数据
- **存储** `published.json` 只增不减：文章发布过一次，对应 id 永久占用
- **管道** 副源（Lobsters）永远 `continue-on-error` — 副源故障不得阻塞 HN 主链
- **管道** 探活只对 HN id（Firebase item API）；`lo-` 前缀帖一律跳过
- **管道** cohort 作者必须按源命名空间（`hn:alice` ≠ `lobsters:alice`）— 跨站同名不得伪造「专家重叠」
- **管道** hot-check 的 stdout 只允许机读 `TRIGGER <url>` 单行，摘要一律走 stderr — CI 逐行解析 stdout
- **管道** 生成 skill（hn-discussion-summary）任何环境禁止 `make build`/`docker compose`/`git commit`/`git push` — CI 的 build 与提交由 workflow 门禁负责；本地提交走用户 `make deploy` 或确认后的 auto-deploy；生成期 push 会绕过门禁直接上线（dac2eba 事故）
- **管道** opencode flag 本地与 CI 不得混用：本地 `--auto`（无 `--dir`），CI 用 `--dir` + `--dangerously-skip-permissions`
- **管道** hn-auto 每次提交只含 `_articles/` 与三个投影文件，不得夹带其他变更
- **管道** 本地不得与 CI 并发推远端：本地推 hn-data/master 前先 `git fetch` 对齐；CI 生成窗口（attach 后 ~20 分钟）内避免推同分支 — 基点过期 = CI 产出随 runner 销毁丢失（40056343806 事故）；本地重建 hn-data（seed/force push）后必须手动 dispatch 一轮 hn-auto 验证
- **热度** 热度、聚簇、行业分类全部确定性 Ruby — 0 LLM 调用；改公式只动权重常量并 bump `rule_version`，全部历史日榜必须可 `hn-heat.rb --recompute` 重建
- **内容** 单帖摘要必须带 `hn_id`；跨多帖的周报**不加** `hn_id` — 防止成员帖被 published dedup 屏蔽
- **内容** 引文必须逐字（verbatim）+ 真实作者 + `[c:id]`；非 HN 引文 id 不走 Algolia 门禁，本地归档核验兜底
- **内容** `title:`/`excerpt:`/`tagline:` 必须 `>-` block scalar — ASCII `"` 会破坏 YAML
- **内容** 每篇生成文章结尾必须带免责声明 + AI 模型披露
- **发布** 对外页面禁止内部运维信息（状态机计数/版本号/覆盖率/冷启动说明）；空数据区块直接隐藏，不解释为何为空
- **成本** LLM 只用于成文（每日摘要 + 周报）；重试上限 3 次，回退链只 gemini → deepseek 一跳
- **流程** 改 `scripts/*.rb` 或 skill，先本地真实 HN URL 测试，再上 CI；每次改动必须过 `make build`
- **流程** 管道/自动化改动提交前必须过对抗审查门（见上文）；git/SSH/gh 配置错误只报告不修复（见上文铁律）

## 写代码

- 匹配周边代码：Ruby 脚本沿用 `frozen_string_literal`、`──` 分节注释与现有命名习惯；Liquid 模板沿用现有内联样式约定；不为局部改动引入新风格。
- 选简单方案：优先确定性 Ruby 而非 LLM 调用；复用 `hn-fetch.rb` 库模式（`HN_FETCH_AS_LIB=1` require），不复制代码；不为「将来可能的多源」提前抽象 — 新源照 `lobsters-fetch.rb` 模式单独成文件。
- 从源头解决，不在末端打补丁：问题定位到哪层就修哪层 — 脚本缺陷修脚本、坏数据修生产者写入端，禁止靠调用处/消费端的兜底逻辑掩盖症状；末端守卫（check-cli 这类）是防线，不是修复本身。
- 接口要么生效要么删除：不留「解析了但没人用」的死选项/死参数（--max 死了数月，删除时才在调用处爆雷）；删除接口时同步调用处只是收尾，源头清洁才是修复。
- 数据格式只向后兼容演进：归档 JSON/YAML 新增字段必须可缺省（读侧 `||` 兜底），已写入字段不重命名、不删除 — 旧归档在任何版本代码下都必须照常可读。
- 改 CLI 选项（增删改名）必须同步所有调用处（workflows / Makefile / skills / AGENTS.md）。守卫在**变更时**触发（check.yml push/PR + path 过滤，跑 make check-cli），不挂定时数据 run — 树静止时重验无意义，还会给数据管道加单点。
- 测试克制：数据层改动用真实 HN URL 本地跑通再上 CI；Jekyll 可见的改动过 `make build` 即可；不为纯文案、样式改动写测试。
- 已验证正向模式（保留勿回退）：列表行内热度趋势用零依赖 sparkline — `hn-heat.rb sparkline_points` 服务端确定性算好 `"x,y"` 点串，模板内联 `<svg class="spark"><polyline points="...">`（curve ≥3 点才渲染，移动端隐藏）。x 按真实日期间隔定位（`curve_day_offsets`，跨年单调）——复波间隔不被压缩；连续曲线与按点序布点等价。不用 JS 图表库，不改成 canvas/图片。

## 插件
仅 `jekyll-seo-tag`。HTML 压缩用 `_config.yml` 的 `compress_html`（仅 production）。
