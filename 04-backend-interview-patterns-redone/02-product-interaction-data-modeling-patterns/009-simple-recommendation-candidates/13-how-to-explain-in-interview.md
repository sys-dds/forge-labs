# How To Explain In Interview

## Direct answer

Use `users, follow_edges, user_interests, creators, posts, swipe_events, matches, block_edges, report_events` and prove the product contract with named rows.

## Actual tables

Use `users, follow_edges, user_interests, creators, posts, swipe_events, matches, block_edges, report_events` in schema `bip_pim_009`.

## Actual trap rows

Ada should get Cy from mutual Ben, Diya from shared hiking, and Eli from a swipe signal; Fay is already followed, Gus already matched, Hana blocked, and Ivan reported.

## Exact query mechanics

Union mutual-follow, shared-interest, and right-swipe source rows, then exclude already-followed, matched, blocked, reported, inactive, and undiscoverable users while preserving source labels.

## Write path

Write source relationships/events first, then derive the read contract.

## Scaling follow-up

Materialization is a follow-up only after these correctness rules are explicit.
