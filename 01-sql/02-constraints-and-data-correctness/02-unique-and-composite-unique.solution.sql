-- Profiles use a unique handle because profile lookup is a public read path. Unique user_id keeps one profile attached to one account.
CREATE TABLE profiles (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, user_id integer NOT NULL UNIQUE REFERENCES users(id), handle text NOT NULL UNIQUE, display_name text NOT NULL, CHECK (length(display_name) BETWEEN 1 AND 80));
INSERT INTO profiles (user_id, handle, display_name) SELECT id, handle, initcap(handle) FROM users;
