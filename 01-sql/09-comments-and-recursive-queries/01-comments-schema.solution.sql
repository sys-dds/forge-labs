-- A comment tree is a table that points back to itself. Root comments have no parent.
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, body text NOT NULL);
CREATE TABLE comments (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, post_id integer NOT NULL REFERENCES posts(id), parent_comment_id integer REFERENCES comments(id), body text NOT NULL);
CREATE TABLE categories (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, parent_id integer REFERENCES categories(id), name text NOT NULL);
INSERT INTO posts (body) VALUES ('recursive ctes');
INSERT INTO comments (post_id,parent_comment_id,body) VALUES (1,NULL,'root'),(1,1,'reply one'),(1,2,'nested reply'),(1,1,'reply two');
INSERT INTO categories (parent_id,name) VALUES (NULL,'backend'),(1,'databases'),(2,'sql');
