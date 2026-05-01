# Banking Correctness Map

## BANK-R2-001 accounts and balances

Teaches `customers`, `accounts`, `posted_balance_snapshots`, `account_holds`, and `account_status_events`. It prevents the mistake of reporting posted balance as available balance when Ada Current has a pending hold.

## BANK-R2-002 double-entry ledger

Teaches `ledger_transactions` and `ledger_entries` as source-of-truth movement rows. It prevents treating a transaction amount as a balance without proving debit and credit totals match.

## BANK-R2-003 transfers and idempotency

Teaches `transfer_requests`, `idempotency_keys`, `transfer_attempts`, `ledger_transactions`, and `ledger_entries`. It prevents retrying `idem-rent-001` from posting twice.

## BANK-R2-004 transaction lifecycle

Teaches `transaction_events`, derived current state, `ledger_transactions`, `ledger_entries`, and `reversals`. It prevents overwriting pending, posted, failed, and reversed history with one current status.

## BANK-R2-005 capstone

Combines account availability, holds, balanced ledger posting, idempotent transfers, lifecycle events, reversals, and audit traces.
