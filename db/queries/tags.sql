-- name: CreateTag :one
INSERT INTO tags (user_id, name)
VALUES ($1, $2)
RETURNING *;

-- name: GetTagByID :one
SELECT * FROM tags WHERE id = $1 AND user_id = $2;


-- name: ListTagsByUser :many
SELECT * FROM tags WHERE user_id = $1 ORDER BY created_at DESC;

-- name: DeleteTag :exec
DELETE FROM tags WHERE id = $1 AND user_id = $2;


-- name: AddTagToBookmark :exec
INSERT INTO bookmark_tags (bookmark_id, tag_id)
VALUES ($1, $2);

-- name: RemoveBookmarkTag :exec
DELETE FROM bookmark_tags WHERE bookmark_id = $1 AND tag_id = $2;

-- name: ListTagsByBookmark :many
SELECT t.* FROM tags t
JOIN bookmark_tags bt ON t.id = bt.tag_id
WHERE bt.bookmark_id = $1;