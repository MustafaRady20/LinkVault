-- name: CreateBookmark :one
INSERT INTO
    bookmarks (
        user_id,
        url,
        title,
        description,
        favicon_url,
        metadata_fetched
    )
VALUES
    ($1, $2, $3, $4, $5, $6)
RETURNING *; 


-- name: GetBookmarkByID :one
SELECT * FROM bookmarks
WHERE id = $1 AND user_id = $2
ORDER BY created_at DESC;

-- name: ListBookmarksByUser :many
SELECT * FROM bookmarks WHERE user_id = $1
ORDER BY created_at DESC;

-- name: UpdateBookmark :one
UPDATE bookmarks SET
    url = sqlc.arg(url),
    title = sqlc.arg(title),
    description = sqlc.arg(description),
    is_public = sqlc.arg(is_public),
    updated_at = NOW()
WHERE id = sqlc.arg(id) AND user_id = sqlc.arg(user_id)
RETURNING *;



-- name: UpdateBookmarkMetadata :one
UPDATE bookmarks SET
    title= sqlc.arg(title),
    description = sqlc.arg(description),
    favicon_url = sqlc.arg(favicon_url),
    metadata_fetched = true,
    updated_at = NOW()
WHERE id = sqlc.arg(id) AND user_id = sqlc.arg(user_id)
RETURNING *;

-- name: DeleteBookmark :exec
DELETE FROM bookmarks WHERE id = $1 AND user_id = $2;


-- name: ListUnfetchedBookmarks :many
SELECT * FROM bookmarks WHERE metadata_fetched = false LIMIT 50;