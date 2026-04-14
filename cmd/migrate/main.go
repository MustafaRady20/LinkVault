package main

import (
	"errors"
	"log"
	"os"

	"github.com/MustafaRady20/LinkVault/internal/config"
	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
)

func main() {
	if len(os.Args) < 2 {
		log.Fatal("usage: migrate [up|down]")
	}

	cfg, err := config.Load()
	if err != nil {
		log.Fatalf("failed to load config: %v", err)
	}

	m, err := migrate.New("file://db/migrations", cfg.DSN())
	if err != nil {
		log.Fatalf("failed to create migrate instance: %v", err)
	}

	defer func() {
		srcErr, dbErr := m.Close()
		if srcErr != nil {
			log.Printf("failed to close source: %v", srcErr)
		}
		if dbErr != nil {
			log.Printf("failed to close database: %v", dbErr)
		}
	}()

	switch os.Args[1] {
	case "up":
		if err := m.Up(); err != nil && !errors.Is(err, migrate.ErrNoChange) {
			log.Fatalf("failed to apply migrations: %v", err)
		}
	case "down":
		if err := m.Steps(-1); err != nil && !errors.Is(err, migrate.ErrNoChange) {
			log.Fatalf("failed to rollback migrations: %v", err)
		}
	default:
		log.Fatal("unknown command: %v", os.Args[1])
	}
}
