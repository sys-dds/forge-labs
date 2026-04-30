SET search_path TO bip_sql_014;
SELECT wallet_id, MAX(ledger_entry_id) AS ledger_entry_id, SUM(amount_pence) AS amount_pence, SUM(amount_pence) AS running_balance_pence
FROM ledger_entries
WHERE status = 'posted'
GROUP BY wallet_id
ORDER BY wallet_id;
