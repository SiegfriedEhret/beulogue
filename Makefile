all: build

build: ## Build beulogue
	shards build

build-and-run: build ## Build and run in test-site
	cd test-site;\
	beulogue

install: ## Install dependencies for beulogue
	shards install

release: build ## Release beulogue
	cd bin ;\
	tar czf beulogue-linux.tar.gz beulogue

update: ## Update dependencies
	shards update

help: ## Print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'