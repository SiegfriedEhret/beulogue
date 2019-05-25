all: build

build: ## Build beulogue
	shards build

build-and-run: build run ## Build and run in docs

git-changelog: ## Commit changelog
	git add CHANGELOG.md ;\
	git commit -m ":memo: update changelog"

git-readme: ## Commit readme
	git add README.md ;\
	git commit -m ":memo: update readme"

git-src: ## Commit src
	git add src ;\
	git commit -m ":gift: update code"

git-push: check-env ## Push all the things
	git push ;\
	git tag release-$(VERSION) ;\
	git push --tags

git-docs: ## Commit docs
	git add docs ;\
	git commit -m ":gift: update test site"

git-version: ## Commit shards with new version
	git add shards.yml ;\
	git commit -m ":arrow_up: bump version"

install: ## Install dependencies for beulogue
	shards install

check-env: ## Check that VERSION is present
ifndef VERSION
	$(error VERSION is undefined (make release VERSION=x.x.x))
endif

check-target: ## Check that TARGET is present
ifndef TARGET
	$(error TARGET is undefined (make release-archive TARGET=linux))
endif

release-archive: build check-target ## Make a tar.gz archive from the binary
	cd bin ;\
	tar czf beulogue-$(TARGET).tar.gz beulogue

release: git-src git-docs git-changelog git-readme git-version release-archive git-push ## Release beulogue

run: ## Run in docs
	cd docs;\
	beulogue

update: ## Update dependencies
	shards update

help: ## Print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'