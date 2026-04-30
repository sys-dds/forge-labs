SET search_path TO bip_pim_038;
CREATE TABLE topics(topic_id int PRIMARY KEY, topic_name text NOT NULL);
CREATE TABLE posts(post_id int PRIMARY KEY, topic_id int NOT NULL REFERENCES topics(topic_id), content_state text NOT NULL CHECK(content_state IN ('active','deleted','hidden','downranked')));
CREATE TABLE interaction_events(event_id int PRIMARY KEY, topic_id int NOT NULL REFERENCES topics(topic_id), post_id int NOT NULL REFERENCES posts(post_id), actor_user_id int NOT NULL, event_type text NOT NULL, event_at timestamp NOT NULL);
CREATE TABLE trend_windows(window_id int PRIMARY KEY, starts_at timestamp NOT NULL, ends_at timestamp NOT NULL, window_label text NOT NULL);
CREATE TABLE trend_signal_components(component_id int PRIMARY KEY, window_id int NOT NULL REFERENCES trend_windows(window_id), topic_id int NOT NULL REFERENCES topics(topic_id), component_name text NOT NULL CHECK(component_name IN ('velocity','unique_actor','freshness','safety')), component_value int NOT NULL);
CREATE TABLE abuse_signal_events(signal_id int PRIMARY KEY, topic_id int NOT NULL REFERENCES topics(topic_id), signal_type text NOT NULL, signal_count int NOT NULL);
CREATE TABLE policy_treatments(treatment_id int PRIMARY KEY, topic_id int NOT NULL REFERENCES topics(topic_id), treatment text NOT NULL CHECK(treatment IN ('allow','downrank','hide','review')), reason text NOT NULL);
CREATE TABLE trend_snapshots(snapshot_id int PRIMARY KEY, window_id int NOT NULL REFERENCES trend_windows(window_id), topic_id int NOT NULL REFERENCES topics(topic_id), component_total int NOT NULL, snapshot_state text NOT NULL CHECK(snapshot_state IN ('active','suppressed','decayed')));
