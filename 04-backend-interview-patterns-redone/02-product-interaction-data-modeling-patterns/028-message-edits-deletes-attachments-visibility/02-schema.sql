SET search_path TO bip_pim_028;
CREATE TABLE users (user_id int PRIMARY KEY, display_name text NOT NULL);
CREATE TABLE conversations (conversation_id int PRIMARY KEY, conversation_type text NOT NULL);
CREATE TABLE conversation_participants (participant_id int PRIMARY KEY, conversation_id int REFERENCES conversations, user_id int REFERENCES users);
CREATE TABLE messages (message_id int PRIMARY KEY, conversation_id int REFERENCES conversations, sender_user_id int REFERENCES users, original_body text NOT NULL);
CREATE TABLE message_edits (edit_id int PRIMARY KEY, message_id int REFERENCES messages, edited_body text NOT NULL, edit_seq int NOT NULL);
CREATE TABLE message_deletions (deletion_id int PRIMARY KEY, message_id int REFERENCES messages, deleted_by_user_id int REFERENCES users, delete_scope text NOT NULL, viewer_user_id int);
CREATE TABLE message_attachments (attachment_id int PRIMARY KEY, message_id int REFERENCES messages, file_name text NOT NULL);
