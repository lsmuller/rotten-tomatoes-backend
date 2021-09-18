setup:
	@go get github.com/go-pg/migrations/v8

deps:
	@docker-compose --file boot/docker-compose.yaml --project-name=rotten-tomatoes-backend up --no-recreate -d postgres
	@make migrate

kill-deps:
	@docker-compose --project-name=rotten-tomatoes-backend -f ./boot/docker-compose.yaml down

## migrate: execute the postgres migration; use ADDRESS="" and PASSWORD="" to specify another database
ADDRESS := localhost:9000
PASSWORD := ""
migrate:
	@echo "Running migration on database: $(ADDRESS)"
	@cd migrations && go run *.go -address $(ADDRESS) -pass $(PASSWORD)

## migrate: execute the postgres rollback migration; use ADDRESS="" and PASSWORD="" to specify another database
ADDRESS := localhost:9000
PASSWORD := ""
migrate-down:
	@echo "Running rollback migration on database: $(ADDRESS)"
	@cd migrations && go run *.go down -address $(ADDRESS) -pass $(PASSWORD)

## migration-version: get the current version of migrations on database; use ADDRESS="" and PASSWORD="" to specify another database
migration-version:
	@cd migrations && go run *.go -address $(ADDRESS) -pass $(PASSWORD) version