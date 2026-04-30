SELECT resolved.*
FROM resolve_dispute(10,'Maya confirmed refund') AS resolved;
SELECT d.id, d.seller, d.status, a.note
FROM disputes d
JOIN dispute_audit a ON a.dispute_id = d.id
ORDER BY d.id;
