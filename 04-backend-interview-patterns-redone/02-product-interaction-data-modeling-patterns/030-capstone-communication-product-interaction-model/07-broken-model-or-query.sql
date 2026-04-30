SET search_path TO bip_pim_030;
WITH raw AS (SELECT m.message_id,m.conversation_id,m.body FROM messages m), checks AS (
SELECT 'participant_contract' contract_name,'raw_messages' subject_id,count(*)::text observed_value,'Broken query returns raw messages without participant state' expected_reason FROM raw
UNION ALL SELECT 'communication_debug_trace_contract','raw_messages',string_agg(message_id::text,'|' ORDER BY message_id),'Broken trace ignores read receipts, delete visibility, settings, blocks, and reports' FROM raw) SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
