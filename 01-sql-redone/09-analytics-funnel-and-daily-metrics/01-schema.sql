CREATE TABLE users (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE,
  is_internal boolean NOT NULL DEFAULT false
);

CREATE TABLE events (
  id integer PRIMARY KEY,
  user_id integer NOT NULL REFERENCES users(id),
  event_name text NOT NULL CHECK (event_name IN ('signup', 'feed_view', 'post_created')),
  event_at timestamp NOT NULL
);

