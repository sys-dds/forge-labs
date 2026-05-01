SET search_path TO bank_r2_004;
-- Query 1: latest lifecycle state per transaction.
SELECT DISTINCT ON (external_transaction_id) external_transaction_id, event_state, event_at FROM transaction_events ORDER BY external_transaction_id, event_at DESC;
-- Query 2: posted account balance from ledger entries.
SELECT account_id, SUM(CASE side WHEN 'credit' THEN amount_cents ELSE -amount_cents END) AS balance_cents FROM ledger_entries GROUP BY account_id;
-- Query 3: reversal trace.
SELECT reversal_id, original_external_transaction_id, reversal_external_transaction_id, reason FROM reversals;
