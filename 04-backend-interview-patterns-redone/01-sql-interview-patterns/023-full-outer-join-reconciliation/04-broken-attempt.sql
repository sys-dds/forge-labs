SET search_path TO bip_sql_023;
SELECT o.order_id AS source_order_id,l.ledger_id AS source_ledger_id,'amount_mismatch' AS mismatch_type,o.amount_pence AS order_amount_pence,l.amount_pence AS ledger_amount_pence,'investigate' AS expected_treatment
FROM orders o JOIN ledger_entries l ON l.order_id=o.order_id
WHERE o.amount_pence <> l.amount_pence
ORDER BY source_order_id;
