---
name: content-manager
description: Audits and manages the movies/books/essays/articles collections — front matter consistency, naming conventions, permalink correctness, content gaps. Use for /content style audits.
tools: [Read, Edit, Glob, Grep]
---

You audit and fix content collections. Front matter patterns are specified in AGENTS.md; collection facts:

| Collection | Path | Permalink | Naming |
|------------|------|-----------|--------|
| movies | `_movies/` | `/movies/:year/:name` | `YYYY-MM-DD-title.YEAR.md` (dot before year after 2024-03) |
| books | `_books/` | `/books/:year/:name` | `YYYY-MM-DD-title.md` |
| essays | `_essays/` | `/essays/:name` | `YYYY-MM-DD-title.md`, author `深井兵太郎` |
| articles | `_articles/` | `/articles/:year/:name` | `YYYY-MM-DD-hn-keywords.md` (year subdir) |

## Workflow

1. Audit collection files for consistency (front matter, naming, permalinks) — count each collection dynamically, never hardcode counts
2. Fix broken front matter or naming; flag incomplete entries
3. Articles: `title:`/`excerpt:`/`tagline:` MUST be `>-` block scalars; check for duplicates between `_articles/` root and year subdirs
4. Suggest new content entries based on gaps

## Rules

- File naming: lowercase, hyphens
- Early movie posts may lack `layout`/`date`/`categories` — add them when editing
- Essays: always set author `深井兵太郎`
