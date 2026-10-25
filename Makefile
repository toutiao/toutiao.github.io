.PHONY: build build-fast serve test deploy clean fetch fetch-hn lobsters hn-archive-init hn-archive-sync check-cli

build:
	docker compose run --rm build

check-cli:
	ruby scripts/check-cli.rb

serve:
	docker compose up jekyll

test: build

deploy:
	@[ -n "$(msg)" ] || (echo "Usage: make deploy msg='commit message'" && exit 1)
	docker compose run --rm build && \
	git add -A && \
	git commit -m "$(msg)" && \
	git push origin master

clean:
	docker compose down -v
	docker image prune -f

shell:
	docker compose run --rm build bash

logs:
	docker compose logs -f

build-fast:
	APT_MIRROR=mirrors.aliyun.com \
	GEM_MIRROR=https://gems.ruby-china.com \
	docker compose run --rm build

fetch:
	@[ -n "$(url)" ] || (echo "Usage: make fetch url='<hn_url>'" && exit 1)
	docker compose run --rm build ruby scripts/hn-fetch.rb --url "$(url)" --fetch-articles-simple

fetch-hn:
	docker compose run --rm build ruby scripts/hn-fetch.rb --lists --fetch-articles-simple --jobs 5

lobsters:
	docker compose run --rm build ruby scripts/lobsters-fetch.rb --hottest

# Push local .hn-archive/ working copy to the hn-data branch (the same worktree
# dance CI uses, packaged for local runs). File-level: local copy wins.
hn-archive-sync:
	@set -e; \
	TMP=$$(mktemp -d); \
	git fetch origin hn-data; \
	if git ls-remote --exit-code --heads origin hn-data >/dev/null 2>&1; then \
	  git worktree add "$$TMP" hn-data >/dev/null 2>&1 || git worktree add "$$TMP" -b hn-data >/dev/null 2>&1; \
	  git -C "$$TMP" reset --hard origin/hn-data -q; \
	else \
	  git worktree add --orphan -b hn-data "$$TMP" >/dev/null 2>&1; \
	  printf 'snapshots/**/*.jsonl merge=union\n' > "$$TMP/.gitattributes"; \
	fi; \
	cp -r .hn-archive/. "$$TMP/"; \
	git -C "$$TMP" add -A; \
	if git -C "$$TMP" diff --cached --quiet; then \
	  echo "archive: no changes"; \
	else \
	  git -C "$$TMP" commit -q -m "archive: local-sync $(shell date -u +%FT%TZ)"; \
	  git -C "$$TMP" push origin hn-data; \
	fi; \
	git worktree remove --force "$$TMP"; \
	echo "hn-data synced"

# Seed the hn-data orphan branch from the local .hn-archive working copy.
# Idempotent: skips if the branch already exists on origin.
hn-archive-init:
	@set -e; \
	if git ls-remote --exit-code --heads origin hn-data >/dev/null 2>&1; then \
	  echo "hn-data branch already exists on origin"; \
	else \
	  TMP=$$(mktemp -d); \
	  git worktree add --orphan -b hn-data "$$TMP"; \
	  if [ -d .hn-archive ]; then cp -r .hn-archive/. "$$TMP/"; fi; \
	  printf 'snapshots/**/*.jsonl merge=union\n' > "$$TMP/.gitattributes"; \
	  git -C "$$TMP" add -A; \
	  if git -C "$$TMP" diff --cached --quiet; then \
	    git -C "$$TMP" commit --allow-empty -m "chore: init hn-data archive branch"; \
	  else \
	    git -C "$$TMP" commit -m "chore: seed hn-data from local archive ($(shell date -u +%F))"; \
	  fi; \
	  git -C "$$TMP" push origin hn-data; \
	  git worktree remove --force "$$TMP"; \
	  echo "hn-data branch seeded and pushed"; \
	fi
