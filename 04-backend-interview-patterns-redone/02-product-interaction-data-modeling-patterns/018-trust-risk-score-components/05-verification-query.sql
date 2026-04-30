SET search_path TO bip_pim_018;
WITH totals AS (SELECT user_id, sum(component_value) AS total, string_agg(component_type||':'||component_value::text,'|' ORDER BY component_type) AS trace FROM trust_score_components GROUP BY user_id), treatment AS (SELECT user_id, CASE WHEN total < -20 THEN 'review' ELSE 'allow' END AS derived_treatment FROM totals), checks AS (
  SELECT 'report_component' contract_name, 'user:2' subject_id,sum(component_value)::text observed_value,'Report component lowers Ben trust from report 1001' expected_reason FROM trust_score_components WHERE user_id=2 AND component_type='report_component'
  UNION ALL SELECT 'positive_engagement_component','user:2',sum(component_value)::text,'Positive engagement component raises Ben trust' FROM trust_score_components WHERE user_id=2 AND component_type='positive_engagement_component'
  UNION ALL SELECT 'appeal_restoration_component','user:2',sum(component_value)::text,'Approved appeal 5001 restores part of trust' FROM trust_score_components WHERE user_id=2 AND component_type='appeal_restoration_component'
  UNION ALL SELECT 'block_mute_component','user:2',sum(component_value)::text,'Block and mute evidence lowers Ben trust' FROM trust_score_components WHERE user_id=2 AND component_type='block_mute_component'
  UNION ALL SELECT 'component_total','user:2',total::text,'Component total is derived from named rows' FROM totals WHERE user_id=2
  UNION ALL SELECT 'risk_treatment','user:2',derived_treatment,'Treatment derives from component total threshold -20' FROM treatment WHERE user_id=2
  UNION ALL SELECT 'healthy_creator_allowed','user:3',derived_treatment,'Cy has healthy positive component and is allowed' FROM treatment WHERE user_id=3
  UNION ALL SELECT 'score_debug_trace','user:2',trace,'Debug trace exposes component breakdown' FROM totals WHERE user_id=2
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
