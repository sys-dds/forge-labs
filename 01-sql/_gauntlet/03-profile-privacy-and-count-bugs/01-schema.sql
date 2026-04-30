CREATE TABLE users (id integer PRIMARY KEY, handle text NOT NULL UNIQUE, email text NOT NULL);
CREATE TABLE profiles (user_id integer PRIMARY KEY REFERENCES users(id), display_name text NOT NULL, searchable boolean NOT NULL);
CREATE TABLE posts (id integer PRIMARY KEY, author_id integer REFERENCES users(id), body text NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id));
