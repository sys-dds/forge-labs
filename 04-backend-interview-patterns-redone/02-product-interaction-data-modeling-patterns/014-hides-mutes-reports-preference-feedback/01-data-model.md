# Data Model

## Actual tables

`users, posts, hide_events, mute_edges, report_events, preference_feedback_events, follow_edges, review_queue_candidates`.

## Trap rows

Ada viewer 1 hides post 301, mutes Cy author 3 for post 302, reports Diya post 303 which creates review candidate 801 but does not delete it for Ben viewer 2, and records negative feedback 901 plus positive feedback 902.

## Constraints

Hide and mute are viewer-specific feed controls, report creates review evidence, and feedback is a ranking signal rather than global deletion.

## Read contract

Build visible feed rows for viewer 1 by excluding hide_events and mute_edges, derive review candidates from report_events, and aggregate preference feedback labels.
