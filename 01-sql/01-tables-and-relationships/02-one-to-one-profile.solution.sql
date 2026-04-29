-- A profile is one-to-one with a user because user_id is both the primary key
-- and a foreign key. That makes duplicate profile rows impossible.
CREATE TABLE user_profiles (user_id integer PRIMARY KEY REFERENCES users(id), display_name text NOT NULL, bio text NOT NULL DEFAULT '');
INSERT INTO user_profiles (user_id, display_name, bio) SELECT id, initcap(handle), 'Learning backend fundamentals' FROM users;
