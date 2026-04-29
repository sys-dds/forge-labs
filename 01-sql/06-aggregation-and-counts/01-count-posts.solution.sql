-- Counts turn raw activity into profile and feed metrics.
CREATE TABLE users (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY(follower_id,followee_id));
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, author_id integer REFERENCES users(id), body text NOT NULL, hidden boolean NOT NULL DEFAULT false);
CREATE TABLE likes (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY(post_id,user_id));
CREATE TABLE comments (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, post_id integer REFERENCES posts(id), body text NOT NULL, deleted boolean NOT NULL DEFAULT false);
INSERT INTO users (handle) VALUES ('ada'),('grace'),('linus');
INSERT INTO follows VALUES (2,1),(3,1),(1,2);
INSERT INTO posts (author_id,body,hidden) VALUES (1,'visible a',false),(1,'hidden a',true),(2,'visible g',false);
INSERT INTO likes VALUES (1,2),(1,3),(3,1);
INSERT INTO comments (post_id,body,deleted) VALUES (1,'one',false),(1,'gone',true),(3,'two',false);
CREATE VIEW count_posts AS SELECT author_id, count(*) FILTER (WHERE hidden=false) AS visible_post_count FROM posts GROUP BY author_id;
