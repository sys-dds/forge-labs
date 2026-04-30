SET search_path TO bip_pim_038;
WITH counts AS (SELECT topic_id,count(*) raw_count FROM interaction_events GROUP BY topic_id), checks AS (
SELECT 'velocity_component' contract_name,'topic:101' subject_id,(SELECT raw_count::text FROM counts WHERE topic_id=101) observed_value,'Broken uses raw event count as velocity' expected_reason
UNION ALL SELECT 'unique_actor_component','topic:101',(SELECT raw_count::text FROM counts WHERE topic_id=101),'Broken ignores unique actor component'
UNION ALL SELECT 'freshness_component','topic:103','0','Broken ignores freshness decay'
UNION ALL SELECT 'spam_trend_suppressed','topic:102','false','Broken shows spam by raw count'
UNION ALL SELECT 'safe_trend_allowed','topic:101','true','Broken allows raw count topic'
UNION ALL SELECT 'old_trend_decayed','topic:103',(SELECT raw_count::text FROM counts WHERE topic_id=103),'Broken does not decay old trend'
UNION ALL SELECT 'trend_component_total','snapshot:8001',(SELECT raw_count::text FROM counts WHERE topic_id=101),'Broken total is raw count, not components'
UNION ALL SELECT 'trend_debug_trace','window:3001',string_agg(topic_id||':raw='||raw_count,'|' ORDER BY topic_id),'Broken trace ignores windows, components, spam, and treatments' FROM counts)
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
