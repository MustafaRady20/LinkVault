CREATE TABLE
    IF NOT EXISTS users (
        id UUID  DEFAULT gen_random_uuid (),
        email VARCHAR(255)  NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );



ALTER TABLE users
    ADD CONSTRAINT unique_email
    UNIQUE (email);

ALTER TABLE users
    ADD CONSTRAINT pm_key
    PRIMARY KEY (id);