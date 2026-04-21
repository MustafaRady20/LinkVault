package main

import (
	"log"

	"github.com/MustafaRady20/LinkVault/internal/config"
)

func main() {
	cfg, err := config.Load()
	if err != nil {
		log.Fatal(err)
	}

	app := &application{
		cfg: cfg,
	}

	mux := app.mount()
	err = app.run(mux)
	if err != nil {
		log.Fatalf("failed to run application: %v", err)
	}
}
