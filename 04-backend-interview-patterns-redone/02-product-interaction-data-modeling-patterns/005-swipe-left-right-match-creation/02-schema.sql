SET search_path TO bip_pim_005;
CREATE TABLE users(user_id int PRIMARY KEY, display_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE user_profiles(user_id int PRIMARY KEY REFERENCES users(user_id), city text NOT NULL, discoverable boolean NOT NULL);
CREATE TABLE swipe_events(swipe_event_id int PRIMARY KEY, swiper_user_id int NOT NULL REFERENCES users(user_id), swiped_user_id int NOT NULL REFERENCES users(user_id), direction text NOT NULL, created_at timestamp NOT NULL);
CREATE TABLE matches(match_id int PRIMARY KEY, user_id_low int NOT NULL REFERENCES users(user_id), user_id_high int NOT NULL REFERENCES users(user_id), created_at timestamp NOT NULL, unmatched_at timestamp, UNIQUE(user_id_low,user_id_high));
CREATE TABLE block_edges(blocker_user_id int NOT NULL REFERENCES users(user_id), blocked_user_id int NOT NULL REFERENCES users(user_id), PRIMARY KEY(blocker_user_id,blocked_user_id));
CREATE TABLE report_events(report_id int PRIMARY KEY, reporter_user_id int NOT NULL REFERENCES users(user_id), reported_user_id int NOT NULL REFERENCES users(user_id));
