SET search_path TO bip_pim_032;
WITH loose_access AS (SELECT community_id,requester_user_id user_id FROM community_join_requests UNION SELECT community_id,invited_user_id FROM community_invites), checks AS (
SELECT 'pending_request_not_member' contract_name,'request:2001' subject_id,(EXISTS(SELECT 1 FROM loose_access WHERE user_id=1))::text observed_value,'Broken grants access to pending request' expected_reason
UNION ALL SELECT 'approved_request_member','request:2002',(EXISTS(SELECT 1 FROM loose_access WHERE user_id=2))::text,'Broken happens to include approved request'
UNION ALL SELECT 'rejected_request_hidden','request:2003',(EXISTS(SELECT 1 FROM loose_access WHERE user_id=3))::text,'Broken grants rejected request'
UNION ALL SELECT 'valid_invite_membership','invite:4006',(EXISTS(SELECT 1 FROM loose_access WHERE user_id=6))::text,'Broken grants invite row'
UNION ALL SELECT 'expired_invite_denied','invite:4004',(EXISTS(SELECT 1 FROM loose_access WHERE user_id=4))::text,'Broken grants expired invite'
UNION ALL SELECT 'banned_invite_denied','invite:4005',(EXISTS(SELECT 1 FROM loose_access WHERE user_id=5))::text,'Broken grants banned invite'
UNION ALL SELECT 'request_audit_trace','community:101','request_or_invite_row_is_enough','Broken ignores audit decision rows'
UNION ALL SELECT 'private_access_contract','community:101',string_agg(user_id::text,'|' ORDER BY user_id),'Broken allows all request/invite users' FROM loose_access WHERE community_id=101)
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
