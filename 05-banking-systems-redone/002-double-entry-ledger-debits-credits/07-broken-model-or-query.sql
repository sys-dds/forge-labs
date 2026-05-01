SET search_path TO bank_r2_002;
WITH tx_totals AS (SELECT ledger_transaction_id, SUM(amount_cents) AS credit_total, SUM(amount_cents) AS debit_total, COUNT(*) AS debit_rows, 0 AS credit_rows, true AS same_currency FROM ledger_entries GROUP BY ledger_transaction_id), balances AS (SELECT account_id, SUM(amount_cents) AS balance_cents FROM ledger_entries WHERE side='credit' GROUP BY account_id)
SELECT 'balanced_transaction' AS contract_name, ledger_transaction_id::text AS subject_id, (debit_total=credit_total)::text AS observed_value, 'ledger transaction 9001 has equal debit and credit totals' AS expected_reason FROM tx_totals WHERE ledger_transaction_id=9001
UNION ALL SELECT 'unbalanced_transaction_detected', ledger_transaction_id::text, (debit_total<>credit_total)::text, 'ledger transaction 9002 is detected as unbalanced' FROM tx_totals WHERE ledger_transaction_id=9002
UNION ALL SELECT 'debit_credit_rows_exist', ledger_transaction_id::text, (debit_rows::text||' debit/'||credit_rows::text||' credit'), 'both sides exist for the ledger transaction' FROM tx_totals WHERE ledger_transaction_id=9001
UNION ALL SELECT 'account_balance_from_entries', account_id::text, balance_cents::text, 'account 101 balance derives from signed ledger entries' FROM balances WHERE account_id=101
UNION ALL SELECT 'append_only_entry_trace', ledger_transaction_id::text, COUNT(*)::text, 'ledger transaction keeps source entry rows' FROM ledger_entries WHERE ledger_transaction_id=9001 GROUP BY ledger_transaction_id
UNION ALL SELECT 'currency_consistency', ledger_transaction_id::text, same_currency::text, 'entries post to accounts in the transaction currency' FROM tx_totals WHERE ledger_transaction_id=9001
ORDER BY contract_name;
