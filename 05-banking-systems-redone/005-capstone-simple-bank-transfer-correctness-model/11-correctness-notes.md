# Correctness Notes

## Invariant being protected

account availability, balanced ledger posting, idempotency, lifecycle, reversal, and audit/debug trace all line up.

## How proof catches violation

The base proof checks the ordinary path, the variant proof changes one important row, and the broken query proves a tempting shortcut gives the wrong rows.

## What must be atomic

Rows that represent one account movement, idempotency decision, or lifecycle transition must commit together.

## Intentionally not implemented yet

No provider integration, app server, queue workflow, UI, or operational ledger service is built here.
