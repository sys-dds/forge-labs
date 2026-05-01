SET search_path TO bank_r2_001;
WITH account_view AS (
  SELECT a.account_id, a.account_status, p.posted_balance_cents, 0 AS hold_cents, p.posted_balance_cents AS available_cents
  FROM accounts a JOIN posted_balance_snapshots p USING (account_id)
)
SELECT 'active_account_visible' AS contract_name, account_id::text AS subject_id, account_status AS observed_value, 'active accounts appear in balance view' AS expected_reason FROM account_view WHERE account_id=101
UNION ALL SELECT 'closed_account_hidden', 'account:'||account_id, COUNT(*)::text, 'closed account 102 is not active-balance visible' FROM account_view WHERE account_id=102 GROUP BY account_id
UNION ALL SELECT 'actual_balance', account_id::text, posted_balance_cents::text, 'posted snapshot is actual balance before holds' FROM account_view WHERE account_id=101
UNION ALL SELECT 'pending_hold_total', account_id::text, hold_cents::text, 'only pending unexpired holds reduce available balance' FROM account_view WHERE account_id=101
UNION ALL SELECT 'released_hold_excluded', account_id::text, COUNT(*)::text, 'released and expired holds are excluded from active hold total' FROM account_holds WHERE account_id=101 AND hold_state IN ('released','expired') GROUP BY account_id
UNION ALL SELECT 'available_balance', account_id::text, available_cents::text, 'available equals actual minus pending holds' FROM account_view WHERE account_id=101
UNION ALL SELECT 'available_vs_actual_difference', account_id::text, (posted_balance_cents - available_cents)::text, 'difference equals active pending hold total' FROM account_view WHERE account_id=101
ORDER BY contract_name;
