CREATE TABLE posts (id integer PRIMARY KEY);
CREATE TABLE comments (id integer PRIMARY KEY, post_id integer REFERENCES posts(id), parent_id integer REFERENCES comments(id), body text NOT NULL);
