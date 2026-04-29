-- Posts are one-to-many: Ada appears once in users but can own many posts.
CREATE TABLE posts (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  author_id integer NOT NULL REFERENCES users(id),
  body text NOT NULL
);
INSERT INTO posts (author_id, body) VALUES
  (1,'Ada first post'),(1,'Ada second post'),(2,'Ben one post');

