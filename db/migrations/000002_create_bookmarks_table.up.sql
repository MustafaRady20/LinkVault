CREATE TABLE
    IF NOT EXISTS bookmarks (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        user_id UUID ,
        url TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        is_public BOOLEAN NOT NULL DEFAULT FALSE,
        metadata_fetched BOOLEAN NOT NULL DEFAULT FALSE,
        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );

ALTER TABLE bookmarks
    ADD CONSTRAINT fk_user
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;

ALTER TABLE bookmarks
    ADD CONSTRAINT unique_user_url
    UNIQUE (user_id, url);