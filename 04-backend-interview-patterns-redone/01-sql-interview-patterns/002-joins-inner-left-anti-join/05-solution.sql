SET search_path TO bip_sql_002;
SELECT u.user_id, u.user_name, COUNT(rc.check_name) AS missing_required_checks
FROM users u
CROSS JOIN required_checks rc
LEFT JOIN user_checks uc
  ON uc.user_id = u.user_id
 AND uc.check_name = rc.check_name
 AND uc.status = 'passed'
WHERE u.active = true
  AND uc.user_id IS NULL
GROUP BY u.user_id, u.user_name
ORDER BY u.user_id;
