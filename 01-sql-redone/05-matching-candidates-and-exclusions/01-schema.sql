CREATE TABLE users (
  id integer PRIMARY KEY,
  handle text NOT NULL UNIQUE,
  is_active boolean NOT NULL,
  age integer NOT NULL,
  city text NOT NULL
);

CREATE TABLE preferences (
  user_id integer PRIMARY KEY REFERENCES users(id),
  min_age integer NOT NULL,
  max_age integer NOT NULL,
  city text NOT NULL
);

CREATE TABLE interests (
  user_id integer NOT NULL REFERENCES users(id),
  interest text NOT NULL,
  PRIMARY KEY (user_id, interest)
);

CREATE TABLE swipes (
  swiper_id integer NOT NULL REFERENCES users(id),
  swiped_id integer NOT NULL REFERENCES users(id),
  decision text NOT NULL CHECK (decision IN ('LIKE', 'PASS')),
  PRIMARY KEY (swiper_id, swiped_id),
  CHECK (swiper_id <> swiped_id)
);

CREATE TABLE blocks (
  blocker_id integer NOT NULL REFERENCES users(id),
  blocked_id integer NOT NULL REFERENCES users(id),
  PRIMARY KEY (blocker_id, blocked_id),
  CHECK (blocker_id <> blocked_id)
);

