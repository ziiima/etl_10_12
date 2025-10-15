.PHONY: compose.up, compose.exec

compose.up:
	docker compose -f compose.yaml up -d --build
	docker compose logs -f

compose.exec:
	docker exec -it etl_container bash

PROJECT_DIR ?= /usr/src/app/benefit
MODEL ?= stg_commerce
PROFILE_DIR ?= /usr/src/app/benefit
DBT_OPTS := --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILE_DIR)

run:
	uv run dbt run $(DBT_OPTS) --select $(MODEL)

run-debug:
	uv run dbt run $(DBT_OPTS) --select $(MODEL) --debug

compile:
	uv run dbt compile $(DBT_OPTS) --select $(MODEL)

test:
	uv run dbt test $(DBT_OPTS) --select $(MODEL)

run-all:
	uv run dbt run $(DBT_OPTS)

