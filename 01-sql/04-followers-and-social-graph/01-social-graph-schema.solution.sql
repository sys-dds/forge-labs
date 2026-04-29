-- Chapter 04 authored dataset: Ada opens "People you may know".
-- The users are inserted in a fixed order so the proof can talk about exact
-- graph edges without hiding behind generated ids.
CREATE TABLE users (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  handle text NOT NULL UNIQUE
);

CREATE TABLE profiles (
  user_id integer PRIMARY KEY REFERENCES users(id),
  display_name text NOT NULL
);

-- follower_id is the actor/source. followee_id is the target.
-- Most social graph bugs in this chapter come from reversing those two columns.
CREATE TABLE follows (
  follower_id integer NOT NULL REFERENCES users(id),
  followee_id integer NOT NULL REFERENCES users(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (follower_id, followee_id),
  CHECK (follower_id <> followee_id)
);

CREATE TABLE blocks (
  blocker_id integer NOT NULL REFERENCES users(id),
  blocked_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (blocker_id, blocked_id),
  CHECK (blocker_id <> blocked_id)
);

CREATE TABLE mutes (
  muter_id integer NOT NULL REFERENCES users(id),
  muted_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (muter_id, muted_id),
  CHECK (muter_id <> muted_id)
);

INSERT INTO users (handle) VALUES
  ('ada'),   -- id 1: viewer whose graph is inspected
  ('ben'),   -- id 2: mutual follow with Ada
  ('cy'),    -- id 3: followed by Ada but muted for feed-style output
  ('diya'),  -- id 4: second-degree suggestion through Ben and Cy
  ('noor'),  -- id 5: reachable through Cy but blocked by Ada
  ('theo');  -- id 6: disconnected control row

INSERT INTO profiles (user_id, display_name)
SELECT id, initcap(handle) FROM users;

INSERT INTO follows (follower_id, followee_id) VALUES
  (1,2), -- Ada follows Ben: positive following row and mutual edge half
  (1,3), -- Ada follows Cy: proves mute hides feed output without deleting follow
  (2,1), -- Ben follows Ada: completes mutual follow
  (2,4), -- Ben follows Diya: makes Diya a second-degree suggestion
  (3,4), -- Cy also follows Diya: duplicate path must collapse with DISTINCT
  (3,5), -- Cy follows Noor: reachable but unsafe because Ada blocks Noor
  (4,1), -- Diya follows Ada: follower who Ada does not follow back
  (5,1); -- Noor follows Ada: follower who is blocked for suggestions

INSERT INTO blocks (blocker_id, blocked_id) VALUES
  (1,5); -- Ada blocks Noor, so reachability must not become suggestion eligibility.

INSERT INTO mutes (muter_id, muted_id) VALUES
  (1,3); -- Ada mutes Cy, suppressing feed-style output while preserving follow.

