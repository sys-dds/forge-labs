CREATE TABLE users (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE,
  role text NOT NULL CHECK (role IN ('buyer', 'seller'))
);

CREATE TABLE profiles (
  id integer PRIMARY KEY,
  user_id integer NOT NULL,
  profile_type text NOT NULL CHECK (profile_type IN ('buyer', 'seller')),
  display_name text NOT NULL
);

CREATE TABLE listings (
  id integer PRIMARY KEY,
  seller_id integer NOT NULL,
  title text NOT NULL
);

CREATE TABLE follows (
  follower_id integer NOT NULL,
  followed_id integer NOT NULL
);

CREATE TABLE blocks (
  blocker_id integer NOT NULL,
  blocked_id integer NOT NULL
);

CREATE TABLE saved_listings (
  user_id integer NOT NULL,
  listing_id integer NOT NULL
);

