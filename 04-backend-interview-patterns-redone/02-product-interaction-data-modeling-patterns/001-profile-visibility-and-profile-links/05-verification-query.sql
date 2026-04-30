SET search_path TO bip_pim_001;
WITH checks AS (
  SELECT 'public_profile_visible' AS contract_name, 'ada_dev' AS subject_id, COUNT(*) FILTER (WHERE f.field_name='bio')::text AS observed_value, 'public viewer sees Ada public bio' AS expected_reason
  FROM profiles p JOIN users u ON u.user_id=p.user_id JOIN profile_field_visibility f ON f.profile_id=p.profile_id LEFT JOIN user_blocks b ON b.owner_user_id=p.user_id AND b.blocked_user_id=2
  WHERE p.handle='ada_dev' AND u.active=true AND b.owner_user_id IS NULL AND f.visibility='public'
  UNION ALL
  SELECT 'private_field_hidden_from_public', 'ada_dev', COUNT(*) FILTER (WHERE f.field_name='email')::text, 'Ben is not owner so Ada private email is hidden'
  FROM profiles p JOIN users u ON u.user_id=p.user_id JOIN profile_field_visibility f ON f.profile_id=p.profile_id LEFT JOIN user_blocks b ON b.owner_user_id=p.user_id AND b.blocked_user_id=2
  WHERE p.handle='ada_dev' AND u.active=true AND b.owner_user_id IS NULL AND f.visibility='public'
  UNION ALL
  SELECT 'owner_can_see_private_field', 'ada_dev', COUNT(*) FILTER (WHERE f.field_name='email')::text, 'Ada is owner so private email is visible'
  FROM profiles p JOIN users u ON u.user_id=p.user_id JOIN profile_field_visibility f ON f.profile_id=p.profile_id LEFT JOIN user_blocks b ON b.owner_user_id=p.user_id AND b.blocked_user_id=1
  WHERE p.handle='ada_dev' AND u.active=true AND b.owner_user_id IS NULL AND (f.visibility='public' OR p.user_id=1)
  UNION ALL
  SELECT 'blocked_viewer_hidden', 'ada_dev', COUNT(f.field_name)::text, 'Blocked Omar sees no Ada profile fields'
  FROM profiles p JOIN users u ON u.user_id=p.user_id JOIN profile_field_visibility f ON f.profile_id=p.profile_id LEFT JOIN user_blocks b ON b.owner_user_id=p.user_id AND b.blocked_user_id=3
  WHERE p.handle='ada_dev' AND u.active=true AND b.owner_user_id IS NULL AND f.visibility='public'
  UNION ALL
  SELECT 'deactivated_user_hidden', 'diya_data', COUNT(f.field_name)::text, 'Diya inactive user hides profile lookup'
  FROM profiles p JOIN users u ON u.user_id=p.user_id JOIN profile_field_visibility f ON f.profile_id=p.profile_id
  WHERE p.handle='diya_data' AND u.active=true
  UNION ALL
  SELECT 'handle_lookup', 'ben_ops', COUNT(*)::text, 'Handle uniquely resolves Ben profile'
  FROM profiles p JOIN users u ON u.user_id=p.user_id WHERE p.handle='ben_ops' AND u.active=true
)
SELECT contract_name, subject_id, observed_value, expected_reason FROM checks ORDER BY contract_name;
