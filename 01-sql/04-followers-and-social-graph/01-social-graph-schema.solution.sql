-- The follow graph is a self-referencing many-to-many table. Blocks and mutes are separate edges because they mean different things.
CREATE TABLE users (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, handle text NOT NULL UNIQUE);
CREATE TABLE profiles (user_id integer PRIMARY KEY REFERENCES users(id), display_name text NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id), CHECK (follower_id<>followee_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id), CHECK (blocker_id<>blocked_id));
CREATE TABLE mutes (muter_id integer REFERENCES users(id), muted_id integer REFERENCES users(id), PRIMARY KEY (muter_id, muted_id), CHECK (muter_id<>muted_id));
INSERT INTO users (handle) VALUES ('ada'),('grace'),('linus'),('margaret'),('donald'),('barbara');
INSERT INTO profiles SELECT id, initcap(handle) FROM users;
INSERT INTO follows VALUES (1,2),(1,3),(2,1),(2,4),(3,1),(3,4),(4,5),(5,2);
INSERT INTO blocks VALUES (1,5);
INSERT INTO mutes VALUES (1,3);
