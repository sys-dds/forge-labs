# Shortcut Audit

## Likely shortcut

Return all `activity_events` as a feed.

## How base proof catches it

Base proof checks Ada sees Ben public event 8001 and Diya followers event 8003, cannot see Ben private 8002; Ben sees his own private 8002; Cy is blocked from Ben event 8001; deleted post event 8004 is hidden.

## How variant proof catches it

The variant changes Ben event 8001 to followers-only and unfollows Ada from Ben, so visibility changes without a query change.

## What mutation should fail

Remove block, private, or deleted-object filtering.

## What learner should inspect manually

Inspect `activity_events`, `visibility_rules`, `follow_edges`, `block_edges`, and both expected CSV files.
