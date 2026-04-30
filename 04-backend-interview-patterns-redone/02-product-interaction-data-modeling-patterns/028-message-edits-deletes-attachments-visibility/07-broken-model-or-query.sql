SET search_path TO bip_pim_028;
WITH checks AS (SELECT 'latest_edit_current_body' contract_name,'message:1001' subject_id,original_body observed_value,'Broken query reads only messages.original_body' expected_reason FROM messages WHERE message_id=1001
UNION ALL SELECT 'message_lifecycle_trace','conversation:101',string_agg(message_id||':'||original_body,';' ORDER BY message_id),'Broken trace ignores edits, deletions, and attachments' FROM messages) SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
