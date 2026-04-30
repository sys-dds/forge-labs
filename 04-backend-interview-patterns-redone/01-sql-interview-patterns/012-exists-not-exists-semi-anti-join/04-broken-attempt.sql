SET search_path TO bip_sql_012;
SELECT b.buyer_id, b.buyer_name
FROM buyers b
JOIN payment_methods pm ON pm.buyer_id = b.buyer_id
JOIN identity_checks ic ON ic.buyer_id = b.buyer_id
WHERE b.active = true AND pm.verified = true AND ic.status = 'passed'
ORDER BY b.buyer_id;
