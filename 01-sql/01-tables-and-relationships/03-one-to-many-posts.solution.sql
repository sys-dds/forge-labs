-- Posts are one-to-many: one user can author many posts, but each post has exactly one author.
-- The foreign key rejects orphan posts.
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, author_id integer NOT NULL REFERENCES users(id), body text NOT NULL, created_at timestamptz NOT NULL DEFAULT now());
INSERT INTO posts (author_id, body) VALUES (1,'Tables make backend facts explicit.'),(1,'Foreign keys connect those facts.'),(2,'One-to-many means many posts can point at one user.');
