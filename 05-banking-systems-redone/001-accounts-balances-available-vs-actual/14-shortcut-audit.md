# Shortcut Audit

## Likely shortcut

Use one mutable field or one raw joined row and ignore `Ada account 101 has a pending hold, a released hold, an expired hold, and closed account 102 is excluded`.

## How base proof catches it

The base proof includes trap rows that make the shortcut return a different contract result.

## How variant proof catches it

The variant proof catches shortcuts by changing one row that should alter the derived output while leaving the same verification query in place.

## What mutation should fail

A mutation should fail when it removes state filtering, removes debit/credit equality, ignores idempotency fingerprinting, or counts failed/reversed rows as posted movement.

## What learner should inspect manually

Inspect `03-seed.sql`, `03b-seed-variant.sql`, and `07-broken-model-or-query.sql` to see exactly why the wrong query still executes.
