SET search_path TO bip_sql_023;
WITH joined AS (
  SELECT o.order_id, l.ledger_id, o.status, l.posting_type, o.amount_pence AS order_amount_pence, l.amount_pence AS ledger_amount_pence,
         CASE
           WHEN o.order_id IS NULL THEN 'extra_ledger'
           WHEN l.ledger_id IS NULL AND o.status <> 'cancelled' THEN 'missing_ledger'
           WHEN o.status = 'refunded' AND l.posting_type <> 'refund' THEN 'status_mismatch'
           WHEN o.status = 'completed' AND l.posting_type <> 'sale' THEN 'status_mismatch'
           WHEN o.status = 'completed' AND o.amount_pence <> l.amount_pence THEN 'amount_mismatch'
         END AS mismatch_type
  FROM orders o FULL OUTER JOIN ledger_entries l ON l.order_id=o.order_id
)
SELECT order_id AS source_order_id, ledger_id AS source_ledger_id, mismatch_type, order_amount_pence, ledger_amount_pence,
       CASE WHEN mismatch_type IS NOT NULL THEN 'investigate_reconciliation_gap' END AS expected_treatment
FROM joined
WHERE mismatch_type IS NOT NULL
ORDER BY COALESCE(order_id, 999999), COALESCE(ledger_id, 999999);
