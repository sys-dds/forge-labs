-- Base case: c1 on post 100. Recursive step: children on the same post.
-- The post_id predicate prevents post 200 replies from leaking into the thread.
CREATE VIEW c1_recursive_thread AS
WITH RECURSIVE thread AS (
  SELECT id, post_id, parent_comment_id, body, 0 AS depth, lpad(id::text, 4, '0') AS path
  FROM comments
  WHERE id = 1 AND post_id = 100
  UNION ALL
  SELECT child.id, child.post_id, child.parent_comment_id, child.body, thread.depth + 1,
         thread.path || '.' || lpad(child.id::text, 4, '0')
  FROM comments child
  JOIN thread ON thread.id = child.parent_comment_id
  WHERE child.post_id = thread.post_id
)
SELECT id, parent_comment_id, body, depth, path FROM thread ORDER BY path;

