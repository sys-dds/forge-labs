# BANK-R2-002: Double Entry Ledger Debits Credits

This clinic teaches debit and credit totals must balance and account balances derive from ledger entries. It uses concrete rows for Ada, Ben, Ledger Clearing, holds, transfer attempts, ledger entries, and lifecycle events where relevant.

Run:

```bash
./scripts/bank-r2-test-one.sh 05-banking-systems-redone/002-double-entry-ledger-debits-credits
```

Inspect `03-seed.sql` for `ledger transaction 9002 is intentionally unbalanced and account 101 derives balance from ledger_entries`, `05-verification-query.sql` for contract rows, and `07-broken-model-or-query.sql` for the shortcut that executes successfully but returns wrong rows.
