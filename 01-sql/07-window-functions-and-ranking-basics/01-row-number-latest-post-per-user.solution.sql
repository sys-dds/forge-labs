-- ROW_NUMBER chooses one row per partition, such as each author's latest post.
CREATE TABLE users (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY(follower_id,followee_id));
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, author_id integer REFERENCES users(id), body text, created_at timestamptz NOT NULL);
CREATE TABLE likes (post_id integer REFERENCES posts(id), user_id integer REFERENCES users(id), PRIMARY KEY(post_id,user_id));
CREATE TABLE comments (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, post_id integer REFERENCES posts(id));
INSERT INTO users (handle) VALUES ('ada'),('grace'),('linus');
INSERT INTO follows VALUES (1,2),(1,3),(2,3),(3,2);
INSERT INTO posts (author_id,body,created_at) VALUES (2,'old grace','2026-01-01'),(2,'new grace','2026-01-03'),(3,'linus one','2026-01-02'),(3,'linus two','2026-01-04');
INSERT INTO likes VALUES (1,1),(2,1),(2,3),(3,1),(3,2),(4,1),(4,2);
INSERT INTO comments (post_id) VALUES (2),(2),(3),(4);
CREATE VIEW latest_post_per_user AS SELECT * FROM (SELECT p.*, row_number() OVER (PARTITION BY author_id ORDER BY created_at DESC, id DESC) AS rn FROM posts p) ranked WHERE rn=1;
