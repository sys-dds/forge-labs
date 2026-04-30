SET search_path TO bip_pim_017;
WITH post_flags AS (SELECT p.post_id, CASE WHEN max(ma.treatment)='remove' THEN 'deleted' ELSE 'visible' END AS flag FROM posts p LEFT JOIN moderation_actions ma ON ma.post_id=p.post_id GROUP BY p.post_id), anchor AS (SELECT count(*) AS row_count FROM posts), checks AS (
  SELECT 'removed_content_hidden' contract_name, 'post:201' subject_id,count(*)::text observed_value,'Broken reads a collapsed deleted flag' expected_reason FROM post_flags WHERE post_id=201 AND flag='deleted'
  UNION ALL SELECT 'pending_appeal_no_restore','appeal:701','0','Broken ignores pending appeal state' FROM anchor
  UNION ALL SELECT 'approved_appeal_restored','appeal:702','0','Broken loses appeal restoration history' FROM anchor
  UNION ALL SELECT 'rejected_appeal_still_removed','appeal:703','1','Broken only knows removed flag' FROM anchor
  UNION ALL SELECT 'reversal_audit_logged','post:202','0','Broken ignores audit log' FROM anchor
  UNION ALL SELECT 'current_treatment','post:202',(SELECT flag FROM post_flags WHERE post_id=202),'Broken emits collapsed flag instead of treatment' FROM anchor
  UNION ALL SELECT 'historical_treatment','post:202','none','Broken loses historical treatments' FROM anchor
  UNION ALL SELECT 'actor_lineage','post:202','none','Broken loses actor lineage' FROM anchor
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
