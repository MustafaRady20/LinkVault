package main

import (
	"log"

	"github.com/MustafaRady20/LinkVault/internal/config"
	"github.com/MustafaRady20/LinkVault/internal/repository"
)

func main() {
	cfg, err := config.Load()
	if err != nil {
		log.Fatal(err)
	}

	connPool, err := connectDB(cfg)
	if err != nil {
		log.Fatalf("failed to connect to database: %v", err)
	}

	store := repository.NewSQLStore(connPool)
	app := &application{
		cfg:   cfg,
		store: store,
	}

	mux := app.mount()
	err = app.run(mux)
	if err != nil {
		log.Fatalf("failed to run application: %v", err)
	}
}
