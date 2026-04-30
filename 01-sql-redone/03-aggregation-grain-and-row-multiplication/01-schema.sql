CREATE TABLE authors (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE
);

CREATE TABLE posts (
  id text PRIMARY KEY,
  author_id integer NOT NULL REFERENCES authors(id),
  is_hidden boolean NOT NULL,
  created_at timestamp NOT NULL
);

CREATE TABLE post_likes (
  post_id text NOT NULL REFERENCES posts(id),
  user_id integer NOT NULL,
  PRIMARY KEY (post_id, user_id)
);

CREATE TABLE comments (
  id integer PRIMARY KEY,
  post_id text NOT NULL REFERENCES posts(id),
  user_id integer NOT NULL,
  body text NOT NULL
);

