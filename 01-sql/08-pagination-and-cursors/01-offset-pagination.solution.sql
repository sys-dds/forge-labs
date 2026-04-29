-- Offset pagination is simple and useful for static admin screens, but unstable for changing feeds.
CREATE TABLE posts (id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY, body text NOT NULL, created_at timestamptz NOT NULL);
INSERT INTO posts (body,created_at) VALUES ('a','2026-01-01 10:00'),('b','2026-01-01 10:00'),('c','2026-01-02 10:00'),('d','2026-01-03 10:00'),('e','2026-01-04 10:00');
CREATE VIEW offset_page_one AS SELECT id, body, created_at FROM posts ORDER BY created_at DESC, id DESC LIMIT 2 OFFSET 0;
