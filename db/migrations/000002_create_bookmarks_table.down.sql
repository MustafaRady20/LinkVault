ALTER TABLE bookmarks
    DROP CONSTRAINT IF EXISTS fk_user;

ALTER TABLE bookmarks
    DROP CONSTRAINT IF EXISTS unique_user_url;

DROP TABLE IF EXISTS bookmarks;
