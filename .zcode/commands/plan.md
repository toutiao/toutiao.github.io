---
description: 分析项目现状，提出下一步 1-3 个最有价值的工作项
---

分析项目结构与近期改动，产出下一步计划。考虑：

- 近期方向：`git log --oneline -10`
- 架构事实来源：`.opencode/designs/*.md`（hn-signal-architecture + phase2 + phase3）
- 内容缺口（movies/books/essays 待补、articles 题材分布）
- 站点改进（布局/导航/SEO/性能）
- 管道技术债（scripts/*.rb、workflows、成本）
- 热度数据现状：`_data/hn_trends*.json` 覆盖情况

输出：1-3 个最有价值的任务，每个附理由与实施要点。实现可交给对应 subagent（jekyll-builder / content-manager / self-evolve / git-publisher / hn-summarizer）。
