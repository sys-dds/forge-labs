SET search_path TO bip_pim_034;
WITH every_rsvp AS (SELECT * FROM event_rsvps), checks AS (
SELECT 'member_rsvp_allowed' contract_name,'rsvp:3001' subject_id,(EXISTS(SELECT 1 FROM every_rsvp WHERE rsvp_id=3001))::text observed_value,'Broken counts any RSVP' expected_reason
UNION ALL SELECT 'non_member_rsvp_denied','rsvp:3003',(EXISTS(SELECT 1 FROM every_rsvp WHERE rsvp_id=3003))::text,'Broken lets non-member Cy RSVP'
UNION ALL SELECT 'declined_not_counted','rsvp:3004',(EXISTS(SELECT 1 FROM every_rsvp WHERE rsvp_id=3004))::text,'Broken counts declined RSVP'
UNION ALL SELECT 'waitlisted_not_going','rsvp:3005',(EXISTS(SELECT 1 FROM every_rsvp WHERE rsvp_id=3005))::text,'Broken counts waitlisted RSVP'
UNION ALL SELECT 'cancelled_event_hidden','event:2002',(EXISTS(SELECT 1 FROM community_events WHERE event_id=2002))::text,'Broken shows cancelled event'
UNION ALL SELECT 'attendance_checkin_contract','attendance:5001',(EXISTS(SELECT 1 FROM event_attendance WHERE attendance_id=5001))::text,'Broken attendance ignores going RSVP validation'
UNION ALL SELECT 'waitlist_promotion_contract','event:2001',string_agg(user_id||':going','|' ORDER BY waitlist_rank),'Broken rewrites waitlist as going' FROM event_waitlist WHERE event_id=2001
UNION ALL SELECT 'event_lifecycle_trace','event:2001','going='||(SELECT count(*) FROM every_rsvp WHERE event_id=2001)||'|capacity='||(SELECT capacity FROM community_events WHERE event_id=2001)||'|upcoming=true','Broken counts every RSVP and ignores cancelled states')
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
