-- Feed ranking inputs are not a ranking algorithm. They are a row shape that
-- ranking code could consume later: post identity, author identity, recency,
-- engagement counts, and whether the viewer follows the author.
CREATE VIEW feed_ranking_inputs AS
SELECT
  p.id AS post_id,
  p.author_id,
  p.created_at,
  count(DISTINCT l.user_id) AS like_count,
  count(DISTINCT c.id) AS comment_count,
  EXISTS (
    SELECT 1
    FROM follows AS viewer_edges
    WHERE viewer_edges.follower_id = 1
      AND viewer_edges.followee_id = p.author_id
  ) AS follower_relationship_exists
FROM posts AS p
LEFT JOIN likes AS l
  ON l.post_id = p.id
LEFT JOIN comments AS c
  ON c.post_id = p.id
GROUP BY p.id;
