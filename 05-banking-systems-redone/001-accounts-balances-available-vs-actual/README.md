# BANK-R2-001: Accounts Balances Available Vs Actual

This clinic teaches available balance equals posted balance minus active holds, while closed accounts and released holds are excluded. It uses concrete rows for Ada, Ben, Ledger Clearing, holds, transfer attempts, ledger entries, and lifecycle events where relevant.

Run:

```bash
./scripts/bank-r2-test-one.sh 05-banking-systems-redone/001-accounts-balances-available-vs-actual
```

Inspect `03-seed.sql` for `Ada account 101 has a pending hold, a released hold, an expired hold, and closed account 102 is excluded`, `05-verification-query.sql` for contract rows, and `07-broken-model-or-query.sql` for the shortcut that executes successfully but returns wrong rows.
