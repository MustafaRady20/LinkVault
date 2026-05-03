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

var _ Store = (*SQLStore)(nil)

func NewSQLStore(connPool *sql.DB) Store {
	return &SQLStore{
		Queries:  db.New(connPool),
		connPool: connPool,
	}
}
