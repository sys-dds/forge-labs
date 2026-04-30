SET search_path TO bip_pim_019;
WITH evidence AS (SELECT s.signal_id, s.user_id, s.signal_type, s.classification, string_agg(e.evidence_id::text,'+' ORDER BY e.evidence_id) AS evidence_ids FROM abuse_signal_events s JOIN abuse_signal_evidence e ON e.signal_id=s.signal_id GROUP BY s.signal_id,s.user_id,s.signal_type,s.classification), checks AS (
  SELECT 'duplicate_comment_signal' contract_name,'user:3' subject_id,count(*)::text observed_value,'Cy duplicate comments 301 and 302 create spam signal 7001' expected_reason FROM evidence WHERE user_id=3 AND signal_type='duplicate_comment_signal'
  UNION ALL SELECT 'fake_like_burst_signal','user:2',count(*)::text,'Ben same-minute like evidence creates fake engagement signal 7002' FROM evidence WHERE user_id=2 AND signal_type='fake_like_burst_signal'
  UNION ALL SELECT 'normal_engagement_not_flagged','user:4',count(*)::text,'Diya normal engagement signal is allow not review' FROM evidence WHERE user_id=4 AND classification='allow'
  UNION ALL SELECT 'report_plus_evidence_reviewed','user:3',count(*)::text,'Report 6001 plus evidence rows send Cy to review or stronger treatment' FROM report_events r JOIN policy_treatments t ON t.user_id=r.reported_user_id WHERE r.report_id=6001 AND t.treatment IN ('review','downrank')
  UNION ALL SELECT 'abusive_account_treatment','user:3',max(treatment),'Cy treatment derives from abuse evidence' FROM policy_treatments WHERE user_id=3
  UNION ALL SELECT 'safe_account_allowed','user:4',max(treatment),'Diya is allowed because normal high engagement is not flagged' FROM policy_treatments WHERE user_id=4
  UNION ALL SELECT 'evidence_rows','signal:7001',COALESCE(max(evidence_ids),'none'),'Signal 7001 links exact duplicate comment evidence rows' FROM evidence WHERE signal_id=7001
  UNION ALL SELECT 'safety_debug_trace','user:3',string_agg(signal_type||':'||classification||':'||evidence_ids,'|' ORDER BY signal_type),'Safety trace explains Cy abuse outcome' FROM evidence WHERE user_id=3
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
