SET search_path TO bip_pim_001;
CREATE TABLE users(user_id int PRIMARY KEY, display_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE profiles(profile_id int PRIMARY KEY, user_id int NOT NULL REFERENCES users(user_id), handle text NOT NULL UNIQUE);
CREATE TABLE profile_field_visibility(profile_id int NOT NULL REFERENCES profiles(profile_id), field_name text NOT NULL, field_value text NOT NULL, visibility text NOT NULL, PRIMARY KEY(profile_id, field_name));
CREATE TABLE user_blocks(owner_user_id int NOT NULL REFERENCES users(user_id), blocked_user_id int NOT NULL REFERENCES users(user_id), blocked_at timestamp NOT NULL, PRIMARY KEY(owner_user_id, blocked_user_id));
