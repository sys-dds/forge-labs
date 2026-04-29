-- INNER JOIN keeps only rows where the relationship exists; feed candidates from followed authors use that shape.
CREATE TABLE users (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE profiles (user_id integer PRIMARY KEY REFERENCES users(id), display_name text NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY (follower_id, followee_id));
CREATE TABLE blocks (blocker_id integer REFERENCES users(id), blocked_id integer REFERENCES users(id), PRIMARY KEY (blocker_id, blocked_id));
CREATE TABLE mutes (muter_id integer REFERENCES users(id), muted_id integer REFERENCES users(id), PRIMARY KEY (muter_id, muted_id));
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, author_id integer REFERENCES users(id), body text NOT NULL);
CREATE TABLE likes (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY (post_id,user_id));
CREATE TABLE comments (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, post_id integer REFERENCES posts(id), body text NOT NULL);
INSERT INTO users (handle) VALUES ('ada'),('grace'),('linus'),('margaret');
INSERT INTO profiles SELECT id, initcap(handle) FROM users;
INSERT INTO follows VALUES (1,2),(1,3),(1,4);
INSERT INTO blocks VALUES (1,4);
INSERT INTO mutes VALUES (1,3);
INSERT INTO posts (author_id,body) VALUES (2,'visible from followed author'),(3,'muted author post'),(4,'blocked author post'),(2,'second visible post');
INSERT INTO likes VALUES (1,1),(1,3),(4,1);
INSERT INTO comments (post_id,body) VALUES (1,'nice'),(1,'useful'),(4,'second');
CREATE VIEW inner_join_followed_posts AS SELECT p.id, u.handle FROM posts p JOIN follows f ON f.followee_id=p.author_id JOIN users u ON u.id=p.author_id WHERE f.follower_id=1;
