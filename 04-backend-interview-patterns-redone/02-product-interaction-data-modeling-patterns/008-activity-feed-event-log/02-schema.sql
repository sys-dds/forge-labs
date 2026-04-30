SET search_path TO bip_pim_008;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL, status text NOT NULL CHECK (status IN ('active','inactive')));
CREATE TABLE posts (post_id int PRIMARY KEY, author_user_id int REFERENCES users, deleted_at timestamp);
CREATE TABLE follow_edges (follower_user_id int REFERENCES users, followed_user_id int REFERENCES users, state text NOT NULL CHECK (state IN ('active','unfollowed')), PRIMARY KEY (follower_user_id, followed_user_id));
CREATE TABLE block_edges (blocker_user_id int REFERENCES users, blocked_user_id int REFERENCES users, PRIMARY KEY (blocker_user_id, blocked_user_id));
CREATE TABLE visibility_rules (audience text PRIMARY KEY, follower_visible boolean NOT NULL, owner_visible boolean NOT NULL);
CREATE TABLE activity_events (event_id int PRIMARY KEY, actor_user_id int REFERENCES users, verb text NOT NULL, object_type text NOT NULL, object_id int NOT NULL, target_user_id int REFERENCES users, audience text REFERENCES visibility_rules, created_at timestamp NOT NULL);
