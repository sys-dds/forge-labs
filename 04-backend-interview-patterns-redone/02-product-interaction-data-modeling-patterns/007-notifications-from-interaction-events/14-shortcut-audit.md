# Shortcut Audit

## Likely shortcut

Return one row for every `interaction_events` row.

## How base proof catches it

Base proof checks event 1001 Ben likes Ada post 201, 1002 Cy comments, 1003 Eli follows Ada, 1004 Diya matches Ada, 1005 is Ada self-like, and 1006 duplicates Ben like; notification 9001 is read.

## How variant proof catches it

The variant adds a new Cy like notification and changes unread grouping/counts while the query stays the same.

## What mutation should fail

Remove self suppression, dedupe, or read-state filtering.

## What learner should inspect manually

Inspect `interaction_events`, `notifications`, `notification_state`, and both expected CSV files.
