CREATE TABLE posts (id integer PRIMARY KEY, author text NOT NULL, created_at timestamp NOT NULL, engagement integer NOT NULL);
CREATE TABLE events (author text NOT NULL, event_id integer PRIMARY KEY, created_at timestamp NOT NULL, points integer NOT NULL);
