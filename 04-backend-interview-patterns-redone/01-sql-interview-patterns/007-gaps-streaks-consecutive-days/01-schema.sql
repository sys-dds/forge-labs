SET search_path TO bip_sql_007;
CREATE TABLE users (user_id integer PRIMARY KEY, user_name text NOT NULL, active boolean NOT NULL);
CREATE TABLE practice_events (event_id integer PRIMARY KEY, user_id integer NOT NULL REFERENCES users(user_id), practiced_at timestamp NOT NULL);
