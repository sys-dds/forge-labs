# Data Model

## Actual tables

accounts, transaction_events, ledger_transactions, ledger_entries, reversals.

## Key columns

Use stable identifiers, currency or amount columns in cents, lifecycle state columns where needed, and explicit links between request rows, source rows, and audit/debug rows.

## Constraints

The schema uses primary keys, foreign keys, state checks, currency checks, uniqueness where the clinic needs dedupe, and append-style source rows where history matters.

## Why each table exists

The tables separate product objects, source-of-truth movement rows, lifecycle events, idempotency state, and read/debug traces so a query can explain both the answer and the rows behind it.

## Trap rows

transaction tx-pending-1 is pending, tx-failed-1 failed, and reversal 7001 links to tx-posted-2. These rows are present so a shortcut query returns the wrong output while still executing.
