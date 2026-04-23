package repository

import (
	"database/sql"

	db "github.com/MustafaRady20/LinkVault/db/sqlc"
)

type Store interface {
	UserRepository
	BookmarkRepository
	TagRepository
}

type SQLStore struct {
	*db.Queries
	connPool *sql.DB
}

func NewSQLStore(connPool *sql.DB) *SQLStore {
	return &SQLStore{
		Queries:  db.New(connPool),
		connPool: connPool,
	}
}
