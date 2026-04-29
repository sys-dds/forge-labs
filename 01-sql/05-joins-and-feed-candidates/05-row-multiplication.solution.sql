-- Joining multiple one-to-many tables at the same time can multiply rows.
-- Post 1 has two likes and two comments, so the raw join produces four rows.
-- That inflated row shape is useful to inspect, but it must not be used for
-- engagement counts.
CREATE VIEW row_multiplication_bad AS
SELECT
  p.id AS post_id,
  l.user_id AS liked_by_user_id,
  c.id AS comment_id
FROM posts AS p
LEFT JOIN likes AS l
  ON l.post_id = p.id
LEFT JOIN comments AS c
  ON c.post_id = p.id
WHERE p.id = 1;

-- The fixed shape isolates each count in its own subquery, so likes and
-- comments do not multiply each other.
CREATE VIEW row_multiplication_fixed AS
SELECT
  p.id AS post_id,
  (SELECT count(*) FROM likes AS l WHERE l.post_id = p.id) AS like_count,
  (SELECT count(*) FROM comments AS c WHERE c.post_id = p.id) AS comment_count
FROM posts AS p
WHERE p.id = 1;
