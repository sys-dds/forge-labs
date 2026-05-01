# BANK-R2-003: Transfers Idempotency Duplicate Requests

This clinic teaches same key and fingerprint returns the same transfer while conflicting duplicates are visible. It uses concrete rows for Ada, Ben, Ledger Clearing, holds, transfer attempts, ledger entries, and lifecycle events where relevant.

Run:

```bash
./scripts/bank-r2-test-one.sh 05-banking-systems-redone/003-transfers-idempotency-duplicate-requests
```

Inspect `03-seed.sql` for `idempotency key idem-rent-001 has a retry and a conflicting fingerprint attempt`, `05-verification-query.sql` for contract rows, and `07-broken-model-or-query.sql` for the shortcut that executes successfully but returns wrong rows.
