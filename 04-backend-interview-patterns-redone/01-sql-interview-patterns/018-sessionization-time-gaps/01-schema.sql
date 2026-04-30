SET search_path TO bip_sql_018;
CREATE TABLE feed_events (event_id integer PRIMARY KEY, user_id integer NOT NULL, event_at timestamp NOT NULL);
