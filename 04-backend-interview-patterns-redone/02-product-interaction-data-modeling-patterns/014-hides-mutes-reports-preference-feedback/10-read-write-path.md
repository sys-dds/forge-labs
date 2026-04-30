# Read/Write Path

## Write path

Append hide, report, and feedback events; write mute_edges as current relationship state; review_queue_candidates can be derived or materialized from reports.

## Read path

Build visible feed rows for viewer 1 by excluding hide_events and mute_edges, derive review candidates from report_events, and aggregate preference feedback labels.
