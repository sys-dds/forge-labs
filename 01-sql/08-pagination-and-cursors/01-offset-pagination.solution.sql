-- Chapter 08 authored dataset: Ada scrolls while posts are created.
CREATE TABLE feed_posts (
  id integer PRIMARY KEY,
  author_handle text NOT NULL,
  body text NOT NULL,
  created_at timestamptz NOT NULL
);
INSERT INTO feed_posts VALUES
  (106,'ben','newest before scroll','2026-01-01 10:06:00+00'),
  (105,'cy','same timestamp higher id','2026-01-01 10:05:00+00'),
  (104,'diya','same timestamp lower id','2026-01-01 10:05:00+00'),
  (103,'ben','middle row','2026-01-01 10:03:00+00'),
  (102,'cy','older row','2026-01-01 10:02:00+00'),
  (101,'ada','oldest row','2026-01-01 10:01:00+00');
CREATE VIEW offset_page_one AS
SELECT id, created_at FROM feed_posts ORDER BY created_at DESC, id DESC LIMIT 3 OFFSET 0;
CREATE VIEW offset_page_two_before_insert AS
SELECT id, created_at FROM feed_posts ORDER BY created_at DESC, id DESC LIMIT 3 OFFSET 3;

