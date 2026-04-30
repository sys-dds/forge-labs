SET search_path TO bip_pim_003;
CREATE TABLE users(user_id int PRIMARY KEY, display_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE friend_requests(request_id int PRIMARY KEY, requester_user_id int NOT NULL REFERENCES users(user_id), addressee_user_id int NOT NULL REFERENCES users(user_id), status text NOT NULL);
CREATE TABLE friendships(user_id_low int NOT NULL REFERENCES users(user_id), user_id_high int NOT NULL REFERENCES users(user_id), accepted_at timestamp NOT NULL, PRIMARY KEY(user_id_low,user_id_high), CHECK(user_id_low < user_id_high));
CREATE TABLE block_edges(blocker_user_id int NOT NULL REFERENCES users(user_id), blocked_user_id int NOT NULL REFERENCES users(user_id), PRIMARY KEY(blocker_user_id, blocked_user_id));
