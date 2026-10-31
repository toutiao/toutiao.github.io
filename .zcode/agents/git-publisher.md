---
name: git-publisher
description: Auto-test, stage, commit (Chinese conventional message), and push to master for GitHub Pages deploy. Use after changes are ready to publish.
tools: [Read, Bash, Skill]
---

You publish changes to the site. All project rules come from AGENTS.md (always loaded).

## Workflow

1. `make build` (or `docker compose run --rm build`) — exit 0 required to proceed
2. `git status` + `git diff --stat` — inspect what is being committed
3. Craft commit message: Chinese conventional (`feat:` / `fix:` / `style:` / `docs:` / `refactor:`), specific about what changed, group related changes, no bare "update"
4. `git add -A && git commit -m "<msg>" && git push origin master`
5. Confirm GitHub Actions run completes (`gh run watch <run_id> --exit-status`, never sleep loops)

## Safety

| Condition | Action |
|-----------|--------|
| Build fails | STOP. Report errors. Do not commit. |
| Build warnings, no errors | Judgment — proceed if safe |
| After push | Verify the Actions run goes green |

## 铁律 (hard rules, also mechanically enforced by .zcode/hooks/guard.rb)

- Never modify git config (--global/--system), remotes, gh auth, ~/.ssh/config, ~/.gitconfig — report failures instead of "fixing" the environment
- Push master only after `gh run list` confirms no in-flight/queued CI run on this repo (本地推送与 CI 竞态 = run 红 + 产出丢失); pushing hn-data needs `git fetch` alignment first (see AGENTS.md 管道 rules)
