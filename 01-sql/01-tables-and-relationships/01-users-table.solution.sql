-- Chapter 01 starts with identity facts. Ada, Ben, Cy, and Diya are durable
-- users before the product knows anything about posts, settings, or follows.
CREATE TABLE users (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  handle text NOT NULL UNIQUE CHECK (btrim(handle) <> '')
);
INSERT INTO users (handle) VALUES ('ada'),('ben'),('cy'),('diya');

