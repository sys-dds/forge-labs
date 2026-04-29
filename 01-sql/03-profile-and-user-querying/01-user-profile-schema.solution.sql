-- Public profile reads start with separating private account data from public profile shape.
CREATE TABLE users (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, handle text NOT NULL UNIQUE, email text NOT NULL UNIQUE);
CREATE TABLE profiles (user_id integer PRIMARY KEY REFERENCES users(id), display_name text NOT NULL, bio text NOT NULL, is_private boolean NOT NULL DEFAULT false);
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, author_id integer NOT NULL REFERENCES users(id), body text NOT NULL);
CREATE TABLE follows (follower_id integer NOT NULL REFERENCES users(id), followee_id integer NOT NULL REFERENCES users(id), PRIMARY KEY (follower_id, followee_id), CHECK (follower_id <> followee_id));
INSERT INTO users (handle,email) VALUES ('ada','ada@forge.test'),('grace','grace@forge.test'),('linus','linus@forge.test');
INSERT INTO profiles VALUES (1,'Ada Lovelace','Writes careful backend notes',false),(2,'Grace Hopper','Finds bugs early',false),(3,'Linus Torvalds','Reviews systems code',true);
INSERT INTO posts (author_id,body) VALUES (1,'Profile queries should be shaped.'),(1,'Never SELECT star for public APIs.'),(2,'Counts are part of the card.');
INSERT INTO follows VALUES (2,1),(3,1),(1,2);
