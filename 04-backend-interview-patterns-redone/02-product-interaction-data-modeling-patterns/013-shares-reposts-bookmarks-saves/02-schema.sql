SET search_path TO bip_pim_013;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE posts (post_id int PRIMARY KEY, author_user_id int REFERENCES users, body text NOT NULL, visibility text NOT NULL CHECK (visibility IN ('public','private')), deleted_at timestamp);
CREATE TABLE reposts (repost_id int PRIMARY KEY, user_id int REFERENCES users, original_post_id int REFERENCES posts, created_at timestamp NOT NULL, deleted_at timestamp);
CREATE TABLE quote_reposts (quote_repost_id int PRIMARY KEY, user_id int REFERENCES users, original_post_id int REFERENCES posts, quote_text text NOT NULL, created_at timestamp NOT NULL, deleted_at timestamp);
CREATE TABLE bookmarks (bookmark_id int PRIMARY KEY, user_id int REFERENCES users, post_id int REFERENCES posts, created_at timestamp NOT NULL, deleted_at timestamp);
CREATE TABLE block_edges (blocker_user_id int REFERENCES users, blocked_user_id int REFERENCES users, PRIMARY KEY (blocker_user_id, blocked_user_id));
