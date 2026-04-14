CREATE TABLE IF NOT EXISTS tags (
    id UUID  DEFAULT gen_random_uuid (),
    user_id UUID NOT NULL, 
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE tags
    ADD CONSTRAINT tag_pm_key
    PRIMARY KEY (id);

ALTER TABLE tags
    ADD CONSTRAINT unique_tag_name
    UNIQUE (user_id, name);

ALTER TABLE tags
    ADD CONSTRAINT fk_user
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
