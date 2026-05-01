SET search_path TO bank_r2_003;
-- Query 1: retry lookup by idempotency key.
SELECT k.idempotency_key, k.request_fingerprint, k.transfer_id, tr.request_state FROM idempotency_keys k LEFT JOIN transfer_requests tr USING (transfer_id);
-- Query 2: duplicate attempts for the same key.
SELECT idempotency_key, COUNT(*) AS attempts, COUNT(DISTINCT request_fingerprint) AS fingerprints FROM transfer_attempts GROUP BY idempotency_key;
-- Query 3: ledger rows created for a transfer.
SELECT tr.transfer_id, le.side, le.amount_cents FROM transfer_requests tr JOIN ledger_entries le ON le.ledger_transaction_id=tr.ledger_transaction_id ORDER BY tr.transfer_id, le.side;
