# Correctness Notes

## Invariant being protected

debit and credit totals must balance and account balances derive from ledger entries.

## How proof catches violation

The base proof checks the ordinary path, the variant proof changes one important row, and the broken query proves a tempting shortcut gives the wrong rows.

## What must be atomic

Rows that represent one account movement, idempotency decision, or lifecycle transition must commit together.

## Intentionally not implemented yet

No provider integration, app server, queue workflow, UI, or operational ledger service is built here.
