---
description: 审计内容 collections 与 front matter 一致性
---

审计全部内容 collections：`_movies/`、`_books/`、`_essays/`、`_articles/**/`。逐 collection 动态计数（不硬编码数量）。检查：

- front matter 缺字段（早期 movie 帖可能只有 `title`）
- 命名规范漂移（dot-before-year vs 纯日期）
- Articles 的 `title:`/`excerpt:`/`tagline:` 必须 `>-` block scalar（ASCII `"` 会破坏 YAML）
- `_articles/` 根级旧文与年份子目录间的重复/陈旧文章
- `_books/`、`_essays/` 是否已有实际文章

发现问题：能直接修的修掉，需判断的列出清单报告。
