CREATE TABLE users (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE,
  email text NOT NULL
);

CREATE TABLE profiles (
  user_id integer PRIMARY KEY REFERENCES users(id),
  display_name text NOT NULL,
  bio text NOT NULL,
  is_searchable boolean NOT NULL
);

CREATE TABLE posts (
  id integer PRIMARY KEY,
  author_id integer NOT NULL REFERENCES users(id),
  body text NOT NULL,
  is_hidden boolean NOT NULL
);

CREATE TABLE post_likes (
  post_id integer NOT NULL REFERENCES posts(id),
  user_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (post_id, user_id)
);

CREATE TABLE comments (
  id integer PRIMARY KEY,
  post_id integer NOT NULL REFERENCES posts(id),
  user_id integer NOT NULL REFERENCES users(id),
  body text NOT NULL
);

CREATE TABLE follows (
  follower_id integer NOT NULL REFERENCES users(id),
  followee_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE blocks (
  blocker_id integer NOT NULL REFERENCES users(id),
  blocked_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (blocker_id, blocked_id)
);
