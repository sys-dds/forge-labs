SET search_path TO bank_r2_002;
-- Query 1: transaction debit and credit totals.
SELECT ledger_transaction_id, SUM(amount_cents) FILTER (WHERE side='debit') AS debit_total, SUM(amount_cents) FILTER (WHERE side='credit') AS credit_total FROM ledger_entries GROUP BY ledger_transaction_id;
-- Query 2: account balance from entries.
SELECT account_id, SUM(CASE side WHEN 'credit' THEN amount_cents ELSE -amount_cents END) AS balance_cents FROM ledger_entries GROUP BY account_id;
-- Query 3: unbalanced transactions.
SELECT ledger_transaction_id FROM ledger_entries GROUP BY ledger_transaction_id HAVING SUM(amount_cents) FILTER (WHERE side='debit') <> SUM(amount_cents) FILTER (WHERE side='credit');
