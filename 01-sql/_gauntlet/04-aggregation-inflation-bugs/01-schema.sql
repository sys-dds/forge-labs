CREATE TABLE users (id integer PRIMARY KEY, handle text NOT NULL UNIQUE);
CREATE TABLE posts (id text PRIMARY KEY, author_id integer REFERENCES users(id), hidden boolean NOT NULL);
CREATE TABLE likes (post_id text REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY (post_id,user_id));
CREATE TABLE comments (id integer PRIMARY KEY, post_id text REFERENCES posts(id), deleted boolean NOT NULL);
