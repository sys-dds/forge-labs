CREATE TABLE users (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE
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

