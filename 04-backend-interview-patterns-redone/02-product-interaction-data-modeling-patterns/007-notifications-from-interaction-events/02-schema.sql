SET search_path TO bip_pim_007;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE posts (post_id int PRIMARY KEY, author_user_id int REFERENCES users, body text NOT NULL);
CREATE TABLE comments (comment_id int PRIMARY KEY, post_id int REFERENCES posts, author_user_id int REFERENCES users, body text NOT NULL);
CREATE TABLE matches (match_id int PRIMARY KEY, user_id_low int REFERENCES users, user_id_high int REFERENCES users, matched_at timestamp NOT NULL);
CREATE TABLE interaction_events (event_id int PRIMARY KEY, actor_user_id int REFERENCES users, event_type text NOT NULL CHECK (event_type IN ('liked','commented','followed','matched')), subject_type text NOT NULL, subject_id int NOT NULL, created_at timestamp NOT NULL);
CREATE TABLE notifications (notification_id int PRIMARY KEY, recipient_user_id int REFERENCES users, actor_user_id int REFERENCES users, notification_type text NOT NULL, subject_type text NOT NULL, subject_id int NOT NULL, source_event_id int REFERENCES interaction_events, created_at timestamp NOT NULL, group_key text NOT NULL, UNIQUE (recipient_user_id, actor_user_id, notification_type, subject_type, subject_id));
CREATE TABLE notification_state (notification_id int PRIMARY KEY REFERENCES notifications, state text NOT NULL CHECK (state IN ('read','unread')), updated_at timestamp NOT NULL);
