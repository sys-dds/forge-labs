# Read/Write Path

## Write path

Append `activity_events` after the product write and keep object/audience references.

## Read path

Join activity_events to actor, object liveness, visibility_rules, follow_edges, and block_edges; owner-private visibility is allowed; order by created_at desc then event_id desc.
