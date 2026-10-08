
include .env
export

export PROJECT_ROOT=$(shell pwd)

env-upp:
	docker compose up -d todoapp-postgres

env-down:
	docker compose down todoapp-postgres

env-port-forward:
	docker compose up -d port-forward

env-port-close:
	docker compose down port-forward

migrate-create:
	docker compose run --rm  todoapp-postgres-migrate --user "$(shell id -u):$(shell id -g)" create -ext sql -dir /migrations -seq $(seq)

migrate-up:
	$(MAKE) migrate-action action=up

migrate-down:
	$(MAKE) migrate-action action=down

migrate-action:
	docker compose run --rm todoapp-postgres-migrate -path=/migrations -database="postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@todoapp-postgres:5432/$(POSTGRES_DB)?sslmode=disable" $(action)