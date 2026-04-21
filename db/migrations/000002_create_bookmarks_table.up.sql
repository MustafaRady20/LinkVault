CREATE TABLE IF NOT EXISTS bookmarks (
    id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id          UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    url              URL        NOT NULL,
    title            TEXT,
    description      TEXT,
    favicon_url      TEXT,
    is_public        BOOLEAN     NOT NULL DEFAULT FALSE,
    metadata_fetched BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, url)
);

CREATE INDEX idx_bookmarks_user_id   ON bookmarks(user_id, created_at);