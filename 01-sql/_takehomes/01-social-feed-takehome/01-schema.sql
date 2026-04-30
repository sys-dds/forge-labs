CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE, display_name text);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id));
CREATE TABLE mutes (muter_id integer REFERENCES users(id), muted_id integer REFERENCES users(id), PRIMARY KEY (muter_id, muted_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id));
CREATE TABLE posts (id integer PRIMARY KEY, author_id integer REFERENCES users(id), hidden boolean, created_at timestamp);
CREATE TABLE likes (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY (post_id,user_id));
CREATE TABLE comments (id integer PRIMARY KEY, post_id integer REFERENCES posts(id));
