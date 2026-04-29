CREATE TABLE feed_posts (
  id integer PRIMARY KEY,
  author_handle text NOT NULL,
  body text NOT NULL,
  created_at timestamp NOT NULL
);
