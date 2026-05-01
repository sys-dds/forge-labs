SET search_path TO bank_r2_001;
-- Query 1: active available balance with active holds.
SELECT a.account_id, p.posted_balance_cents - COALESCE(SUM(h.amount_cents) FILTER (WHERE h.hold_state='pending'),0) AS available_cents FROM accounts a JOIN posted_balance_snapshots p USING (account_id) LEFT JOIN account_holds h USING (account_id) WHERE a.account_status='active' GROUP BY a.account_id,p.posted_balance_cents;
-- Query 2: holds that should not reduce availability.
SELECT hold_id, hold_state, amount_cents FROM account_holds WHERE account_id=101 AND hold_state <> 'pending';
-- Query 3: account lifecycle trace.
SELECT account_id, status, event_at, reason FROM account_status_events ORDER BY account_id,event_at;
