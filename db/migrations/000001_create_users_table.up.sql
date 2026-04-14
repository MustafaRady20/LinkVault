CREATE TABLE
    IF NOT EXISTS users (
        id UUID  PRIMARY KEY  NOT NULL DEFAULT gen_random_uuid (),
        email VARCHAR(255)  NOT NULL,
        password_hash VARCHAR(255) NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );



ALTER TABLE users
    ADD CONSTRAINT unique_email
    UNIQUE (email);
