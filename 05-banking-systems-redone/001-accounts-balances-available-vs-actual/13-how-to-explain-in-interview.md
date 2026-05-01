# How To Explain In Interview

## Direct answer

Model the feature with `customers, accounts, posted_balance_snapshots, account_holds, account_status_events` and make the read path derive its answer from source rows, lifecycle state, and constraints.

## Actual tables

Use `customers, accounts, posted_balance_snapshots, account_holds, account_status_events`. The important point is that accounts, ledger rows, request rows, and lifecycle/audit rows are not interchangeable.

## Actual trap rows

Mention Ada account 101 has a pending hold, a released hold, an expired hold, and closed account 102 is excluded. Ada, Ben, account `101`, transfer `3001`, ledger transaction `9001`, and reversal `7001` are examples of rows that make shortcut answers fail where present.

## Exact query mechanics

The verification query builds contract rows from joins, aggregates, filtered lifecycle state, debit/credit totals, idempotency rows, and audit/debug rows.

## Write path

Insert validation/source rows first, then derived state or audit rows. Do not update a balance or status without the source rows that explain it.

## Correctness follow-up

Talk about atomic commits for one movement, unique idempotency keys, append-only ledger entries, and replayable lifecycle events.

## Scaling follow-up

Only after the model is correct, discuss snapshots, partitioning by account or date, and operational read models. The clinic stays at data modeling/query-contract level.
