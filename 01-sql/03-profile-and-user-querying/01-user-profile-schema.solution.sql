-- Public profile endpoint dataset. Emails exist in storage but must not cross
-- the public query boundary.
CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE NOT NULL, email text NOT NULL);
CREATE TABLE profiles (user_id integer PRIMARY KEY REFERENCES users(id), display_name text NOT NULL, bio text NOT NULL, searchable boolean NOT NULL DEFAULT true);
CREATE TABLE posts (id integer PRIMARY KEY, author_id integer REFERENCES users(id), body text NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id));
INSERT INTO users VALUES (1,'ada','ada@example.test'),(2,'ben','ben@example.test'),(3,'cy','cy@example.test'),(4,'diya','diya@example.test');
INSERT INTO profiles VALUES (1,'Ada','Public data modeler',true),(2,'Ben','Public query reader',true),(3,'Cy','Private search opt out',false),(4,'Diya','New public user',true);
INSERT INTO posts VALUES (1,1,'Ada one'),(2,1,'Ada two'),(3,2,'Ben one');
INSERT INTO follows VALUES (2,1),(3,1),(1,2),(4,2),(2,3);

