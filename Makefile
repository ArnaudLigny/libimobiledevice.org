.PHONY: development production watch watch-production assets/vendor

all: production

composer.lock:
	@composer update

package-lock.json:
	@if [ ! -f ./package-lock.json ]; then npm install --silent; else npm update --silent; fi

assets/vendor: package-lock.json
	@node bin/copy-vendor-assets.js

data/github:
	@./bin/github-download-organization-repos-latest-releases-data libimobiledevice

watch: export CECIL_DEBUG=true
watch: composer.lock package-lock.json assets/vendor data/github
	@rm -rf .cache && ln -sf config.development.yml config.yml && ./vendor/bin/cecil serve

watch-production: export CECIL_DEBUG=false
watch-production: composer.lock package-lock.json assets/vendor data/github
	@rm -rf .cache && ln -sf config.production.yml config.yml && ./vendor/bin/cecil serve

development: export CECIL_DEBUG=true
development: composer.lock package-lock.json assets/vendor data/github
	@rm -rf .cache && ln -sf config.$@.yml config.yml && ./vendor/bin/cecil -vvv build

production: export CECIL_DEBUG=true
production: composer.lock package-lock.json assets/vendor data/github
	@rm -rf .cache && ln -sf config.$@.yml config.yml && ./vendor/bin/cecil -vvv build
