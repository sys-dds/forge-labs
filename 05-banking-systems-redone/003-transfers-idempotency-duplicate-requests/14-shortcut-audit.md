# Shortcut Audit

## Likely shortcut

Use one mutable field or one raw joined row and ignore `idempotency key idem-rent-001 has a retry and a conflicting fingerprint attempt`.

## How base proof catches it

The base proof includes trap rows that make the shortcut return a different contract result.

## How variant proof catches it

The variant proof catches shortcuts by changing one row that should alter the derived output while leaving the same verification query in place.

## What mutation should fail

A mutation should fail when it removes state filtering, removes debit/credit equality, ignores idempotency fingerprinting, or counts failed/reversed rows as posted movement.

## What learner should inspect manually

Inspect `03-seed.sql`, `03b-seed-variant.sql`, and `07-broken-model-or-query.sql` to see exactly why the wrong query still executes.
