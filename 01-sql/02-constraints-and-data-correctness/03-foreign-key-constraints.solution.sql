-- Posts depend on real users. ON DELETE CASCADE is chosen because these chapter posts are owned content, not audit records.
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, author_id integer NOT NULL REFERENCES users(id) ON DELETE CASCADE, body text NOT NULL CHECK (length(body) > 0), created_at timestamptz NOT NULL DEFAULT now());
INSERT INTO posts (author_id, body) VALUES (1,'Constraints protect data.'),(2,'Foreign keys reject ghosts.');
