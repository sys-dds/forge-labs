SET search_path TO bip_sql_002;
SELECT u.user_id, u.user_name, COUNT(*) AS missing_required_checks
FROM users u
JOIN user_checks uc ON uc.user_id = u.user_id
WHERE u.active = true
  AND uc.status <> 'passed'
GROUP BY u.user_id, u.user_name
ORDER BY u.user_id;
