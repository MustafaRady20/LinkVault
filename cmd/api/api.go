package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/MustafaRady20/LinkVault/internal/config"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

type application struct {
	cfg *config.Config
}

func (a *application) mount() http.Handler {
	r := chi.NewRouter()
	r.Use(middleware.RequestID)
	r.Use(middleware.RealIP)
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	r.Use(middleware.Timeout(60 * time.Second))

	return r
}

func (a *application) run(mux http.Handler) error {
	srv := http.Server{
		Addr:         a.cfg.App.Port,
		Handler:      mux,
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	fmt.Printf("Server is up and running on port %s", a.cfg.App.Port)
	return srv.ListenAndServe()

}
