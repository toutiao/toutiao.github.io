# HN 信号架构二期 — 时间维度与话题延续优化方案

> 状态: 方案（待批准实施）| 日期: 2026-10-24 | 前置: [hn-signal-architecture.md](hn-signal-architecture.md)（一期已实施）
> 议题: 原「2 周保存窗口」为拍脑门的存储/热度折中。冷档分支落地后约束已变，本方案评估实际限制并给出时间轴/关联延续/行业维度设计，消除 2 周数据跳跃。

## 一、量化评估（结论先行）

### 1.1 存储约束实测不成立 —— 2 周窗口的历史使命已结束

| 项 | 实测值 | 限制 | 占用 |
|---|---|---|---|
| 单周 cache 目录 | 1.5 MB | — | — |
| cache 池周增量（21 entry/周 × 1.5MB） | ~30 MB | 10 GB/repo | **0.3%** |
| hn-cache/restore 耗时（CI 实测） | ~1 s | — | 可忽略 |
| hn-cache/save 耗时 | ~1 s | — | 可忽略 |
| hn-data 分支月增速 | ~5 MB 原始（git 压缩后） | 软限 ~5GB | 可忽略 |

一期改造后**历史保存职责已移交 hn-data 分支**，cache 只剩三个残存职能：skill 候选池（stories.yaml）、缓存命中去重、article.yaml 2 周可用性。三者皆可被归档替代（见二.1）。
结论：**「平衡存储大小」不再是有效约束，窗口长度应由 HN 讨论动力学而非存储决定**。

### 1.2 HN 评论衰减实测（归档 32 帖 / 3200 评论）

| 到达时段 | 占比 |
|---|---|
| 0-24h | **97.2%** |
| 1-3d | 2.7% |
| 3-7d / 7-14d / >14d | ≈0%（受 COMMENT_CAP=100 截断，尾部被低估） |

尾部稀疏但真实存在：W27 "Claude Sonnet 5" 帖 3 个月 +660 评论（探活实测捕获）。
结论：**观察窗应前密后疏分层**——活跃判定收紧（高频刷新只服务 24-72h 内的 97%），稀疏长尾交给低频探活，而非拉宽单一窗口。

### 1.3 现存 4 类「2 周跳跃」缺口

| # | 缺口 | 现状 | 危害 |
|---|---|---|---|
| G1 | 候选池跳变 | skill Phase 0 读 stories.yaml（仅 W+W-1）；2 周外复活帖/慢热帖不可见 | 漏选题 |
| G2 | 触发状态丢失 | `.triggers.yaml` 存 cache 周目录，2 周后蒸发 | 老帖未成文者可被重复 dispatch |
| G3 | article.yaml 2 周后消失 | skill 有 `--fetch-article-url` 重抓兜底 | 每帖多 1 次目标站请求 |
| G4 | settled 永不再探活 | 观察链 14d→45d 后归档即死 | **复活盲区**（+660 案例靠抢救巧合才捕获） |

## 二、方案

### 2.1 层 1 — 存储统一（目标态，推荐 Option B）

**删 cache 层，hn-data 分支为唯一存储**：

- article.yaml（含正文 ≤8000 字符）并入 `threads/YYYY/WNN/<id>.yaml`
- 候选池改由 registry 驱动（active + 复活帖），stories.yaml 弃用
- `.triggers.yaml` → `.hn-archive/triggers.json`（永久）
- hn-fetch 缓存命中去重改读归档（registry last_comment_count 已有，顺理成章）
- `.github/actions/hn-cache/` 删除，CI 步骤简化为 attach → fetch/poll → push
- G1/G2/G3/G4 中前三项**全部消失**，G4 由层 2 解决

代价：分支月增速 +~4MB 原始（article 8KB×15帖/日，压缩 ~1.5MB/月）——1.1 表约束下无压力。
风险：push 失败延后数据——已有 rebase 重试×3 + 下轮补写；**保留 hn-cache action 代码一个版本周期**作回滚预案。

> Option A（保守替代，仅作 B 降级预案）：cache 保留、restore 扩 3 周、候选池仍改 registry、触发状态仍入 archive。改动半天，但双写复杂度长存。**不推荐为终态**。

### 2.2 层 2 — 时间维度分层（替换单一 14d/45d）

| 层 | 进入条件 | 刷新策略 | 依据 |
|---|---|---|---|
| hot-active | ≤72h 内有增量 | 随 best 3x/日 | 97% 评论 24h 内，72h 覆盖 99.9% 常规轨迹 |
| active | ≤14d 内有增量 | 随 best 3x/日（best 页可见者自动覆盖） | 慢热帖（/best 无时间窗设计初衷） |
| warm | 14-45d 无增量 | 周探活（现状） | — |
| **cold（新）** | 45-180d | **月探活** | 填 G4 盲区；复活案例区间 |
| deep | >180d | 季探活 | 极稀疏兜底 |

探活预算封顶：warm ≤500 / cold ≤1000 / deep ≤2000，FIFO 跨层降级；每 run ≤40 请求（现状 POLL_BATCH_MAX）→ 最坏 ~9 请求/日，免费 API 下无感。

### 2.3 层 3 — 四个新维度

**D1 话题时间轴**
- topic 实体持久化：`topics.json` 的 topics 段改**增量合并**（新帖匹配现有 topic → 追加成员并更新 last_seen），不再每日重建（现 `t-<最老成员>` 幂等重建对成员漂移脆弱）
- 生命周期字段：`first_seen / peak_at / peak_heat / last_seen / waves`
- **waves 复波计数**：同一 topic 直方图出现 ≥7d 静默 gap 后再起量（gap 后新评论 ≥20 或 ≥峰值的 5%）→ `wave += 1`；trends 页标注「第 N 波」——话题延续的核心可视化
- trends 页 topic 时间轴视图：heat 曲线 + 成员帖到达点同轴标注

**D2 时间维度更新** = 层 2 分层 + 投影 `window_days` 参数化（30 → 可选 90，投影体积 ×3 仍 ≤150KB 可控；默认维持 30）

**D3 关联话题延续（topic 关系图）**
- 连接判据二选一：(a) 弱化关键词（主聚簇判据降一档：shared≥1 token）；(b) **专家群体重叠**——两 topic 各自 top-30 高分评论者中 cohort 成员交集 ≥3 人（「同一批专业用户在同时追两个话题」= 最强相关信号，本项目差异化所在）
- 输出 `related_topics`（双向, 带判据标记 keyword/cohort）；trends 页「相关话题」链接 + wave→wave 延续链
- 只展示不合并（对抗 Attack：同批人追不同话题误连）

**D4 行业大类相关性趋势**
- 确定性关键词→行业映射表 `category_map.json`（**versioned**，如 `category_version: c1`；首批 8-10 类：ai / security / infra / languages / hardware / devtools / policy-regulation / crypto-web3 / business / other）
- registry 帖级加 `category` 字段；映射优先级：标题关键词 > URL 域名规则
- 投影新增 `industries` 段：各行业 30d heat 总和曲线、周环比箭头、top-3 驱动话题
- trends 页「行业趋势」区：行业横向对比条 + 升降标记 + 驱动话题链接
- 误分类可见可修可回算（改表 → `hn-heat --recompute`）；**不用 LLM 分类**（成本 0 原则 + 确定性回算；Phase 4 若关键词覆盖率 <80% 再评估）

## 三、实施分期

| 期 | 内容 | 工作量 | 消除 |
|---|---|---|---|
| P1 快赢 | 触发状态入 archive；候选池 registry 驱动（skill Phase 0 改造）；cold 月探活 | ~半天 | G2 G4, G1(部分) |
| P2 存储统一 | article 入归档；hn-fetch 走 archive；stories.yaml 弃用；hn-cache 删除（留一版回滚） | 1-2 天 | G1 G3, cache 整层 |
| P3 维度层 | D1 时间轴+waves；D3 关联图；D4 行业趋势；D2 参数化；trends 页三区块 | ~2 天 | 跳跃之外的新能力 |
| P4 可选 | 90d 曲线、category 覆盖率评估、LLM 分类对比实验 | — | — |

每期独立可测可发布，遵守一期约束（本地真实 URL 测试 → make build → 对抗审查）。

## 四、第一性原理核验

| 假设 | 违背 | 捕捉 | 后果 |
|---|---|---|---|
| 归档可替代 cache 全部职能 | renderer fill 路径依赖 cache 目录 | P2 迁移时 fill 改读归档路径，本地真 URL 验证 | fill 功能回归（可修） |
| 分层探活预算有界 | 三层集合累积 | 各层 cap + FIFO + POLL_BATCH_MAX/run | 探活膨胀（远期） |
| waves 判据区分长尾与复波 | 平缓长尾误判 wave2 | gap≥7d + 起量阈值双条件 | wave 计数虚高（展示层 WARN） |
| cohort 重叠 ≠ 话题同质 | 同批专家追不同话题 | related 仅展示不合并 | 相关链接误导（WARN 接受） |
| category 关键词表覆盖 | 新词/行话漏分 | `other` 兜底 + 覆盖率周报 + 改表回算 | 行业曲线失真（可修） |
| 存储统一后 push 依赖加深 | push 连续失败 | 重试×3 + ::error:: + 下轮补写（threads 幂等合并） | 延迟数小时（非丢失） |

## 五、对抗审查

```
Adversarial Review:
  Attack 1: 删 cache 后 CI 全依赖分支可用性（GitHub 故障日数据断档）→ 当轮失败标红，恢复后下轮全量补写；快照/评论幂等合并无重复 → [BLOCKED]
  Attack 2: cold 月探活 1000 帖集中在同一天 → last_polled 错峰（按上次探活时间排序取到期者，天然滚动）→ [BLOCKED]
  Attack 3: waves 阈值拍脑袋 → 复波标记错误 → 仅展示层标注，正文/选题不受影响；30 天对照人工核 → [WARN]
  Attack 4: category 表初始覆盖不足 → 行业趋势大面积 other → 投影带 coverage% 字段，<80% 触发周报提醒补表 → [WARN]
  Attack 5: related_topics cohort 判据被小圈子刷（3 人门槛低）→ 门槛随 cohort 规模自适应（≥ max(3, cohort×1%)）→ [BLOCKED]
  Attack 6: article 正文永久入库的版权暴露 → 分支已 private？—— 否，仓库 public → 改为仅存提取后 markdown 摘要 + 原文链接（现状 8000 字符截断保留，分支为数据分支无 Pages 构建，与 _articles 引用原文摘要同等暴露水平）→ [WARN accepted，Phase 4 可评估 gzip+加密]
  Risk accepted: 90d 曲线投影体积增长；关键词表维护人工成本
  Gate: PASS（无 MISSED 高危）
```

## 六、成本

- LLM：0（全确定性）
- HN API：+cold/deep 探活最坏 ~9 请求/日（免费无 key）
- 存储：+article ~4MB/月原始 / ~1.5MB 压缩；删 cache 层净复杂度下降
- CI：步骤减少（cache restore/save 移除），净耗时不变
