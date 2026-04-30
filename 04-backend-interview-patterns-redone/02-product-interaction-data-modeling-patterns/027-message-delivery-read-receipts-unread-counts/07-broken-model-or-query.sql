SET search_path TO bip_pim_027;
WITH c AS (SELECT count(*) total FROM messages WHERE conversation_id=101), checks AS (
SELECT 'delivery_row_created' contract_name,'conversation:101' subject_id,(SELECT total::text FROM c) observed_value,'Broken query counts all messages as unread for everyone' expected_reason
UNION ALL SELECT 'per_user_unread_count','user:Ben',(SELECT total::text FROM c),'Broken unread count is global, not per-user read state'
UNION ALL SELECT 'read_state_debug_trace','conversation:101','global_total='||(SELECT total FROM c),'Broken trace has no read receipts or delivery state') SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
