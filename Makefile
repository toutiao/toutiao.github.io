.PHONY: build build-fast serve test deploy clean fetch fetch-best hn-archive-init

build:
	docker compose run --rm build

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

fetch-best:
	docker compose run --rm build ruby scripts/hn-fetch.rb --best --fetch-articles-simple --jobs 5

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
