# BANK-R2-005: Capstone Simple Bank Transfer Correctness Model

This clinic teaches account availability, balanced ledger posting, idempotency, lifecycle, reversal, and audit/debug trace all line up. It uses concrete rows for Ada, Ben, Ledger Clearing, holds, transfer attempts, ledger entries, and lifecycle events where relevant.

Run:

```bash
./scripts/bank-r2-test-one.sh 05-banking-systems-redone/005-capstone-simple-bank-transfer-correctness-model
```

Inspect `03-seed.sql` for `Ada account 101 has a hold, transfer 3001 has a duplicate retry, key idem-cap-002 conflicts, pending and failed transactions do not post, and reversal 7001 links original movement`, `05-verification-query.sql` for contract rows, and `07-broken-model-or-query.sql` for the shortcut that executes successfully but returns wrong rows.
