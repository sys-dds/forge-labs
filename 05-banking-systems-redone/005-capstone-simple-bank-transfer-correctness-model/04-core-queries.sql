SET search_path TO bank_r2_005;
-- Query 1: available balance from ledger balance and pending holds.
SELECT b.account_id, b.posted_cents - COALESCE(h.hold_cents,0) AS available_cents FROM (SELECT account_id, SUM(CASE side WHEN 'credit' THEN amount_cents ELSE -amount_cents END) AS posted_cents FROM ledger_entries GROUP BY account_id) b LEFT JOIN (SELECT account_id, SUM(amount_cents) AS hold_cents FROM account_holds WHERE hold_state='pending' GROUP BY account_id) h USING (account_id);
-- Query 2: idempotency retry trace.
SELECT idempotency_key, request_fingerprint, attempt_state, transfer_id FROM transfer_attempts ORDER BY attempt_id;
-- Query 3: balanced ledger transactions.
SELECT ledger_transaction_id, SUM(amount_cents) FILTER (WHERE side='debit') AS debit_total, SUM(amount_cents) FILTER (WHERE side='credit') AS credit_total FROM ledger_entries GROUP BY ledger_transaction_id;
