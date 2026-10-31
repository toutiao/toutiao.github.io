---
description: Build & validate Jekyll site in Docker（无本地 Ruby）
---

跑 `make build`（即 `docker compose run --rm build`）验证站点编译：

1. 检查输出中的错误与警告
2. 有错 → 修复后重建（改的是 Jekyll 可见内容时必须过此门）
3. 报告构建状态

注意：GFW 导致 api.github.com SSL 报错时按 AGENTS.md 的 proxy workaround 处理（`.env`），不改环境配置。
