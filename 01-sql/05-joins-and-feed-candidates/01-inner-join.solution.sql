-- Chapter 05 authored dataset: Ada opens her feed.
-- SQL must first build the eligible candidate set; ranking happens later.
CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE profiles (user_id integer PRIMARY KEY REFERENCES users(id), display_name text NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id));
CREATE TABLE mutes (muter_id integer REFERENCES users(id), muted_id integer REFERENCES users(id), PRIMARY KEY (muter_id, muted_id));
CREATE TABLE posts (id integer PRIMARY KEY, author_id integer NOT NULL REFERENCES users(id), body text NOT NULL);
CREATE TABLE likes (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY (post_id,user_id));
CREATE TABLE comments (id integer PRIMARY KEY, post_id integer REFERENCES posts(id), body text NOT NULL);
INSERT INTO users VALUES (1,'ada'),(2,'ben'),(3,'cy'),(4,'diya'),(5,'noor');
INSERT INTO profiles VALUES (1,'Ada'),(2,'Ben'),(3,'Cy'),(4,'Diya'),(5,'Noor');
INSERT INTO follows VALUES (1,2),(1,3),(1,5);
INSERT INTO mutes VALUES (1,3);
INSERT INTO blocks VALUES (1,5);
INSERT INTO posts VALUES
  (101,2,'Ben first eligible post'),
  (102,2,'Ben zero-comment eligible post'),
  (201,3,'Cy muted post'),
  (301,5,'Noor blocked post'),
  (401,4,'Diya not followed post');
INSERT INTO likes VALUES (101,1),(101,3),(102,1),(201,1);
INSERT INTO comments VALUES (1,101,'useful'),(2,101,'sharp'),(3,101,'saved'),(4,201,'muted comment');
CREATE VIEW inner_join_followed_posts AS
SELECT p.id AS post_id, u.handle AS author_handle
FROM posts AS p
JOIN follows AS f ON f.followee_id = p.author_id
JOIN users AS u ON u.id = p.author_id
WHERE f.follower_id = 1
ORDER BY p.id;

