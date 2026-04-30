CREATE TABLE users (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE,
  email text NOT NULL
);

CREATE TABLE profiles (
  user_id integer PRIMARY KEY REFERENCES users(id),
  display_name text NOT NULL,
  is_searchable boolean NOT NULL
);

CREATE TABLE follows (
  follower_id integer NOT NULL REFERENCES users(id),
  followee_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (follower_id, followee_id),
  CHECK (follower_id <> followee_id)
);

CREATE TABLE blocks (
  blocker_id integer NOT NULL REFERENCES users(id),
  blocked_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (blocker_id, blocked_id),
  CHECK (blocker_id <> blocked_id)
);

CREATE TABLE posts (
  id integer PRIMARY KEY,
  author_id integer NOT NULL REFERENCES users(id),
  body text NOT NULL,
  is_hidden boolean NOT NULL,
  created_at timestamp NOT NULL
);

