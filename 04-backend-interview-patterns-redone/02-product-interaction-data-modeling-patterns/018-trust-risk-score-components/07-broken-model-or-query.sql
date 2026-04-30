SET search_path TO bip_pim_018;
WITH opaque AS (SELECT user_id, component_total AS trust_score, CASE WHEN treatment='allow' THEN 'false' ELSE 'true' END AS risky FROM trust_score_snapshots), anchor AS (SELECT count(*) AS row_count FROM users), checks AS (
  SELECT 'report_component' contract_name,'user:2' subject_id,'none' observed_value,'Broken output has no report component' expected_reason FROM anchor
  UNION ALL SELECT 'positive_engagement_component','user:2','none','Broken output has no positive component' FROM anchor
  UNION ALL SELECT 'appeal_restoration_component','user:2','none','Broken output has no appeal component' FROM anchor
  UNION ALL SELECT 'block_mute_component','user:2','none','Broken output has no block/mute component' FROM anchor
  UNION ALL SELECT 'component_total','user:2',trust_score::text,'Broken trusts opaque snapshot total' FROM opaque WHERE user_id=2
  UNION ALL SELECT 'risk_treatment','user:2',risky,'Broken emits boolean risky flag' FROM opaque WHERE user_id=2
  UNION ALL SELECT 'healthy_creator_allowed','user:3',risky,'Broken emits boolean risky flag for healthy creator' FROM opaque WHERE user_id=3
  UNION ALL SELECT 'score_debug_trace','user:2','none','Broken has no component trace' FROM anchor
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
