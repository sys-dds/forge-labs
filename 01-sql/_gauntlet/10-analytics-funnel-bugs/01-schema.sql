CREATE TABLE events (id integer PRIMARY KEY, user_handle text NOT NULL, event_name text NOT NULL, occurred_at timestamp NOT NULL, internal boolean NOT NULL DEFAULT false);
