CREATE TABLE users (id integer PRIMARY KEY, handle text NOT NULL UNIQUE);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id), CHECK (follower_id<>followee_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id));
CREATE TABLE mutes (muter_id integer REFERENCES users(id), muted_id integer REFERENCES users(id), PRIMARY KEY (muter_id, muted_id));
