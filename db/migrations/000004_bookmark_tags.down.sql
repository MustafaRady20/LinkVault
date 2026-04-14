ALTER TABLE bookmark_tags
    DROP CONSTRAINT IF EXISTS bookmark_tag_pm_key;

ALTER TABLE bookmark_tags
    DROP CONSTRAINT IF EXISTS fk_bookmark;

ALTER TABLE bookmark_tags
    DROP CONSTRAINT IF EXISTS fk_tag;

DROP TABLE IF EXISTS bookmark_tags;
