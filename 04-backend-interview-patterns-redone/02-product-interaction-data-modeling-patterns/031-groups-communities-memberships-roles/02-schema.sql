SET search_path TO bip_pim_031;
CREATE TABLE users(user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE communities(community_id int PRIMARY KEY, community_name text NOT NULL, visibility text NOT NULL CHECK (visibility IN ('public','private','invite_only')), owner_user_id int NOT NULL REFERENCES users(user_id));
CREATE TABLE community_memberships(membership_id int PRIMARY KEY, community_id int NOT NULL REFERENCES communities(community_id), user_id int NOT NULL REFERENCES users(user_id), member_state text NOT NULL CHECK (member_state IN ('active','pending','left','removed','banned')), joined_at date, left_at date, UNIQUE(community_id,user_id));
CREATE TABLE community_roles(role_id int PRIMARY KEY, community_id int NOT NULL REFERENCES communities(community_id), role_name text NOT NULL CHECK (role_name IN ('owner','admin','moderator','member')), role_rank int NOT NULL);
CREATE TABLE community_role_assignments(assignment_id int PRIMARY KEY, community_id int NOT NULL REFERENCES communities(community_id), user_id int NOT NULL REFERENCES users(user_id), role_id int NOT NULL REFERENCES community_roles(role_id), assigned_by_user_id int REFERENCES users(user_id));
CREATE TABLE community_permissions(permission_id int PRIMARY KEY, community_id int NOT NULL REFERENCES communities(community_id), role_id int NOT NULL REFERENCES community_roles(role_id), permission_name text NOT NULL, is_allowed boolean NOT NULL);
CREATE TABLE community_bans(ban_id int PRIMARY KEY, community_id int NOT NULL REFERENCES communities(community_id), user_id int NOT NULL REFERENCES users(user_id), banned_by_user_id int NOT NULL REFERENCES users(user_id), reason text NOT NULL);

