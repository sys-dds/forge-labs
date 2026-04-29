-- Bad demonstration: post 101 has 2 likes and 3 comments. Joining both child
-- tables directly creates 6 rows, which would make ranking think the post is
-- more active than it is.
CREATE VIEW bad_row_multiplication AS
SELECT p.id AS post_id, count(*) AS multiplied_rows
FROM posts p
JOIN likes l ON l.post_id = p.id
JOIN comments c ON c.post_id = p.id
WHERE p.id = 101
GROUP BY p.id;

-- Fixed version: aggregate each child table first, then join one count row back.
CREATE VIEW fixed_engagement_counts AS
WITH like_counts AS (
  SELECT post_id, count(*) AS like_count FROM likes GROUP BY post_id
), comment_counts AS (
  SELECT post_id, count(*) AS comment_count FROM comments GROUP BY post_id
)
SELECT p.id AS post_id,
       coalesce(l.like_count, 0) AS like_count,
       coalesce(c.comment_count, 0) AS comment_count
FROM posts p
LEFT JOIN like_counts l ON l.post_id = p.id
LEFT JOIN comment_counts c ON c.post_id = p.id
ORDER BY p.id;

