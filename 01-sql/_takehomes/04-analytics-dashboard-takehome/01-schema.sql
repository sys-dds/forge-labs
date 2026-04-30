CREATE TABLE calendar_days (day date PRIMARY KEY);
CREATE TABLE events (id integer PRIMARY KEY, user_handle text, event_name text, occurred_at timestamp, internal boolean);
