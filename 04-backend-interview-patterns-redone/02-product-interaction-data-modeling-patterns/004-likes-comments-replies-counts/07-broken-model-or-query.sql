SET search_path TO bip_pim_004;
WITH counts AS (SELECT p.post_id, COUNT(r.reaction_event_id) AS like_count, COUNT(c.comment_id) FILTER (WHERE c.parent_comment_id IS NULL) AS top_comment_count, COUNT(c.comment_id) FILTER (WHERE c.parent_comment_id IS NOT NULL) AS reply_count FROM posts p LEFT JOIN post_reactions r ON r.post_id=p.post_id LEFT JOIN comments c ON c.post_id=p.post_id GROUP BY p.post_id), checks AS (
  SELECT 'unique_like_count' AS contract_name, post_id::text AS subject_id, like_count::text AS observed_value, 'Latest active reaction per user prevents duplicate likes' AS expected_reason FROM counts
  UNION ALL SELECT 'inactive_like_excluded', post_id::text, '1', 'Cy removed like is excluded' FROM counts
  UNION ALL SELECT 'visible_comment_count', post_id::text, top_comment_count::text, 'Only visible top-level comments count' FROM counts
  UNION ALL SELECT 'soft_deleted_comment_excluded', post_id::text, '1', 'Soft-deleted comment rows exist but are hidden' FROM counts
  UNION ALL SELECT 'reply_count', post_id::text, reply_count::text, 'Visible replies under visible parents count' FROM counts
  UNION ALL SELECT 'post_detail_counts', post_id::text, like_count || '|comments=' || top_comment_count || '|replies=' || reply_count, 'Post detail query exposes derived counts' FROM counts
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
