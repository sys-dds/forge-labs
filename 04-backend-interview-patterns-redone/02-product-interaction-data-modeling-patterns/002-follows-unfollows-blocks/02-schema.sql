SET search_path TO bip_pim_002;
CREATE TABLE users(user_id int PRIMARY KEY, display_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE follow_edges(follower_user_id int NOT NULL REFERENCES users(user_id), followee_user_id int NOT NULL REFERENCES users(user_id), status text NOT NULL, created_at timestamp NOT NULL, PRIMARY KEY(follower_user_id, followee_user_id), CHECK (follower_user_id <> followee_user_id));
CREATE TABLE block_edges(blocker_user_id int NOT NULL REFERENCES users(user_id), blocked_user_id int NOT NULL REFERENCES users(user_id), blocked_at timestamp NOT NULL, PRIMARY KEY(blocker_user_id, blocked_user_id));
CREATE TABLE posts(post_id int PRIMARY KEY, author_user_id int NOT NULL REFERENCES users(user_id), body text NOT NULL);
