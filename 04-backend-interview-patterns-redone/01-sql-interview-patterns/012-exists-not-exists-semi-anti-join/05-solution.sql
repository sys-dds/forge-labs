SET search_path TO bip_sql_012;
SELECT b.buyer_id, b.buyer_name
FROM buyers b
WHERE b.active = true
  AND EXISTS (SELECT 1 FROM payment_methods pm WHERE pm.buyer_id = b.buyer_id AND pm.verified = true)
  AND EXISTS (SELECT 1 FROM identity_checks ic WHERE ic.buyer_id = b.buyer_id AND ic.status = 'passed')
  AND NOT EXISTS (SELECT 1 FROM fraud_cases fc WHERE fc.buyer_id = b.buyer_id AND fc.status = 'open')
  AND NOT EXISTS (SELECT 1 FROM chargebacks cb WHERE cb.buyer_id = b.buyer_id AND cb.chargeback_at >= DATE '2026-01-01')
ORDER BY b.buyer_id;
