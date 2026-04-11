# =========================
# Variables
# =========================
APP_NAME=api
BIN_DIR=./bin
MAIN_PATH=./cmd/api

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
.PHONY: migrate-up
migrate-up: ## placeholder — prints "migrate up (coming soon)"
	@echo "migrate up (coming soon)"

.PHONY: migrate-down
migrate-down: ## placeholder — prints "migrate down (coming soon)"
	@echo "migrate down (coming soon)"

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