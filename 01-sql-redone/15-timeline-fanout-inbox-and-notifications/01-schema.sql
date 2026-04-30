CREATE TABLE users (id integer PRIMARY KEY, handle text NOT NULL UNIQUE);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id));
CREATE TABLE mutes (muter_id integer REFERENCES users(id), muted_id integer REFERENCES users(id), PRIMARY KEY (muter_id, muted_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id));

CREATE TABLE posts (
  id integer PRIMARY KEY,
  author_id integer NOT NULL REFERENCES users(id),
  body text NOT NULL,
  created_at timestamp NOT NULL
);

CREATE TABLE home_timeline_items (
  user_id integer NOT NULL REFERENCES users(id),
  post_id integer NOT NULL REFERENCES posts(id),
  fanout_reason text NOT NULL,
  inserted_at timestamp NOT NULL,
  PRIMARY KEY (user_id, post_id)
);

CREATE TABLE notification_inbox (
  id integer PRIMARY KEY,
  recipient_id integer NOT NULL REFERENCES users(id),
  actor_id integer NOT NULL REFERENCES users(id),
  notification_type text NOT NULL,
  source_event_id text NOT NULL,
  created_at timestamp NOT NULL,
  read_at timestamp
);

