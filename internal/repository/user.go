package repository

import (
	"context"

	db "github.com/MustafaRady20/LinkVault/db/sqlc"
	"github.com/google/uuid"
)

type UserRepository interface {
	CreateUser(ctx context.Context, arg db.CreateUserParams) (db.User, error)
	GetUserByEmail(ctx context.Context, email string) (db.User, error)
	GetUserByID(ctx context.Context, id uuid.UUID) (db.User, error)
	UpdateUser(ctx context.Context, arg db.UpdateUserParams) (db.User, error)
}
