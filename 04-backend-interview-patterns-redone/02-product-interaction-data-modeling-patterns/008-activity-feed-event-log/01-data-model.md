# Data Model

## Actual tables

`users, posts, activity_events, follow_edges, block_edges, visibility_rules`.

## Trap rows

Ada sees Ben public event 8001 and Diya followers event 8003, cannot see Ben private 8002; Ben sees his own private 8002; Cy is blocked from Ben event 8001; deleted post event 8004 is hidden.

## Constraints

Lifecycle, privacy, and relationship rows must be enforced by the read query.

## Read contract

Join activity_events to actor, object liveness, visibility_rules, follow_edges, and block_edges; owner-private visibility is allowed; order by created_at desc then event_id desc.
