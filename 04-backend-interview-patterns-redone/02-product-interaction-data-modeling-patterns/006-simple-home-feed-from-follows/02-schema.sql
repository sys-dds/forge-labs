SET search_path TO bip_pim_006;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL, status text NOT NULL CHECK (status IN ('active','inactive')));
CREATE TABLE follow_edges (follower_user_id int REFERENCES users, followed_user_id int REFERENCES users, state text NOT NULL CHECK (state IN ('active','unfollowed')), created_at timestamp NOT NULL, PRIMARY KEY (follower_user_id, followed_user_id));
CREATE TABLE block_edges (blocker_user_id int REFERENCES users, blocked_user_id int REFERENCES users, created_at timestamp NOT NULL, PRIMARY KEY (blocker_user_id, blocked_user_id));
CREATE TABLE mute_edges (muter_user_id int REFERENCES users, muted_user_id int REFERENCES users, created_at timestamp NOT NULL, PRIMARY KEY (muter_user_id, muted_user_id));
CREATE TABLE posts (post_id int PRIMARY KEY, author_user_id int REFERENCES users, body text NOT NULL, created_at timestamp NOT NULL, deleted_at timestamp);
CREATE TABLE feed_seen_events (viewer_user_id int REFERENCES users, post_id int REFERENCES posts, seen_at timestamp NOT NULL, PRIMARY KEY (viewer_user_id, post_id));
