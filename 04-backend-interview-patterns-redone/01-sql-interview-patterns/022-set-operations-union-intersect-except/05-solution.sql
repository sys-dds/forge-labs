SET search_path TO bip_sql_022;
WITH active_creators AS (
  SELECT creator_id FROM creators WHERE active = true
), safe_post_creators AS (
  SELECT creator_id FROM posts WHERE status = 'published' AND safe = true GROUP BY creator_id HAVING COUNT(*) >= 3
), payout_creators AS (
  SELECT creator_id FROM payout_onboarding WHERE completed = true
), disqualified AS (
  SELECT creator_id FROM policy_violations WHERE open_violation = true
  UNION
  SELECT creator_id FROM fraud_investigations WHERE open_case = true
), eligible_ids AS (
  SELECT creator_id FROM active_creators
  INTERSECT
  SELECT creator_id FROM safe_post_creators
  INTERSECT
  SELECT creator_id FROM payout_creators
  EXCEPT
  SELECT creator_id FROM disqualified
)
SELECT c.creator_id, c.creator_name
FROM eligible_ids e JOIN creators c ON c.creator_id=e.creator_id
ORDER BY c.creator_id;
