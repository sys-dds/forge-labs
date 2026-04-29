CREATE TABLE users (id integer PRIMARY KEY, handle text UNIQUE NOT NULL);
CREATE TABLE follows (follower_id integer REFERENCES users(id), followee_id integer REFERENCES users(id), PRIMARY KEY(follower_id,followee_id));
CREATE TABLE posts (id integer PRIMARY KEY, author_id integer REFERENCES users(id), created_at timestamptz NOT NULL, body text NOT NULL);
CREATE TABLE engagement_events (id integer PRIMARY KEY, post_id integer REFERENCES posts(id), event_type text NOT NULL CHECK(event_type IN ('like','comment')), created_at timestamptz NOT NULL);
INSERT INTO users VALUES (1,'ada'),(2,'ben'),(3,'cy');
INSERT INTO follows VALUES (2,1),(3,1),(1,2),(3,2);
INSERT INTO posts VALUES
  (101,1,'2026-01-01 10:00+00','Ada old'),(102,1,'2026-01-01 11:00+00','Ada middle'),(103,1,'2026-01-01 12:00+00','Ada latest'),
  (201,2,'2026-01-01 10:30+00','Ben old'),(202,2,'2026-01-01 12:00+00','Ben latest tie time'),
  (301,3,'2026-01-01 09:00+00','Cy only');
INSERT INTO engagement_events VALUES
  (1,101,'like','2026-01-01 10:01+00'),(2,103,'like','2026-01-01 12:01+00'),(3,103,'comment','2026-01-01 12:02+00'),
  (4,201,'like','2026-01-01 10:31+00'),(5,202,'like','2026-01-01 12:01+00'),(6,202,'comment','2026-01-01 12:02+00'),(7,301,'like','2026-01-01 09:01+00');
CREATE VIEW latest_post_per_user AS
SELECT author_id, id AS post_id, handle
FROM (
  SELECT p.*, u.handle, row_number() OVER (PARTITION BY p.author_id ORDER BY p.created_at DESC, p.id DESC) AS rn
  FROM posts p JOIN users u ON u.id = p.author_id
) ranked WHERE rn = 1 ORDER BY author_id;

