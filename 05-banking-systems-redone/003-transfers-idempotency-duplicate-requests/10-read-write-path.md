# Read And Write Path

## Write path

Validate account state, currency, amount, lifecycle state, and dedupe keys before inserting source rows. Insert audit/debug rows in the same correctness boundary as the source rows.

## Read path

Read from `accounts, transfer_requests, idempotency_keys, ledger_transactions, ledger_entries, transfer_attempts` and derive the contract answer from current state plus source history.

## Transaction/correctness note

In a real implementation the source rows that make one logical movement must be committed atomically.

## Failure/retry note

Retry behavior should be explicit. A duplicate request should return the same result, a conflicting duplicate should be visible as conflict, and a failed attempt should not silently post money.
