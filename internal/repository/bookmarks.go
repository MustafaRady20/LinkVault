package repository

import (
	"context"

	db "github.com/MustafaRady20/LinkVault/db/sqlc"
)

type BookmarkRepository interface {
	CreateBookmark(ctx context.Context, arg db.CreateBookmarkParams) (db.Bookmark, error)
	GetBookmarkByID(ctx context.Context, arg db.GetBookmarkByIDParams) (db.Bookmark, error)
	UpdateBookmark(ctx context.Context, arg db.UpdateBookmarkParams) (db.Bookmark, error)
	UpdateBookmarkMetadata(ctx context.Context, arg db.UpdateBookmarkMetadataParams) (db.Bookmark, error)
	DeleteBookmark(ctx context.Context, arg db.DeleteBookmarkParams) error
	ListUnfetchedBookmarks(ctx context.Context) ([]db.Bookmark, error)
}
