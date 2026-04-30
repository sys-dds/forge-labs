# How To Explain In Interview

## Direct answer

Model user controls as viewer-specific source rows and reports as review evidence, not automatic deletion.

## Actual tables

Use `users, posts, hide_events, mute_edges, report_events, preference_feedback_events, follow_edges, review_queue_candidates` in schema `bip_pim_014`.

## Actual trap rows

Ada viewer 1 hides post 301, mutes Cy author 3 for post 302, reports Diya post 303 which creates review candidate 801 but does not delete it for Ben viewer 2, and records negative feedback 901 plus positive feedback 902.

## Exact query mechanics

Build visible feed rows for viewer 1 by excluding hide_events and mute_edges, derive review candidates from report_events, and aggregate preference feedback labels.

## Write path

Append hide, report, and feedback events; write mute_edges as current relationship state; review_queue_candidates can be derived or materialized from reports.

## Scaling follow-up

Suppression and review queues can be materialized, but reports and controls must remain auditable source rows.
