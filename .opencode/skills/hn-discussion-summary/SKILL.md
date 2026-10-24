---
name: hn-discussion-summary
description: Create Chinese HN discussion summary article for yuedulijie.com
metadata:
  domain: content
  collection: articles
---

## Mode

| Condition | Mode |
|-----------|------|
| `--auto` / `CI=true` / `GITHUB_ACTIONS=true` | **auto** — no prompts, auto-decide, auto-build, auto-deploy |
| `--weekly` | **weekly** — 聚合本周热度数据生成周报文章（Phase W0-W3，见文末） |
| else | **interactive** — user prompts, confirm deploy |

---

## Phase 0 — Scan

### Filters (all modes)
Story pass all:
- score >= 80
- HN id not in `_articles/*.md` front matter `hn_id:` (old articles lack hn_id → fallback: search `item?id=<id>` in body)
- same topic not covered today (grep date + keyword in existing articles)

> `hn-fetch.rb` already dedup at write time (via `.hn-archive/published.json`, fallback `_articles/` scan). This is 2nd layer.

### Auto mode
1. Candidate pool = **registry-driven**（无周界跳跃）: 读 `.hn-archive/topics.json` `threads`，取 `status == "active"` 且 `published != true` 且 **`source != "lobsters"`**（多源数据先服务热度/趋势页，成文暂限 HN）的条目；resurrected 帖（`status == "active"` 且 heat 榜 `trend == "resurrected"`）优先含入
2. Apply filters（score 用 registry `last_score`，age 用 `posted_at`）
3. Sort by **heat features** (preferred) or velocity fallback:
   - Preferred: read `.hn-archive/heat/<today>.json` (CI 中由 hn-data worktree 提供，当日文件由 hn-heat.rb 生成)。Per-candidate adjust a base ranking (velocity = score / max(age_hours, 0.5) desc):
     - `trend == "resurrected"` → move to very top (回热话题直通候选)
     - `trend == "up"` 且 `expert_ratio >= 0.3` → rank bonus (专业社区持续升温)
     - signals 中 `comment_vel_24h == 0 && score_vel < 5` 且非 resurrected → demote (spike-only, 已过峰)
   - Fallback (`.hn-archive/heat/` 不存在，如本地交互模式): pure velocity sort
   - Registry 不可用时 fallback: `webfetch https://news.ycombinator.com/best?h=48`
4. Report ranking table (include heat/trend/expert_ratio when available)
5. Batch: `--batch N` (default 1). Pick top N uncovered candidates → run Phase 0.5→1→2→2.5→3 per candidate **sequentially**; one failure does not block the next. Report after each: `Auto-selected [k/N]: [title] ([score] pts)`
6. Go to Phase 0.5

### Interactive mode
1. `webfetch https://news.ycombinator.com/best?h=48` (text)
2. Parse id + title + score
3. Apply filters
4. Political match → tag `⚑ political context`
5. Show top 5:

   ```
   HN hot candidates:
   [1] Title (N pts)
   ...
   Input: number / URL / "n" to skip
   ```

---

## Phase 0.5 — Cluster

### Keyword
Drop leading common words (Claude, new, update, Introducing) → first meaningful token.

### Auto
1. Scan candidates for same keyword, score >= 80, not self
2. >= 2 related → **cluster mode** (include all)
3. < 2 → **single post mode**
4. Report: `Mode: [cluster/single], N posts`

### Interactive
1. `webfetch` HN source (html):
   - `/best` → `https://news.ycombinator.com/best?h=48`
   - `/news` → start `/news`, follow "morelink" till score < 80 or age > 48h
2. Parse `<tr class="athing">`: id + title + score
3. Filter by keyword, score >= 80, not self
4. >= 2 → show:

   ```
   Detected cluster — {N} related posts:
     [1] {title} ({score} pts) — MAIN
     ...
   Include all? [y] / select numbers [1,3,5] / [n] skip
   ```
5. else → single mode
6. User input sets cluster scope

---

## Phase 1 — Fetch + Analyze

### Data（归档优先，无 2 周窗口限制）
Prefer `.hn-archive/threads/`（永久）; 候选无归档时先刷新 `bundle exec ruby scripts/hn-fetch.rb --url "<hn_url>" --fetch-articles-simple`; 最后才 `webfetch`。

| Data | Path | Key fields |
|------|------|-----------|
| Thread（含全部） | `.hn-archive/threads/YYYY/WNN/<id>.yaml` | `post`{title, score, author, posted_at, raw_comment_count}, `comments`[]{id, author, text, score, posted_at}, `article`{title, fetch_status, content} |
| Find week | `.hn-archive/topics.json` `threads[id].week` | 单帖 glob: `.hn-archive/threads/*/*/<id>.yaml` |

### Sufficiency check
Read thread `article` (older archives may lack it). Check `content` length:
- `< 2000` → **MUST** run `bundle exec ruby scripts/hn-fetch.rb --fetch-article-url "<url>" --timeout 30`
- `2000..4000` → **SHOULD** run
- `> 4000` → **MAY** proceed

exit 0 → use stdout. exit 1 → use cached.

### Single post mode
1. Read article → note concrete details for 原文概要 (names, numbers, features, absurdities)
2. Read `comments.yaml` (top 100 by score) → extract 4-8 themes with quotes
3. Record `comment:id` for each quote — **append to quote line as `[c:id]`** (Phase 2 verify + hn-repair.rb CI 校验)
4. Identify: key opposition, personal-experience threads, overall sentiment

### Cluster mode
1. Main: top 20 comments by score
2. Related: top 8 each
3. Track `thread_id` per quote (e.g. `[thread 2]`)

---

## Phase 2 — Write

Load `chinese-writing-style` first.
(引文原文不受 style 约束. 翻译和讨论段受约束.)

> caveman mode applies to AI communication only. Article body stays normal expressive CN.

### Front matter

```
---
layout: post
title: >-
  Topic — HN discussion digest
date: $(TZ=Asia/Shanghai date +%Y-%m-%d)
hn_id: <story HN id>
categories: [articles]
excerpt: >-
  1-2句, ~80字
tagline: >-
  浮夸版（不展示, 搜索引擎可见）
---
```
⚠ `title` / `excerpt` / `tagline` MUST use YAML block scalar `>-`. ASCII `"` terminates any double-quoted YAML scalar (breaks the whole front matter). Use 《》 or `\"` for inner quotes. Never use full-width `＞`.

⚠ `date` via `$(TZ=Asia/Shanghai date +%Y-%m-%d)`. Never manual.

### excerpt rules
| Length | Style | Example |
|--------|-------|---------|
| < 3k chars | Core insight | "每天 5 分钟深呼吸就能改变你做风险决策的方式。" |
| >= 3k chars | Hook, counterintuitive | "0.2B 模型击败 10B 级模型。" |

No clickbait: 震惊, 惊人, 万万没想到.

### tagline rules
| Tone | Example |
|------|---------|
| 吐槽 | curl 维护者：黑客不休息？那我先休了。 |
| FOMO | Anthropic 的护城河正在蒸发。 |
| 金句 | 救火的被奖励，防火的被遗忘。 |
| 直击 | 你只是想写个代码，Anthropic 却要你的护照照片。 |
| 感性 | 全片台词不到十句，看完想给所有人打个电话。 |
| 反讽 | 花最贵的钱，用最不确定的服务。 |
| 脑洞 | 抓精灵时，Niantic 在帮你参军。 |
| 悬念 | 中国电影史上最短的剧本：沿着城墙走，走不完的路。 |

Must anchor to facts. Never fabricate. Not displayed — indexed via `<a title="...">`.

### Quality rules

1. **Concrete > abstract** — "面包 33% 烤焦率" not "产品有问题". Names, numbers, specific features.
2. **Quote-driven** — each theme section >= 1 quote (EN + CN). No "很多读者认为".
3. **Narrative arc** — 原文概要: cause → twist → outcome. 总体情绪: divergence → strong closing line.

### Article structure (fixed order)
1. **原文概要** — 2-5 paragraphs. Source: "HN 首页 (/news)" or "HN 热门榜 (/best)". Use concrete details (names, numbers, features).
2. **讨论焦点** — `###` sections. Each:
   ```
   > "text" — user [c:44123457]
   > （译文）
   ```
   - Translation no attribution
   - No blank between quote and translation
   - `[c:id]` 是该引文对应 HN comment ID（必有，用于事实校验）
   - Cluster: `> "text" — user [c:44123457] [thread 2]`
3. **典型观点一览** — table: 立场 / 用户 / 一句话
4. **总体情绪** — 1-2 paragraphs. End with strong closing line.
5. **引用帖子** — table: # / 标题 / URL
6. **免责声明** — `<div class="disclaimer">`

### Format rules

| Rule | Example |
|------|---------|
| Quote + user same line + comment id | `> "text" — user [c:44123457]` |
| CN trans separate line | `> （译文）` |
| Tech terms `` ` `` | `` `R1` ``, `` `BPEL` `` |
| Product names plain | LangChain, OpenAI, Claude |
| General plain | agent, framework, API |
| Cluster thread | `> "text" — user [c:44123457] [thread 2]` |

### Naming
`_articles/YYYY/YYYY-MM-DD-hn-keywords.md`

### AI model disclosure
Append to disclaimer:
```
<br><br><em>本摘要由 AI 模型辅助生成：{provider}/{model}</em>
```
Use actual model (e.g. `google/gemini-2.5-flash`, `deepseek/deepseek-v4-flash`). Never fabricate.

---

## Phase 2.5 — Fact Check + Revise (REQUIRED)

> CI 中**禁止 webfetch HN 页面** (news.ycombinator.com 会对 CI runner 限流 429 → 超时)。
> 引文核验一律使用缓存 + hn-repair.rb (Algolia gate, CI 强制层)。

### Step 1 — Quote verify (local)
1. Source of truth = `_data/hn/.../{id}/comments.yaml` (raw HN text, already cached)
2. For each quote: grep verbatim text in comments.yaml
3. Check:
   - Verbatim match (no paraphrase)
   - Author match vs comments.yaml `author`
   - Ellipsis (...) preserved meaning
   - CN translation faithful
4. Fix mismatch
5. Report: ✓ / ⚠ / ✗
6. Log entry: `verified against comments.yaml (local)` — 最后由 `hn-repair.rb` 对 Algolia 做存在性+作者终验

### Step 2 — Quality review
Read full draft. Checklist:

| # | Check | Pass |
|---|-------|------|
| 1 | 原文概要 specific? | >= 3 concrete items (names/numbers/features) |
| 2 | 讨论焦点 quotes? | Each theme section >= 1 quote |
| 3 | Concrete not vague? | No "很多人表示". Each sentence anchored. |
| 4 | 观点表 covers split? | >= 4 rows, includes opposing views |
| 5 | 总体情绪 closing? | Last line not repeat. Synthesize or punch. |
| 6 | 引文带 comment id? | Each quote line ends with `[c:<id>]` |

Fail any → revise section → re-check.

### Sensitivity scan

Scan body (exclude disclaimer) for:
`[china/ccp/tiananmen/taiwan/tibet/xinjiang/hong kong]` + `[censorship/surveillance/human rights/propaganda]`

| Hit | Action |
|-----|--------|
| Yes | Tag `⚑ sensitive`. Go to Phase 3 flagged path. |
| No | Normal path. |

---

## Phase 3 — Output

1. Save article to `_articles/`
2. Validate date:
   - `grep "date: $(TZ=Asia/Shanghai date +%Y-%m-%d)"` article file
   - Match → continue
   - Mismatch → correct to today
   - Re-read front matter: `title`/`excerpt`/`tagline` are `>-` block scalars, no double-quoted scalar containing ASCII `"`. Bad → fix → re-check.
3. Build:
   - **Auto/CI**: 禁止执行 `make build` / `docker compose` / `bundle exec jekyll build`（CI workflow 已有 build 门禁；Docker 会以 root 写出 `_site/` 导致后续 build Permission denied）。只做 front matter grep 校验。
   - **Interactive**: `make build` — fail → fix → rebuild (max 1 retry)。

### Auto mode

| Tag | Action |
|-----|--------|
| Normal | **CI=true 时跳过 git add/commit**（workflow git-auto-commit-action 负责提交推送）；本地 auto 模式 `git add -A && git commit -m "feat: HN 自动摘要 <真实日期>"` — 日期是 `$(TZ=Asia/Shanghai date +%Y-%m-%d)` 展开后的字面值 |
| ⚑ sensitive/political | Add extended disclaimer → commit same + warning: "⚠ Review recommended." |

Exit 0. No prompts.

### Interactive mode

| Tag | Action |
|-----|--------|
| Normal | Ask deploy? yes → invoke auto-deploy skill |
| ⚑ sensitive/political | Show matched terms. Add extended disclaimer. Ask "Confirm deploy? [y/N]" (default N). y → deploy. N → stay local. |

---

## Mode: --weekly（周报 — AIHOT reports 对应物）

聚合本周热度数据成一篇周报文章。数据全部来自 `.hn-archive/`（确定性热度引擎产出），写作风格/引文纪律同 Phase 2。

### Phase W0 — Week dataset（确定性，无 LLM 判断）

1. 读最近 7 天 `.hn-archive/heat/YYYY-MM-DD.json`（今天往前 6 天；缺文件 = 管道冷启动间隙，如实记录覆盖天数）
2. 读 `.hn-archive/topics.json`（topics + registry）+ `_data/hn_trends.json`（industries/related）
3. 构造本周榜单（纯计算）:
   - **Top 5 话题**: 按窗口内单日峰值 heat 排序（title / 峰值日 / 峰值 / 成员帖 / 已成文链接）
   - **本周上升**: 首末两日 heat 差最大者
   - **回热话题**: 窗口内 trend=resurrected 的帖/话题
   - **行业动向**: 按 industries 周累计 heat 排序 top 3 + delta 最大升降者
4. 窗口内 heat 文件 <2 天 → 照常生成，文首标注「热度数据自 <首个文件日期> 起」

### Phase W1 — Evidence

- Top 话题各取 1-2 条成员帖 top 评论（按 score）作引文: verbatim EN + `> "text" — user [c:id]` 格式（同 Phase 2 纪律）
- 引文来源: `.hn-archive/threads/YYYY/WNN/<id>.yaml` `comments`（Phase 2.5 本地 grep 校验同样适用）
- 归档缺该帖 → 跳过引文，只用聚合数据叙述，**禁止编造**

### Phase W2 — Write

- 文件: `_articles/YYYY/YYYY-MM-DD-hn-weekly-W<NN>.md`（NN = 本周一的 ISO 周号，`date -d 'last monday' +%V` 或当日 `%V` 周一执行）
- Front matter: `layout: post` / `title: >-`（含 WNN 与本周主线词）/ `date: 今日` / `categories: [articles]` / `excerpt: >-` / `tagline: >-`
- **不加 `hn_id`**（周报覆盖多帖，防 published dedup 屏蔽成员帖的日常成文）
- 结构: 本周话题榜（每条: 一句锐评 + 峰值数据 + 引文）→ 行业动向 → 回热话题 → 数据说明（rule_version / 覆盖天数 / cohort 规模）
- 结尾 `<div class="disclaimer">` + AI 模型披露，同 Phase 2

### Phase W3 — Output

同 Phase 3（CI 禁 build/commit，由 workflow 门禁提交）。Interactive 模式 `make build` 后确认。
