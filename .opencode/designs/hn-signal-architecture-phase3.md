# HN 信号架构三期 — 采样完整性与聚合粒度

> 状态: 已实施 (2026-10-25) | 前置: [hn-signal-architecture.md](hn-signal-architecture.md)（一期）+ [phase2.md](hn-signal-architecture-phase2.md)（二期）
> 动机: ①上游只采 `/best` 第 1 页 30 帖（≥80 分才可见），上升期帖在过 80 分前完全不可见——hot 差分通道对未入库帖无效，早期速度信号缺失；②聚合只有 30d（月）+90d 两个窗口，主榜按"今日热度"排名，缺"本周谁最大"的周粒度视角。

## 一、采样多页化 + lead 分层（hn-fetch.rb）

`--best`（单页 30 帖）→ `--lists`：

| 列表 | 页数 | 门槛 | 处理 |
|---|---|---|---|
| `/best` ×2 | 60 帖 | ≥80 分 | 全量抓取（讨论 + article，同原行为） |
| `/news` ×2（增量 = 不在 best 集内） | ~40 帖 | ≥80 分 | 全量抓取（即将进 best，提前覆盖） |
| `/news` 增量 | 50–79 分 | **lead**：仅 registry + 快照，零 per-thread 请求 |
| `/news` 任意 | <50 分 | 丢弃（HN 排序已完成初筛，p2 尾部弱信号不值得 registry 膨胀） |

- lead 的价值：registry 带精确 `posted_at`（age `title` 属性 = UTC 精确时间，已对 Firebase 实测核验）+ 快照时间序列 → 帖子 50→150 分的爆发在下一轮 run 即命中差分触发通道（旧管道要等它过 80 上 best 才首次可见，再等一轮才有第 2 个快照点）
- lead 不进成文候选：skill Phase 0 的 `score >= 80` 过滤天然排除（成文质量线不动）
- news 层 best-effort：scrape 失败静默降级为 best-only（best 链自身有 Algolia/Firebase 兜底，同域失败则同域兜底）
- 状态机复用：lead 帖 14d 无增量 → watching → 周探活若评论增长自然复活为全量归档（探活路径 `archived=nil` → 全量重抓，无需新代码）

### 顺带修复的存量 bug（效率黑洞）

subtext 里有两个 `item?` 链接（`.age` 内的 "1 day ago" 与 "240 comments"），`at_css` 按文档序取第一个 → **descendants 解析的是 age 文本的第一个数字**（"1 day ago"→1）。后果：scrape 的 descendants 恒错 → freshness（descendants 相等 + article 已决）永不命中 → best 帖每轮全量重抓（含 article 重抓）。修复：按词义匹配（text 含 "comment" 或 =="discuss"）。修复后实测二轮 run 37/74 cached（修复前恒 0）。旧快照里的错误 `c` 值不回改（append-only，热度引擎只用 `s` 序列）。

### 顺带修复的编码陷阱（make build 实测爆出）

Net::HTTP body 的编码标注随 ruby/nokogiri 版本漂移：本地 ruby 4.0.8 把 HN HTML 标为 ASCII-8BIT，nokogiri 1.19.4 对无编码标注输入按 Latin-1 误判 → 标题 mojibake（`’` E2 80 99 → `â\u0080\u0099`），C1 控制字符直接炸掉 Jekyll `_data` 的 YAML 解析（CI 的旧 nokogiri 恰好不踩，属隐性炸弹）。修复：`scrape_list_page` 与 `api_get_json`（及 lobsters `lo_get`）入口显式 `force_encoding('UTF-8')`，不赌版本行为。本地已污染的 4 条 registry 标题已从 threads 干净标题回填修复，heat 当日档重建，三投影 C1=0。

## 二、聚合粒度：7/30/90 三窗口（hn-heat.rb）

- 主投影 `_data/hn_trends.json`（30d）不变：今日热度排名 = "现在最热"
- 新增 `_data/hn_trends_7.json` + 改造 `_data/hn_trends_90.json`：**窗口累计热度排名**（`build_window_projection`，独立函数不碰主路径）
  - 数据源：per-day heat 序列（非今日 entries）——**周中热过、今日沉寂的话题仍以全窗口权重出现**（主榜按今日 entries 构建，天然看不到它们）
  - 行业段同步窗口化：周累计 heat + delta_7d 箭头 + 窗口内 top 驱动话题
- 效率：per-day 数据一次载入（90 日档）三窗口共享（原实现 30d+90d 各自载入，120 次文件读 → 90 次）
- trends 页新增「本周热度」区块（复用 t90 行样式，零 CSS 改动；<3 个 heat 日自动隐藏——空数据区块直接隐藏规则）

## 三、第一性原理核验

| 假设 | 违反场景 | 捕获层 | 漏捕后果 |
|---|---|---|---|
| `/news` 页与 `/best` 同构（tr.athing + subtext） | HN 改版 | scrape 返回 nil → news 层静默降级 best-only，无坏数据写入 | 覆盖下降（可修），非损坏 |
| age `title` 属性 = UTC 创建时间 | HN 改为本地时区 | 逐条对 Firebase item API 抽验（本次实测 3/3 精确一致）；漂移只影响 age 门槛类判断 | hot 通道 age 判定偏差小时级（WARN 接受） |
| lead 有 posted_at（hot 通道硬前提） | age 属性缺失/解析 nil | `registry_update_from_stories` 写入前 `||=`，nil 时 hot 通道 `next unless posted_at` 跳过该帖 | 该帖不参与触发，下一轮全量抓取后自愈 |
| 快照 (t,id) 幂等（跨列表并集去重后） | 同 run 双列表同 id | run 内 `uniq { id }` 后才 append；写前当日段查重（既有） | 快照重复行（无） |
| lead 不污染成文候选 | 50–79 分帖被选中成文 | skill Phase 0 `score >= 80` 硬过滤 | 低质量成文（无路径） |
| 窗口投影可确定性回算 | 投影逻辑漂移 | 纯 per-day heat 求和，无随机性；rule_version 不变（公式层未动，投影层新增） | — |
| registry 膨胀有界（lead 注入 ~30-50/日） | watching/cold/deep 池溢出 | POLL_CAPS 500/1000/2000 + FIFO 逐层降级（既有）；poll 需求 ~126/日 vs 容量 120/日（40×3run），差额由 due 队列顺延吸收 | 探活延迟缓慢增长（WARN 接受，settled 封顶） |
| 列表/API 响应体按 UTF-8 解读 | Net::HTTP 编码标注随版本漂移 + nokogiri 对无标注输入误判 Latin-1 | 入口显式 `force_encoding('UTF-8')`（本次 make build 实测爆出并修复）；Jekyll build 门禁为末端防线 | mojibake 进 _data 炸 YAML → CI build 红（fail-safe，非静默坏数据） |

## 四、对抗审查

```
对抗审查：
  攻击 1：对手构造 50-79 分蹭热帖批量进 lead → registry 膨胀 + 探活池挤占 → lead 无 thread 文件、探活 1 Firebase req/帖/周，
          POLL_CAPS FIFO 兜底，成文通道 score>=80 挡死 → [BLOCKED]
  攻击 2：/news scrape 部分失败（页面返回但行残缺）→ 漏 lead → 该轮覆盖下降，下轮 8h 自愈；无坏数据 → [WARN]
  攻击 3：descendants 修复后旧 registry last_comment_count 是垃圾小值（1/3/47）→ 首轮 delta 误判"有增量"→ 仅多一次全量
          抓取 + active 标记，次轮即对齐真值 → [WARN，一次性自愈]
  攻击 4：7d/90d 窗口累计排名被"60 条小帖聚合话题"刷高 → 聚簇判据不变（shared≥2 tokens 等），与主榜同风险同接受 → [WARN，同主榜]
  攻击 5：hn-auto 提交漏 t7 文件 → 页面区块读旧数据 → file_pattern + git-state + Recover 注释已同步三投影；漏提交只致
          该文件滞后一天，不损坏 → [BLOCKED]
  攻击 6：/best p2 引入大量首轮冷抓 → run 时长上升 → 首轮一次性 ~70 全量（实测数分钟），此后 freshness 命中回落；
          jobs=5 并发 + 20s 超时既有约束 → [WARN]
  攻击 7：lead 帖 Algolia 讨论抓取永不发生 → 周报引文缺 source → 周报只用已成文/已归档帖引文，归档缺帖跳过引文（skill
          W1 既有规则）→ [BLOCKED]
  已接受风险：registry 月增 ~1500 条目（JSON ~0.5MB/月，一年 ~6MB——年度 prune 政策延后处理）；探活需求贴容量上限
             （126/120 每日）导致复活检测延迟缓慢增长；旧快照错误 c 值保留（append-only 原则）
  门禁：PASS（无 MISSED 高危）
```

## 五、成本

- HN 请求：+4 页 GET/run（best×2 + news×2），共 12 GET/日；lead 零 per-thread 请求
- LLM：0（采样与聚合全确定性）
- 存储：快照 +~80 行/run；registry +~40 条/日；master +1 投影文件（~47KB）
- CI：hn-fetch run 略增（首轮明显，稳态 freshness 命中后净耗时近似——旧 descendants bug 造成的每轮全量重抓被修复抵消）

## 六、已验证（2026-10-25 本地实测）

- 干跑：best 60 + news 40（≥50 过滤）→ 增量 18（11 全量 + 7 lead），采样并集 78
- descendants 修复：对 Firebase 抽验 1504pt 帖 240/656/640/264/367 全对；age title 属性 3/3 精确等于 Firebase time
- 真实 run ×2：首轮 70 fetched / 77 快照行 / registry 108；二轮 33 fetched + 37 cached（真实评论增量），无重复快照/registry 行
- lead 形态：7 条 registry 条目（精确 posted_at + 真实 descendants）+ 2 快照点，无 thread 文件
- hot-check 差分通道对当日新采数据实发 `TRIGGER`（50220913）——lead/多页采样的提前可见性兑现
- `hn-heat.rb --all`：三投影生成（96 topics / 12 industries；当前仅 1 个 heat 日，7d=90d 属预期，随天数分化）
- 编码修复后 scrape 复测 C1=0；本地 registry 4 条 mojibake 回填；`make build` 全绿（trends 页正常，t90/本周区块 <3 heat 日按空数据规则隐藏）
- `check-cli.rb` PASS（--lists 声明与全部调用处一致）
