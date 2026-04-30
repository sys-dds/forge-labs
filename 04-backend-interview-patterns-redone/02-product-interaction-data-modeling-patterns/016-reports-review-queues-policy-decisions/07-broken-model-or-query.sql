SET search_path TO bip_pim_016;
WITH auto_removed AS (SELECT content_type, content_id, count(*) AS report_count FROM report_events GROUP BY content_type, content_id), anchor AS (SELECT count(*) AS row_count FROM report_events), checks AS (
  SELECT 'report_created' contract_name, 'post:201' subject_id, count(*)::text observed_value, 'Broken query only counts reports' expected_reason FROM report_events WHERE content_id=201
  UNION ALL SELECT 'duplicate_report_grouped','post:201',max(report_count)::text,'Broken groups reports but treats group as removal' FROM auto_removed WHERE content_id=201
  UNION ALL SELECT 'review_queue_item_created','post:201',count(*)::text,'Broken ignores queue state and uses reports as queue' FROM auto_removed WHERE content_id=201
  UNION ALL SELECT 'low_quality_report_not_removed','post:202','0','Broken removes every reported post automatically' FROM anchor
  UNION ALL SELECT 'policy_decision_recorded','decision:4001','0','Broken ignores moderator decisions' FROM anchor
  UNION ALL SELECT 'treatment_applied','post:201','1','Broken applies removal from report existence' FROM anchor
  UNION ALL SELECT 'safe_content_allowed','post:202','0','Broken does not allow safe reported content' FROM anchor
  UNION ALL SELECT 'evidence_linked_to_decision','decision:4001','none','Broken ignores evidence rows' FROM anchor
  UNION ALL SELECT 'queue_priority','post:201',max(report_count)::text,'Broken priority is raw report count' FROM auto_removed WHERE content_id=201
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
