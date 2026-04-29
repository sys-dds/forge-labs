CREATE TABLE users (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE,
  age integer NOT NULL,
  active boolean NOT NULL
);

CREATE TABLE profile_preferences (
  user_id integer PRIMARY KEY REFERENCES users(id),
  min_age integer NOT NULL,
  max_age integer NOT NULL,
  preferred_city text NOT NULL
);

CREATE TABLE profile_details (
  user_id integer PRIMARY KEY REFERENCES users(id),
  city text NOT NULL
);

CREATE TABLE swipes (
  swiper_id integer NOT NULL REFERENCES users(id),
  swiped_id integer NOT NULL REFERENCES users(id),
  action text NOT NULL CHECK (action IN ('LIKE', 'PASS')),
  PRIMARY KEY (swiper_id, swiped_id),
  CHECK (swiper_id <> swiped_id)
);

CREATE TABLE user_blocks (
  blocker_id integer NOT NULL REFERENCES users(id),
  blocked_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (blocker_id, blocked_id),
  CHECK (blocker_id <> blocked_id)
);

CREATE TABLE user_interests (
  user_id integer NOT NULL REFERENCES users(id),
  interest text NOT NULL,
  PRIMARY KEY (user_id, interest)
);
