SET search_path TO bip_pim_020;
WITH report_counts AS (SELECT content_id AS post_id, count(*) AS reports FROM report_events WHERE content_type='post' GROUP BY content_id), anchor AS (SELECT count(*) AS row_count FROM users), checks AS (
  SELECT 'visibility_contract' contract_name,'viewer:1' subject_id,COALESCE(string_agg(post_id::text,'|' ORDER BY post_id),'none') observed_value,'Broken removes every reported post and ignores appeals' expected_reason FROM posts WHERE post_id NOT IN (SELECT post_id FROM report_counts)
  UNION ALL SELECT 'review_queue_contract','post:202',(SELECT reports::text FROM report_counts WHERE post_id=202),'Broken uses report count as queue truth' FROM anchor
  UNION ALL SELECT 'policy_decision_contract','post:203','0','Broken ignores policy decisions' FROM anchor
  UNION ALL SELECT 'treatment_contract','post:203','1','Broken applies static removal from report count' FROM anchor
  UNION ALL SELECT 'appeal_reversal_contract','post:204','none','Broken ignores appeals and reversals' FROM anchor
  UNION ALL SELECT 'trust_component_contract','user:3','none','Broken ignores trust components' FROM anchor
  UNION ALL SELECT 'abuse_signal_contract','signal:1001','none','Broken ignores abuse evidence' FROM anchor
  UNION ALL SELECT 'audit_lineage_contract','trace:1301-1304','none','Broken ignores audit lineage' FROM anchor
  UNION ALL SELECT 'safety_debug_trace_contract','user:3','risky:true','Broken emits boolean risky flag' FROM anchor
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
