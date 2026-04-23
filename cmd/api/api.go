package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
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
		WriteTimeout: 60 * time.Second,
		ReadTimeout:  60 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	fmt.Printf("Server is up and running on port %s", a.cfg.App.Port)
	return srv.ListenAndServe()

}

func (a *application) connectDB() (*sql.DB, error) {
	conn, err := sql.Open("postgres", a.cfg.DSN())
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer conn.Close()

	conn.SetMaxOpenConns(a.cfg.DB.MaxOpenConn)
	conn.SetMaxIdleConns(a.cfg.DB.MaxIdleConn)
	conn.SetConnMaxIdleTime(time.Duration(a.cfg.DB.MaxIdleTime) * time.Second)

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := conn.PingContext(ctx); err != nil {
		log.Fatalf("Failed to ping database: %v", err)
	}

	return conn, nil
}
