CREATE TABLE posts (
  id integer PRIMARY KEY,
  title text NOT NULL
);

CREATE TABLE comments (
  id text PRIMARY KEY,
  post_id integer NOT NULL REFERENCES posts(id),
  parent_id text REFERENCES comments(id),
  body text NOT NULL,
  sort_order integer NOT NULL
);

