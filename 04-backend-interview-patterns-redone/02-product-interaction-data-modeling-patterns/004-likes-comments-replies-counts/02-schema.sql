SET search_path TO bip_pim_004;
CREATE TABLE users(user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE posts(post_id int PRIMARY KEY, author_user_id int NOT NULL REFERENCES users(user_id), body text NOT NULL);
CREATE TABLE post_reactions(reaction_event_id int PRIMARY KEY, post_id int NOT NULL REFERENCES posts(post_id), user_id int NOT NULL REFERENCES users(user_id), reaction_type text NOT NULL, active boolean NOT NULL, created_at timestamp NOT NULL);
CREATE TABLE comments(comment_id int PRIMARY KEY, post_id int NOT NULL REFERENCES posts(post_id), author_user_id int NOT NULL REFERENCES users(user_id), parent_comment_id int REFERENCES comments(comment_id), body text NOT NULL, deleted_at timestamp);
