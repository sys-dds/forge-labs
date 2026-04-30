SET search_path TO bip_pim_016;
WITH report_groups AS (SELECT content_type, content_id, count(*) AS report_count FROM report_events GROUP BY content_type, content_id), evidence_by_decision AS (SELECT d.decision_id, string_agg(e.evidence_id::text,'+' ORDER BY e.evidence_id) AS evidence_ids FROM policy_decisions d JOIN review_queue_items q ON q.queue_item_id=d.queue_item_id JOIN report_events r ON r.content_type=q.content_type AND r.content_id=q.content_id JOIN report_evidence e ON e.report_id=r.report_id GROUP BY d.decision_id), checks AS (
  SELECT 'report_created' contract_name, 'post:201' subject_id, count(*)::text observed_value, 'Two report events exist for post 201' expected_reason FROM report_events WHERE content_type='post' AND content_id=201
  UNION ALL SELECT 'duplicate_report_grouped','post:201',max(report_count)::text,'Duplicate reports group into one content report group' FROM report_groups WHERE content_id=201
  UNION ALL SELECT 'review_queue_item_created','post:201',count(*)::text,'Reported post 201 has one queue item 3001' FROM review_queue_items WHERE content_id=201
  UNION ALL SELECT 'low_quality_report_not_removed','post:202',count(*)::text,'Post 202 is not hidden when decision is safe or report quality is low' FROM policy_decisions d JOIN review_queue_items q ON q.queue_item_id=d.queue_item_id LEFT JOIN policy_treatments t ON t.decision_id=d.decision_id WHERE q.content_id=202 AND d.decision='safe' AND t.treatment='allow'
  UNION ALL SELECT 'policy_decision_recorded','decision:4001',count(*)::text,'Moderator Mina recorded spam violation decision 4001' FROM policy_decisions WHERE decision_id=4001 AND policy='spam' AND decision='violation'
  UNION ALL SELECT 'treatment_applied','post:201',count(*)::text,'Violation decision 4001 applies hide treatment 5001' FROM policy_treatments WHERE decision_id=4001 AND treatment='hide'
  UNION ALL SELECT 'safe_content_allowed','post:202',count(*)::text,'Safe decision 4002 keeps post 202 allowed' FROM policy_treatments WHERE decision_id=4002 AND treatment='allow'
  UNION ALL SELECT 'evidence_linked_to_decision','decision:4001',COALESCE(max(evidence_ids),'none'),'Decision 4001 is backed by evidence rows 2001 and 2002' FROM evidence_by_decision WHERE decision_id=4001
  UNION ALL SELECT 'queue_priority','post:201',max(priority)::text,'Queue priority derives from credible spam severity and evidence count' FROM review_queue_items WHERE content_id=201
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
