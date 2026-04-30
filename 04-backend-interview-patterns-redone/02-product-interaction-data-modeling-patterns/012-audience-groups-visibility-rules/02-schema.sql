SET search_path TO bip_pim_012;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL, status text NOT NULL CHECK (status IN ('active','inactive')));
CREATE TABLE audience_groups (group_id int PRIMARY KEY, owner_user_id int REFERENCES users, group_name text NOT NULL);
CREATE TABLE audience_group_members (group_id int REFERENCES audience_groups, member_user_id int REFERENCES users, PRIMARY KEY (group_id, member_user_id));
CREATE TABLE friendships (user_id_low int REFERENCES users, user_id_high int REFERENCES users, state text NOT NULL CHECK (state IN ('accepted','pending')), PRIMARY KEY (user_id_low, user_id_high));
CREATE TABLE block_edges (blocker_user_id int REFERENCES users, blocked_user_id int REFERENCES users, PRIMARY KEY (blocker_user_id, blocked_user_id));
CREATE TABLE posts (post_id int PRIMARY KEY, author_user_id int REFERENCES users, visibility text NOT NULL CHECK (visibility IN ('public','private','friends_only','close_friends')), audience_group_id int REFERENCES audience_groups, deleted_at timestamp);
