SET search_path TO bip_pim_031;
WITH historical AS (SELECT * FROM community_memberships), checks AS (
SELECT 'active_member_visible' contract_name,'user:1' subject_id,(EXISTS(SELECT 1 FROM historical WHERE community_id=101 AND user_id=1))::text observed_value,'Broken treats any membership row as visible' expected_reason
UNION ALL SELECT 'left_member_hidden','user:3',(EXISTS(SELECT 1 FROM historical WHERE community_id=101 AND user_id=3))::text,'Broken treats left membership 1003 as active'
UNION ALL SELECT 'banned_member_blocked','user:4',(NOT EXISTS(SELECT 1 FROM historical WHERE community_id=101 AND user_id=4))::text,'Broken treats banned user like a normal historical member'
UNION ALL SELECT 'owner_role_contract','user:1','member','Broken collapses owner/admin/mod/member roles'
UNION ALL SELECT 'moderator_permission_contract','user:2','true','Broken assumes every member can moderate'
UNION ALL SELECT 'member_permission_denied','user:5','true','Broken grants member moderation'
UNION ALL SELECT 'role_permission_trace','community:101',string_agg(user_id||':member','|' ORDER BY user_id),'Broken ignores role_permissions rows' FROM historical WHERE community_id=101
UNION ALL SELECT 'membership_lifecycle_trace','community:101',string_agg(user_id||':active','|' ORDER BY membership_id),'Broken rewrites all historical memberships as active' FROM historical WHERE community_id=101)
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
