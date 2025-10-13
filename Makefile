.PHONY: compose.up, compose.exec

compose.up:
	docker compose -f compose.yaml up -d --build
	docker compose logs -f

compose.exec:
	docker exec -it etl_container bash
