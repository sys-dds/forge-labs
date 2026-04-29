-- Handles and emails are required facts. The handle format check prevents values that cannot safely appear in URLs.
CREATE TABLE users (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, handle text NOT NULL UNIQUE CHECK (handle ~ '^[a-z0-9_]{3,20}$'), email text NOT NULL UNIQUE CHECK (position('@' in email) > 1), created_at timestamptz NOT NULL DEFAULT now());
INSERT INTO users (handle, email) VALUES ('ada','ada@forge.test'),('grace','grace@forge.test'),('linus','linus@forge.test'),('margaret','margaret@forge.test');
