CREATE TABLE IF NOT EXISTS bookmark_tags (
    bookmark_id UUID NOT NULL,
    tag_id UUID NOT NULL,
   
);

ALTER TABLE bookmark_tags
    ADD CONSTRAINT bookmark_tag_pm_key
    PRIMARY KEY (bookmark_id, tag_id);

ALTER TABLE bookmark_tags
    ADD CONSTRAINT fk_bookmark
    FOREIGN KEY (bookmark_id) REFERENCES bookmarks (id) ON DELETE CASCADE;

ALTER TABLE bookmark_tags
    ADD CONSTRAINT fk_tag
    FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE;
