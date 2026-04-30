SET search_path TO bip_pim_014;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE posts (post_id int PRIMARY KEY, author_user_id int REFERENCES users, body text NOT NULL, removed_at timestamp);
CREATE TABLE follow_edges (follower_user_id int REFERENCES users, followed_user_id int REFERENCES users, state text NOT NULL CHECK (state IN ('active','removed')), PRIMARY KEY (follower_user_id, followed_user_id));
CREATE TABLE hide_events (event_id int PRIMARY KEY, viewer_user_id int REFERENCES users, post_id int REFERENCES posts, created_at timestamp NOT NULL);
CREATE TABLE mute_edges (muter_user_id int REFERENCES users, muted_user_id int REFERENCES users, state text NOT NULL CHECK (state IN ('active','removed')), PRIMARY KEY (muter_user_id, muted_user_id));
CREATE TABLE report_events (report_id int PRIMARY KEY, reporter_user_id int REFERENCES users, post_id int REFERENCES posts, reason text NOT NULL, created_at timestamp NOT NULL);
CREATE TABLE preference_feedback_events (event_id int PRIMARY KEY, viewer_user_id int REFERENCES users, post_id int REFERENCES posts, feedback text NOT NULL CHECK (feedback IN ('less_like_this','more_like_this')), created_at timestamp NOT NULL);
CREATE TABLE review_queue_candidates (candidate_id int PRIMARY KEY, post_id int REFERENCES posts, source_report_id int REFERENCES report_events, state text NOT NULL CHECK (state IN ('open','closed')));
