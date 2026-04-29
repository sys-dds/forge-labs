-- Recursive CTEs have two parts:
-- 1. The base case selects the root comment.
-- 2. The recursive step repeatedly finds comments whose parent is already in
--    the thread.
-- Depth supports indentation. Path makes the tree order deterministic.
CREATE VIEW recursive_thread AS
WITH RECURSIVE thread AS (
  SELECT
    id,
    parent_comment_id,
    body,
    0 AS depth,
    lpad(id::text, 4, '0') AS path
  FROM comments
  WHERE id = 1

  UNION ALL

  SELECT
    child.id,
    child.parent_comment_id,
    child.body,
    thread.depth + 1 AS depth,
    thread.path || '/' || lpad(child.id::text, 4, '0') AS path
  FROM comments AS child
  JOIN thread
    ON child.parent_comment_id = thread.id
)
SELECT *
FROM thread
ORDER BY path;
