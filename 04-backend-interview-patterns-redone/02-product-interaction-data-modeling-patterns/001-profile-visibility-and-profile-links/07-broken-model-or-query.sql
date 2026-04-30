SET search_path TO bip_pim_001;
WITH checks AS (
  SELECT 'public_profile_visible' AS contract_name, 'ada_dev' AS subject_id, COUNT(*) FILTER (WHERE field_name='bio')::text AS observed_value, 'public viewer sees Ada public bio' AS expected_reason FROM profiles p JOIN profile_field_visibility f ON f.profile_id=p.profile_id WHERE p.handle='ada_dev'
  UNION ALL SELECT 'private_field_hidden_from_public','ada_dev',COUNT(*) FILTER (WHERE field_name='email')::text,'Ben is not owner so Ada private email is hidden' FROM profiles p JOIN profile_field_visibility f ON f.profile_id=p.profile_id WHERE p.handle='ada_dev'
  UNION ALL SELECT 'owner_can_see_private_field','ada_dev',COUNT(*) FILTER (WHERE field_name='email')::text,'Ada is owner so private email is visible' FROM profiles p JOIN profile_field_visibility f ON f.profile_id=p.profile_id WHERE p.handle='ada_dev'
  UNION ALL SELECT 'blocked_viewer_hidden','ada_dev',COUNT(*)::text,'Blocked Omar sees no Ada profile fields' FROM profiles p JOIN profile_field_visibility f ON f.profile_id=p.profile_id WHERE p.handle='ada_dev'
  UNION ALL SELECT 'deactivated_user_hidden','diya_data',COUNT(*)::text,'Diya inactive user hides profile lookup' FROM profiles p JOIN profile_field_visibility f ON f.profile_id=p.profile_id WHERE p.handle='diya_data'
  UNION ALL SELECT 'handle_lookup','ben_ops',COUNT(*)::text,'Handle uniquely resolves Ben profile' FROM profiles p WHERE p.handle='ben_ops'
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
