# Data Model

## Actual tables

currencies, accounts, ledger_transactions, ledger_entries, ledger_entry_metadata.

## Key columns

Use stable identifiers, currency or amount columns in cents, lifecycle state columns where needed, and explicit links between request rows, source rows, and audit/debug rows.

## Constraints

The schema uses primary keys, foreign keys, state checks, currency checks, uniqueness where the clinic needs dedupe, and append-style source rows where history matters.

## Why each table exists

The tables separate product objects, source-of-truth movement rows, lifecycle events, idempotency state, and read/debug traces so a query can explain both the answer and the rows behind it.

## Trap rows

ledger transaction 9002 is intentionally unbalanced and account 101 derives balance from ledger_entries. These rows are present so a shortcut query returns the wrong output while still executing.
