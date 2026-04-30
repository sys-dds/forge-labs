SET search_path TO bip_sql_022;
SELECT DISTINCT c.creator_id,c.creator_name
FROM creators c
LEFT JOIN posts p ON p.creator_id=c.creator_id
LEFT JOIN payout_onboarding po ON po.creator_id=c.creator_id
LEFT JOIN policy_violations pv ON pv.creator_id=c.creator_id
LEFT JOIN fraud_investigations fi ON fi.creator_id=c.creator_id
WHERE c.active=true OR po.completed=true OR pv.open_violation=false OR fi.open_case=false
ORDER BY c.creator_id;
