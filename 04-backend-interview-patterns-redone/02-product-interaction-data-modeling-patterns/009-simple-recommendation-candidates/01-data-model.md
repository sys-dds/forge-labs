# Data Model

## Actual tables

`users, follow_edges, user_interests, creators, posts, swipe_events, matches, block_edges, report_events`.

## Trap rows

Ada should get Cy from mutual Ben, Diya from shared hiking, and Eli from a swipe signal; Fay is already followed, Gus already matched, Hana blocked, and Ivan reported.

## Constraints

The verification query must derive product-visible rows from relationships, lifecycle state, and event tables.

## Read contract

Union mutual-follow, shared-interest, and right-swipe source rows, then exclude already-followed, matched, blocked, reported, inactive, and undiscoverable users while preserving source labels.
