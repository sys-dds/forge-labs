SET search_path TO bip_pim_026;
WITH all_msgs AS (SELECT conversation_id,count(*) c FROM messages GROUP BY conversation_id), checks AS (
SELECT 'direct_conversation_participants' contract_name,'conversation:101' subject_id,(SELECT c::text FROM all_msgs WHERE conversation_id=101) observed_value,'Broken query counts messages instead of active participants' expected_reason
UNION ALL SELECT 'left_participant_future_hidden','message:1003','false','Broken query ignores left participant state'
UNION ALL SELECT 'conversation_visibility_trace','conversation:102',string_agg(message_id::text,';' ORDER BY message_id),'Broken trace returns all messages by conversation_id only' FROM messages WHERE conversation_id=102)
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
