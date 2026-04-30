CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE, age integer, active boolean);
CREATE TABLE prefs (user_id integer PRIMARY KEY REFERENCES users(id), min_age integer, max_age integer);
CREATE TABLE swipes (swiper_id integer REFERENCES users(id), swiped_id integer REFERENCES users(id), action text, PRIMARY KEY (swiper_id, swiped_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id));
CREATE TABLE interests (user_id integer REFERENCES users(id), interest text, PRIMARY KEY(user_id,interest));
