# HN Signal Architecture — 信号架构（参考 AIHOT 数据模型）

> 状态: 已实施 (Phase 1-3) | 日期: 2026-10-24 | 前身: [hn-data-pipeline.md](hn-data-pipeline.md)（缓存层设计，仍然有效）
> 立项动机: 通过 HN 等专业社区评论情况**推测新话题热度**。原架构数据 ~14 天即失、无时间序列、选题只看点值 velocity（利用率 7%）、线上无热度产品。

## 借鉴映射（AIHOT → 本站，借概念不借技术栈）

| AIHOT 概念 | 我们的对应物 | 载体 |
|---|---|---|
| story_signals（append-only 参与证据） | 评论 `posted_at` 到达曲线（回溯可算）+ score 快照序列 | `snapshots/*.jsonl` + `threads/` |
| stories.status 状态机 active/watching/settled | 观察集状态机（14d 观察窗 ≠ 数据 TTL，休眠话题可复活） | `topics.json` |
| story_heat_hourly | `heat/YYYY-MM-DD.json` 日榜 | hn-data 分支 |
| hot_rankings（rule_version） | 日榜带 `rule_version`，`--recompute` 全历史回算 | hn-heat.rb |
| stories 聚簇 | 确定性关键词聚簇（shared tokens + 时间窗） | `topics.json` `topics` 键 |
| publications 公开投影（唯一读取点） | `_data/hn_trends.json` → `/trends.html` | master |
| "48h 每独立来源只计一次" | 话题热度 = Σ 成员帖热度（每帖天然计一次） | hn-heat.rb |
| **拒绝** Postgres/pg-boss/Node/SSR | 摧毁 $0 静态架构；git-as-DB（孤儿分支+JSONL+Ruby） | — |
| **拒绝** receipts/budgets | LLM 成本由模型链回退控制（MiniMax-M3 → gemini-3.5-flash → deepseek-v4-flash） | — |
| **拒绝** 双次 LLM 打分 | 热度=确定性 Ruby 公式，0 模型成本、可回算 | — |

## 三层数据架构

```
热层  GH Actions cache `_data/hn/YYYY/WNN/`     2 周抓取工作集（原设计不变）
冷层  孤儿分支 hn-data（主存储, worktree 于 .hn-archive/）
      snapshots/YYYY/MM.jsonl    {id,t,s,c} 追加 — score 轨迹唯一来源（HN 无 score 历史 API）
      threads/YYYY/WNN/<id>.yaml {post, comments[]} — 评论按 id 合并，复活帖就地追加
      topics.json                {threads{id→状态机条目}, topics[]聚簇}
      heat/YYYY-MM-DD.json       日榜 {rule_version, entries[{heat, signals, trend, delta_24h}]}
      cohort/WNN.json            周专家群体（14d 滚动窗, ≥2 帖有评）
      published.json             {hn_id→{date,slug,url}} dedup 查表
投影  master `_data/hn_trends.json`（≤50KB, 字段白名单, 滚动 30 天 top 50 话题）
```

**关键约束**: 归档目录必须在 `_data/` 之外（`.hn-archive/`）— Jekyll 会把 `_data/**/*.yaml` 全量载入 `site.data`，threads 月增 ~20MB 会拖垮 build。已同步 `.gitignore` + `_config.yml` exclude。

## 观察集状态机（14 天是观察窗，不是数据 TTL）

| 状态 | 进入条件 | 行为 |
|---|---|---|
| active | 14d 内 score/评论数有增量 | 随 hn-fetch 3x/日 刷新（best 列表差分） |
| watching | 连续 14d 无增量 | 每周 1 次 Firebase `item/{id}` 轻量探活（每 run ≤40 帖）；评论数增长 → 重抓全量、合并归档、**复活回 active 重入榜单**；两轮零增量 → settled |
| settled | 探活连续零增量 / watching 超限(500) FIFO | 停止探活，数据永留冷档可查询 |

## 热度模型 v1（`RULE_VERSION = 'v1'`，确定性）

时间序列双来源：**评论维（主）**— comments `posted_at` 直方图回溯重建，单次抓取即得全曲线；**score 维（辅）**— 仅快照可提供，缺口时 confidence=low 不阻断。

```
signals = { comment_vel_24h, score_vel, expert_ratio, depth_p95, avg_depth, long_tail, resurrected }
expert_ratio = top-30 评论(按分)作者 ∩ cohort(14d 内 ≥2 追踪帖有评) 的比例   ← 专业参与度代理
H = 0.35·ln(1+comment_vel) + 0.25·ln(1+score_vel) + 0.25·expert_ratio·3 + 0.15·ln(1+depth_p95)/1.5
trend: resurrected > new(<3d 无前值) > up/down(|Δ24h|>0.15) > flat
resurrected 判定: 帖龄>14d 且评论序列存在 ≥7d 静默间隙后有 (≤30d 内) 新到达
```

聚簇: 标题分词（去停用词/纯数字）shared≥2 tokens 或 shared=1 且 Jaccard≥0.5，帖间 ≤30d，union-find；仅 ≥2 帖成话题（`topic_id = t-<最老成员id>`）。误并仅影响排行页（WARN 已接受），文章生成仍单帖。

## 工具

| 命令 | 作用 |
|---|---|
| `hn-fetch.rb --best` | 原有 + 快照追加 + registry 推进 + threads 归档 |
| `hn-fetch.rb --poll-watching` | watching 探活/复活/降级（CI 每次 fetch 后跑，按 7d 到期分摊） |
| `hn-fetch.rb --hot-check` | **双通道**: 旧点值(score≥200∧age≤8h∧vel≥20) OR 快照差分(Δscore≥80∧age≤72h∧score≥100) |
| `hn-heat.rb --all` | cohort + 日榜 + 聚簇 + published + `_data/hn_trends.json` |
| `hn-heat.rb --recompute` | 从原始信号重建全部历史日榜（公式升级后用） |
| `make hn-archive-init` | 从本地 `.hn-archive/` 种子 hn-data 分支（幂等） |

composite action `.github/actions/hn-archive/`：`mode: attach`（worktree 挂载，分支不存在则建孤儿分支+.gitattributes union merge）/ `mode: push`（commit + rebase 重试 ×3，失败标红下轮补写）。**不用跨 workflow concurrency group**（会排队/取消整条 hn-auto 20min 生成链，代价大于收益）。

## CI 流（改造后）

```
hn-fetch.yml (3x/日, contents:write)
  checkout → ruby → hn-cache/restore → hn-archive attach
  → hn-fetch --best（写快照/registry/threads）
  → hn-fetch --poll-watching
  → hn-fetch --hot-check → TRIGGER → dispatch hn-auto mode=url
  → hn-archive push → hn-cache/save

hn-auto.yml (每日 00:00 UTC + dispatch)
  checkout → ruby → opencode setup → hn-cache/restore → hn-archive attach
  → [force 时 fresh fetch] → API 探活 → opencode /hn（skill Phase 0 读 .hn-archive/heat 排序）
  → 回退链 → hn-repair.rb → hn-heat.rb --all → jekyll build 门禁（验证 trends 页）
  → git-auto-commit(_articles/ + _data/hn_trends.json) → hn-archive push（生成期抓取不再丢失）
```

skill Phase 0 排序（`hn-discussion-summary/SKILL.md`）: resurrected 直通 → up+expert_ratio≥0.3 加权 → spike-only(vel_24h=0∧score_vel<5) 降权；`.hn-archive/heat/` 缺失时回退纯 velocity（本地交互模式）。

## 第一性原理表（实施核验）

| 假设 | 违背场景 | 捕捉层 | 实施状态 |
|---|---|---|---|
| 评论 posted_at 完整可信 | Algolia 缺字段 | filter_map 跳过 nil；影响仅局部曲线 | ✅ |
| snapshots (t,id) 幂等 | run 重试重写 | 写前当日段查重 | ✅ 已测 |
| hn-data push 冲突 | fetch×auto×dispatch 并发 | rebase+重试×3 + jsonl union merge；失败标红下轮补写 | ✅ |
| watching 探活成本有界 | 追踪帖累积 | WATCHING_MAX=500 FIFO 降级 + POLL_BATCH_MAX=40/run | ✅ |
| expert_ratio 抗刷 | 水军 | 门槛 14d≥2 追踪帖 + top-30 按评论分 | ✅ v1 无 karma |
| trends.json 不泄原文 | 投影含评论文本 | annotate_public 白名单字段 | ✅ 已核 |
| 差分触发不漏突发 | 8h 采样稀疏 | 双通道（点值兜底） | ✅ 已测触发 |

## 对抗审查（Gate: PASS）

```
Attack 1: COMMENT_CAP=100 截断 → 老帖到达曲线尾部缺失 → 活跃帖缓存差分即重抓；仅沉寂帖尾段缺失 → [WARN]
Attack 2: 短时突发被 8h 采样低估 → 点值通道兜底 → [BLOCKED]
Attack 3: 关键词聚簇误并 → 话题热度虚高 → 仅影响排行展示，文章仍单帖，聚簇表可查 → [WARN]
Attack 4: push 失败静默 → 历史断档 → set -euo pipefail + ::error:: + 下轮全量补写（threads 缓存命中） → [BLOCKED]
Attack 5: 权重拍脑袋 → 排行不可信 → rule_version 隔离 + 原始信号保留 + --recompute + 30 天对照观察 → [WARN]
Risk accepted: 无 karma 加权（结构性代理先行）; watching 周粒度探活可能晚数天发现回热; 长期分支体积 ~20MB/月（年度 prune 政策 Phase 4）
```

## 已验证（2026-10-24 本地实测）

- `--url` 真实帖（49717558, 9 月老帖仍在涨评论）→ registry+threads 归档 ✅
- `--best` 30 帖 → 快照含真实评论数（修复了 scrape descendants 恒 0 导致 best 帖永不命中缓存的旧 bug）✅
- 差分通道注入伪快照 → `TRIGGER` 输出 ✅
- 探活复活（tamper watching + count-500）→ RESURRECTED +18, 合并无重复 id, status→active ✅
- `hn-heat --all` → cohort 268, Kushner 两帖正确聚簇, published 114, trends 28KB ✅
- `make build` Docker 门禁 → /trends.html 31 sparkline + nav ✅

## Phase 4（未实施，另开任务）

周报文章自动化（AIHOT reports 对应物）、老文 hn_id 批量回填（当前仅 1/90 有 hn_id，靠 published.json 正文扫描兜底）、年度 prune、多源接入（信号表已按单源设计，topic 聚簇天然跨源）。
