.PHONY: docs

all: build

build: ## Build beulogue
	shards build

build-release: ## Build beulogue in release mode
	shards build --release

build-static:
	docker run --rm -it -v ${CURDIR}:/workspace -w /workspace crystallang/crystal:0.35.1-alpine sh /workspace/build.sh

build-and-run: build docs ## Build and run in docs

deploy: docs ## Deploy using Apex Up
	up deploy production

docker-build: ## Build docker image
	docker build -t siegfriedehret/beulogue .

git-push: check-env ## Push all the things
	git push ;\
	git tag release-$(VERSION) ;\
	git push --tags

install: ## Install dependencies for beulogue
	shards install

check-env: ## Check that VERSION is present
ifndef VERSION
	$(error VERSION is undefined (make release VERSION=x.x.x))
endif

check-target: ## Check that ARCH is present
ifndef ARCH
	$(error ARCH is undefined (make release-archive ARCH=linux))
endif

release-archive: build-release check-target ## Make a tar.gz archive from the binary
	cd bin ;\
	tar czf beulogue-$(ARCH).tar.gz beulogue

release: release-archive git-push ## Release beulogue

test: ## Run tests
	crystal spec

beulogue: ## Run beulogue
	cd docs ;\
	beulogue ;\

docs-static: ## Bidouille static files
	cp docs/templates/*.css docs/public/

docs: beulogue docs-static ## Run in docs

update: ## Update dependencies
	shards update

help: ## Print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'