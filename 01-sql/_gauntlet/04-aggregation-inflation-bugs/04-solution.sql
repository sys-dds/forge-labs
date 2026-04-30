CREATE OR REPLACE VIEW gauntlet_result AS
WITH visible_posts AS (
  SELECT * FROM posts WHERE NOT hidden
),
post_counts AS (
  SELECT author_id, count(*)::integer AS post_count FROM visible_posts GROUP BY author_id
),
like_counts AS (
  SELECT vp.author_id, count(likes.user_id)::integer AS like_count FROM visible_posts vp LEFT JOIN likes ON likes.post_id=vp.id GROUP BY vp.author_id
),
comment_counts AS (
  SELECT vp.author_id, count(comments.id)::integer AS comment_count FROM visible_posts vp LEFT JOIN comments ON comments.post_id=vp.id AND NOT comments.deleted GROUP BY vp.author_id
)
SELECT u.handle, pc.post_count, coalesce(lc.like_count,0) AS like_count, coalesce(cc.comment_count,0) AS comment_count
FROM users u
JOIN post_counts pc ON pc.author_id=u.id
LEFT JOIN like_counts lc ON lc.author_id=u.id
LEFT JOIN comment_counts cc ON cc.author_id=u.id
WHERE pc.post_count >= 1
ORDER BY u.handle;
