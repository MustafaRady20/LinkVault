package repository

import (
	"context"

	db "github.com/MustafaRady20/LinkVault/db/sqlc"
	"github.com/google/uuid"
)

type TagRepository interface {
	CreateTag(ctx context.Context, arg db.CreateTagParams) (db.Tag, error)
	GetTagByID(ctx context.Context, arg db.GetTagByIDParams) (db.Tag, error)
	ListTagsByUser(ctx context.Context, userID uuid.UUID) ([]db.Tag, error)
	DeleteTag(ctx context.Context, arg db.DeleteTagParams) error
	AddTagToBookmark(ctx context.Context, arg db.AddTagToBookmarkParams) error
	RemoveBookmarkTag(ctx context.Context, arg db.RemoveBookmarkTagParams) error
	ListTagsByBookmark(ctx context.Context, bookmarkID uuid.UUID) ([]db.Tag, error)
}
