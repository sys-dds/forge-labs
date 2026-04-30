SET search_path TO bip_sql_014;
SELECT wallet_id, ledger_entry_id, amount_pence,
       SUM(amount_pence) OVER (PARTITION BY wallet_id ORDER BY posted_at, ledger_entry_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance_pence
FROM ledger_entries
WHERE status = 'posted'
ORDER BY wallet_id, posted_at, ledger_entry_id;
