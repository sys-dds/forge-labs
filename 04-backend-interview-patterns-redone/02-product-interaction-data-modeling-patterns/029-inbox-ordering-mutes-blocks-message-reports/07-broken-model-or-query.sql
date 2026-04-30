SET search_path TO bip_pim_029;
WITH global_order AS (SELECT conversation_id,max(sent_rank) latest_rank FROM messages GROUP BY conversation_id), checks AS (
SELECT 'inbox_order' contract_name,'user:Ada' subject_id,string_agg(conversation_id::text,'>' ORDER BY latest_rank DESC) observed_value,'Broken query orders by global max timestamp and ignores viewer state' expected_reason FROM global_order
UNION ALL SELECT 'inbox_debug_trace','user:Ada',string_agg(conversation_id||':rank='||latest_rank,';' ORDER BY latest_rank DESC),'Broken trace has no settings, blocks, reports, or unread state' FROM global_order) SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
