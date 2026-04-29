-- Chapter 06 authored metrics dataset.
CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY(follower_id,followee_id));
CREATE TABLE posts (id integer PRIMARY KEY, author_id integer REFERENCES users(id), body text NOT NULL, visible boolean NOT NULL DEFAULT true);
CREATE TABLE likes (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY(post_id,user_id));
CREATE TABLE comments (id integer PRIMARY KEY, post_id integer REFERENCES posts(id), body text NOT NULL, deleted boolean NOT NULL DEFAULT false);
INSERT INTO users VALUES (1,'ada'),(2,'ben'),(3,'cy'),(4,'diya');
INSERT INTO follows VALUES (2,1),(3,1),(1,2);
INSERT INTO posts VALUES (101,1,'Ada A1',true),(102,1,'Ada A2',true),(103,1,'Ada hidden',false),(201,2,'Ben B1',true),(401,4,'Diya hidden',false);
INSERT INTO likes VALUES (101,2),(101,3),(102,2),(201,1),(201,3),(201,4);
INSERT INTO comments VALUES (1,101,'visible one',false),(2,101,'visible two',false),(3,101,'deleted one',true),(4,201,'ben visible',false);
CREATE VIEW visible_post_counts AS
SELECT u.handle, count(p.id) AS visible_post_count
FROM users u LEFT JOIN posts p ON p.author_id = u.id AND p.visible
GROUP BY u.handle ORDER BY u.handle;

