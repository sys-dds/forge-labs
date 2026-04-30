CREATE VIEW post_100_direct_replies_to_c1 AS
SELECT id AS comment_id
FROM comments
WHERE post_id = 100
  AND parent_id = 'c1'
ORDER BY sort_order;

CREATE VIEW post_100_thread_from_c1 AS
WITH RECURSIVE thread AS (
  SELECT id, post_id, parent_id, 0 AS depth, ARRAY[sort_order] AS path
  FROM comments
  WHERE post_id = 100
    AND id = 'c1'

  UNION ALL

  SELECT child.id, child.post_id, child.parent_id, thread.depth + 1, thread.path || child.sort_order
  FROM comments child
  JOIN thread ON thread.id = child.parent_id
  WHERE child.post_id = thread.post_id
)
SELECT id AS comment_id, depth
FROM thread
ORDER BY path;

