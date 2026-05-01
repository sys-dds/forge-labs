# BANK-R2-004: Transaction Lifecycle Pending Posted Reversed

This clinic teaches current state derives from lifecycle events and only posted entries affect posted balance. It uses concrete rows for Ada, Ben, Ledger Clearing, holds, transfer attempts, ledger entries, and lifecycle events where relevant.

Run:

```bash
./scripts/bank-r2-test-one.sh 05-banking-systems-redone/004-transaction-lifecycle-pending-posted-reversed
```

Inspect `03-seed.sql` for `transaction tx-pending-1 is pending, tx-failed-1 failed, and reversal 7001 links to tx-posted-2`, `05-verification-query.sql` for contract rows, and `07-broken-model-or-query.sql` for the shortcut that executes successfully but returns wrong rows.
