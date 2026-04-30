SET search_path TO bip_pim_026;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE conversations (conversation_id int PRIMARY KEY, conversation_type text NOT NULL, created_by_user_id int REFERENCES users, state text NOT NULL);
CREATE TABLE conversation_participants (participant_id int PRIMARY KEY, conversation_id int REFERENCES conversations, user_id int REFERENCES users, participant_state text NOT NULL, joined_seq int NOT NULL, left_seq int);
CREATE TABLE messages (message_id int PRIMARY KEY, conversation_id int REFERENCES conversations, sender_user_id int REFERENCES users, body text NOT NULL, message_seq int NOT NULL);
CREATE TABLE block_edges (blocker_user_id int REFERENCES users, blocked_user_id int REFERENCES users);
