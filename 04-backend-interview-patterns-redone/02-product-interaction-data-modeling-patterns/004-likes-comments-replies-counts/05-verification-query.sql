SET search_path TO bip_pim_004;
WITH latest_reactions AS (
  SELECT DISTINCT ON (post_id,user_id) post_id,user_id,reaction_type,active FROM post_reactions ORDER BY post_id,user_id,created_at DESC,reaction_event_id DESC
), visible_top_comments AS (SELECT * FROM comments WHERE parent_comment_id IS NULL AND deleted_at IS NULL), visible_replies AS (SELECT r.* FROM comments r JOIN comments p ON p.comment_id=r.parent_comment_id WHERE r.deleted_at IS NULL AND p.deleted_at IS NULL), counts AS (
  SELECT p.post_id,
         COUNT(lr.user_id) FILTER (WHERE lr.reaction_type='like' AND lr.active=true) AS like_count,
         (SELECT COUNT(*) FROM visible_top_comments c WHERE c.post_id=p.post_id) AS top_comment_count,
         (SELECT COUNT(*) FROM visible_replies r WHERE r.post_id=p.post_id) AS reply_count
  FROM posts p LEFT JOIN latest_reactions lr ON lr.post_id=p.post_id GROUP BY p.post_id
), checks AS (
  SELECT 'unique_like_count' AS contract_name, post_id::text AS subject_id, like_count::text AS observed_value, 'Latest active reaction per user prevents duplicate likes' AS expected_reason FROM counts
  UNION ALL SELECT 'inactive_like_excluded', post_id::text, (SELECT COUNT(*)::text FROM latest_reactions WHERE post_id=counts.post_id AND user_id=3 AND active=true), 'Cy removed like is excluded' FROM counts
  UNION ALL SELECT 'visible_comment_count', post_id::text, top_comment_count::text, 'Only visible top-level comments count' FROM counts
  UNION ALL SELECT 'soft_deleted_comment_excluded', post_id::text, (SELECT COUNT(*)::text FROM comments WHERE post_id=counts.post_id AND deleted_at IS NOT NULL), 'Soft-deleted comment rows exist but are hidden' FROM counts
  UNION ALL SELECT 'reply_count', post_id::text, reply_count::text, 'Visible replies under visible parents count' FROM counts
  UNION ALL SELECT 'post_detail_counts', post_id::text, like_count || '|comments=' || top_comment_count || '|replies=' || reply_count, 'Post detail query exposes derived counts' FROM counts
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
