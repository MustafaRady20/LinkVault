# =========================
# Variables
# =========================
APP_NAME=api
BIN_DIR=./bin
MAIN_PATH=./cmd/api
MIGRATIONS_PATH=./db/migrations
SQLC_VERSION=v1.27.0

# =========================
# Help
# =========================
.PHONY: help
help: ## Print all available targets with descriptions
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

# =========================
# Build
# =========================
.PHONY: build
build: ## go build the binary into ./bin/api
	@mkdir -p $(BIN_DIR)
	go build -o $(BIN_DIR)/$(APP_NAME) $(MAIN_PATH)

# =========================
# Run
# =========================
.PHONY: run
run: ## go run the app locally
	go run $(MAIN_PATH)

# =========================
# Test
# =========================
.PHONY: test
test: ## go test ./... with race detector and verbose
	go test ./... -race -v

# =========================
# Docker
# =========================
.PHONY: docker-up
docker-up: ## docker compose up -d --build
	docker-compose up -d --build

.PHONY: docker-down
docker-down: ## docker compose down
	docker-compose down

.PHONY: docker-logs
docker-logs: ## docker compose logs -f
	docker-compose logs -f

# =========================
# Migrations
# =========================

.PHONY: migrate-create
migrate-create: ## Create a new migration: make migrate-create NAME=create_something
	migrate create -ext sql -dir $(MIGRATIONS_PATH) -seq $(NAME)

.PHONY: migrate-up
migrate-up: ## Run all pending migrations
	go run ./cmd/migrate up

.PHONY: migrate-down
migrate-down: ## Run all down migrations
	go run ./cmd/migrate down

.PHONY: db-shell
db-shell:
	docker exec -it linkvault_db psql -U postgres -d linkvault
	
.PHONY: db-tables
db-tables:
	docker exec -it linkvault_db psql -U postgres -d linkvault -c "\dt"


.PHONY: sqlc
sqlc:  ## Generate type-safe Go code from SQL queries
	go run github.com/sqlc-dev/sqlc/cmd/sqlc@$(SQLC_VERSION) generate
	
# =========================
# Lint
# =========================
.PHONY: lint
lint: ## runs go vet ./...
	go vet ./...

# =========================
# Go Modules
# =========================
.PHONY: tidy
tidy: ## go mod tidy
	go mod tidy

# =========================
# Clean
# =========================
.PHONY: clean
clean: ## removes ./bin/
	rm -rf $(BIN_DIR)