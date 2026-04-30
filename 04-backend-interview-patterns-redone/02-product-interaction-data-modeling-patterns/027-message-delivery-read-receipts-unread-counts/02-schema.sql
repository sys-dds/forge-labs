SET search_path TO bip_pim_027;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE conversations (conversation_id int PRIMARY KEY, conversation_type text NOT NULL);
CREATE TABLE conversation_participants (participant_id int PRIMARY KEY, conversation_id int REFERENCES conversations, user_id int REFERENCES users, participant_state text NOT NULL);
CREATE TABLE messages (message_id int PRIMARY KEY, conversation_id int REFERENCES conversations, sender_user_id int REFERENCES users, message_seq int NOT NULL, body text NOT NULL);
CREATE TABLE message_delivery_states (delivery_id int PRIMARY KEY, message_id int REFERENCES messages, recipient_user_id int REFERENCES users, delivery_state text NOT NULL);
CREATE TABLE message_read_receipts (receipt_id int PRIMARY KEY, conversation_id int REFERENCES conversations, user_id int REFERENCES users, latest_read_seq int NOT NULL);
