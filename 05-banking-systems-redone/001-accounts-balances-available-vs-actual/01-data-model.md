# Data Model

## Actual tables

customers, accounts, posted_balance_snapshots, account_holds, account_status_events.

## Key columns

Use stable identifiers, currency or amount columns in cents, lifecycle state columns where needed, and explicit links between request rows, source rows, and audit/debug rows.

## Constraints

The schema uses primary keys, foreign keys, state checks, currency checks, uniqueness where the clinic needs dedupe, and append-style source rows where history matters.

## Why each table exists

The tables separate product objects, source-of-truth movement rows, lifecycle events, idempotency state, and read/debug traces so a query can explain both the answer and the rows behind it.

## Trap rows

Ada account 101 has a pending hold, a released hold, an expired hold, and closed account 102 is excluded. These rows are present so a shortcut query returns the wrong output while still executing.
