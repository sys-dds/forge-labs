SET search_path TO bip_pim_035;
WITH raw_view AS (SELECT m.user_id,p.post_id,r.rsvp_state FROM community_memberships m FULL JOIN community_posts p ON p.community_id=m.community_id FULL JOIN event_rsvps r ON r.user_id=m.user_id), checks AS (
SELECT 'membership_contract' contract_name,'community:101' subject_id,string_agg(user_id||':member','|' ORDER BY user_id) observed_value,'Broken collapses membership lifecycle' expected_reason FROM community_memberships WHERE community_id=101
UNION ALL SELECT 'role_permission_contract','user:2','remove_post=true|transfer_ownership=true','Broken treats moderator as global admin'
UNION ALL SELECT 'private_access_contract','community:101',(SELECT string_agg(user_id::text,'|' ORDER BY user_id) FROM (SELECT user_id FROM community_memberships UNION SELECT requester_user_id FROM community_join_requests UNION SELECT invited_user_id FROM community_invites) s),'Broken grants request/invite rows access'
UNION ALL SELECT 'channel_visibility_contract','user:2',(SELECT string_agg(post_id::text,'|' ORDER BY post_id) FROM community_posts),'Broken raw post view ignores private/deleted/moderation filters'
UNION ALL SELECT 'post_thread_contract','thread:8501',(SELECT parent_post_id||'->'||reply_post_id FROM community_threads WHERE thread_id=8501),'Broken happens to preserve thread link'
UNION ALL SELECT 'moderation_audit_contract','post:8003','false','Broken ignores audit trace'
UNION ALL SELECT 'event_rsvp_contract','event:9001',(SELECT string_agg(user_id||':going','|' ORDER BY rsvp_id) FROM event_rsvps WHERE event_id=9001),'Broken rewrites all RSVP states as going'
UNION ALL SELECT 'waitlist_capacity_contract','event:9001','going='||(SELECT count(*) FROM event_rsvps WHERE event_id=9001)||'|capacity='||(SELECT capacity FROM community_events WHERE event_id=9001)||'|waitlist=none','Broken counts waitlist as capacity'
UNION ALL SELECT 'attendance_contract','attendance:9401',(EXISTS(SELECT 1 FROM event_attendance WHERE attendance_id=9401))::text,'Broken attendance ignores RSVP lifecycle'
UNION ALL SELECT 'community_debug_trace_contract','community:101','raw_join_rows='||(SELECT count(*) FROM raw_view),'Broken debug trace is just raw join cardinality')
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
