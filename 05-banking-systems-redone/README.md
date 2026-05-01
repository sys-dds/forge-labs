# Banking Systems Redone

Banking Systems Redone is a teaching track for backend correctness modeling. The first slice covers accounts, available versus actual balance, double-entry ledger rows, transfer idempotency, transaction lifecycle, reversals, and audit-friendly proof queries.

This track is deliberately small. It models source-of-truth tables, state transitions, constraints, base and variant datasets, exact CSV verification output, and broken queries that run but produce wrong answers. It does not build provider integrations, an app, a UI, a queue pipeline, or a ledger service.

## Clinics

- `001-accounts-balances-available-vs-actual`: accounts, posted balance, holds, account state.
- `002-double-entry-ledger-debits-credits`: ledger transactions, debit rows, credit rows, balanced transaction proof.
- `003-transfers-idempotency-duplicate-requests`: transfer requests, idempotency keys, duplicate suppression, conflict detection.
- `004-transaction-lifecycle-pending-posted-reversed`: pending, posted, failed, reversed events and current state from history.
- `005-capstone-simple-bank-transfer-correctness-model`: combines balances, holds, ledger entries, idempotency, lifecycle, and reversals.

## Run

```bash
./scripts/bank-r2-list.sh
./scripts/bank-r2-test-all.sh
./scripts/check-bank-r2-quality.sh
```

To study one clinic, open its `03-seed.sql`, read the trap rows, run `08-proof.sh`, then compare `05-verification-query.sql` with `07-broken-model-or-query.sql`.
