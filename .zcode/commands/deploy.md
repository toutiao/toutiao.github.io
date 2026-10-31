---
description: Build 门禁 → 暂存 → 中文约定式提交 → push master（Pages 分支构建自动部署）
argument-hint: "[commit message（省略则自动拟）]"
---

完整发布流程：

1. `make build` — exit 0 才能继续；失败 → 停止并报告错误，不得提交
2. `git status` + `git diff --stat` 检查将提交的内容
3. 提交 message：中文约定式（`feat:`/`fix:`/`style:`/`docs:`/`refactor:` 前缀），具体描述改动；用户给了 message（`$ARGUMENTS`）则用之
4. `git add -A && git commit && git push origin master`
5. `gh run watch <run_id> --exit-status` 确认 Actions 转绿（不要 sleep 循环）

铁律（.zcode hooks 也会拦）：不碰 git config --global/--system、git remote、gh auth、~/.ssh/config、~/.gitconfig。推送前 `gh run list` 确认无在跑/延迟的 CI run，避免与 CI 竞态（AGENTS.md 管道规则）。
