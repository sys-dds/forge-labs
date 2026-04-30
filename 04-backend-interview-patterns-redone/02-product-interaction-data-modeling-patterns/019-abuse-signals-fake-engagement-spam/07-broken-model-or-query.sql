SET search_path TO bip_pim_019;
WITH report_counts AS (SELECT reported_user_id AS user_id, count(*) AS reports FROM report_events GROUP BY reported_user_id), anchor AS (SELECT count(*) AS row_count FROM users), checks AS (
  SELECT 'duplicate_comment_signal' contract_name,'user:3' subject_id,'0' observed_value,'Broken ignores duplicate comment evidence' expected_reason FROM anchor
  UNION ALL SELECT 'fake_like_burst_signal','user:2','0','Broken ignores like burst evidence' FROM anchor
  UNION ALL SELECT 'normal_engagement_not_flagged','user:4','0','Broken has no normal engagement evidence' FROM anchor
  UNION ALL SELECT 'report_plus_evidence_reviewed','user:3',reports::text,'Broken uses raw report count only' FROM report_counts WHERE user_id=3
  UNION ALL SELECT 'abusive_account_treatment','user:3','review','Broken derives treatment from report count only' FROM anchor
  UNION ALL SELECT 'safe_account_allowed','user:4','allow','Broken assumes no report means safe' FROM anchor
  UNION ALL SELECT 'evidence_rows','signal:7001','none','Broken ignores evidence rows' FROM anchor
  UNION ALL SELECT 'safety_debug_trace','user:3','reports:1','Broken trace is only raw report count' FROM anchor
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
