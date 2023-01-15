init: docker-down-clear docker-pull docker-build-n-pull app-init docker-up
down: docker-down-clear
check: cs-lint psalm-analyze test

docker-up:
	docker compose up -d
docker-down-clear:
	docker compose down -v --remove-orphans
docker-pull:
	docker compose pull
docker-build-n-pull:
	docker compose build --pull

app-init: composer-install
composer-install:
	docker compose run --rm php-cli composer install

cs-lint:
	docker compose run --rm php-cli composer php-cs-fixer fix -- --dry-run --diff
cs-fix:
	docker compose run --rm php-cli composer php-cs-fixer fix

psalm-analyze:
	docker compose run --rm php-cli composer psalm -- --no-diff

test: composer-test
composer-test:
	docker compose run --rm php-cli composer test
