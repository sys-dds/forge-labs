-- Settings are optional: a user can exist before choosing preferences.
-- They are still one-to-one when present because user_id is the primary key.
CREATE TABLE user_settings (user_id integer PRIMARY KEY REFERENCES users(id), email_notifications_enabled boolean NOT NULL DEFAULT true);
INSERT INTO user_settings (user_id, email_notifications_enabled) VALUES (1,true),(2,false);
