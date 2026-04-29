-- Chapter 09 authored dataset: post 100 owns the main nested thread.
CREATE TABLE posts (id integer PRIMARY KEY, title text NOT NULL);
CREATE TABLE comments (
  id integer PRIMARY KEY,
  post_id integer NOT NULL REFERENCES posts(id),
  parent_comment_id integer REFERENCES comments(id),
  body text NOT NULL,
  created_at timestamptz NOT NULL
);
CREATE TABLE categories (id integer PRIMARY KEY, parent_id integer REFERENCES categories(id), name text NOT NULL);
INSERT INTO posts VALUES (100,'main thread'),(200,'unrelated thread');
INSERT INTO comments VALUES
  (1,100,NULL,'c1 root','2026-01-01 10:00+00'),
  (2,100,1,'c2 reply to c1','2026-01-01 10:01+00'),
  (3,100,1,'c3 reply to c1','2026-01-01 10:02+00'),
  (4,100,2,'c4 reply to c2','2026-01-01 10:03+00'),
  (5,100,4,'c5 reply to c4','2026-01-01 10:04+00'),
  (6,200,NULL,'c6 other root','2026-01-01 10:00+00'),
  (7,200,6,'c7 other reply','2026-01-01 10:01+00');
INSERT INTO categories VALUES
  (1,NULL,'Electronics'),(2,1,'Computers'),(3,2,'Laptops'),(4,1,'Phones'),(5,NULL,'Home');

