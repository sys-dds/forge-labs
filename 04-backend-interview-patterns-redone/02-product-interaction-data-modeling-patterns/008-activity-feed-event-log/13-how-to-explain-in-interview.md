# How To Explain In Interview

## Direct answer

Model user-visible activity with `users, posts, activity_events, follow_edges, block_edges, visibility_rules` and filter it by privacy and relationships.

## Actual tables

Use `users, posts, activity_events, follow_edges, block_edges, visibility_rules` in schema `bip_pim_008`.

## Actual trap rows

Ada sees Ben public event 8001 and Diya followers event 8003, cannot see Ben private 8002; Ben sees his own private 8002; Cy is blocked from Ben event 8001; deleted post event 8004 is hidden.

## Exact query mechanics

Join activity_events to actor, object liveness, visibility_rules, follow_edges, and block_edges; owner-private visibility is allowed; order by created_at desc then event_id desc.

## Write path

Write source object, append activity event, then query with visibility rules.

## Scaling follow-up

A cache is allowed only if it preserves these visibility checks.
