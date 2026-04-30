CREATE TABLE users (id integer PRIMARY KEY, handle text NOT NULL UNIQUE);
CREATE TABLE groups (id integer PRIMARY KEY, name text NOT NULL UNIQUE);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id));
CREATE TABLE mutes (muter_id integer REFERENCES users(id), muted_id integer REFERENCES users(id), PRIMARY KEY (muter_id, muted_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id));
CREATE TABLE group_memberships (group_id integer REFERENCES groups(id), user_id integer REFERENCES users(id), PRIMARY KEY (group_id, user_id));
CREATE TABLE posts (id integer PRIMARY KEY, author_id integer REFERENCES users(id), group_id integer REFERENCES groups(id), created_at timestamp NOT NULL);
CREATE TABLE post_likes (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY (post_id, user_id));
CREATE TABLE reposts (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY (post_id, user_id));

