# Shortcut Audit

## Likely shortcut

Treat every report or hide as global deletion and ignore viewer-specific controls.

## How base proof catches it

The base proof checks Ada viewer 1 hides post 301, mutes Cy author 3 for post 302, reports Diya post 303 which creates review candidate 801 but does not delete it for Ben viewer 2, and records negative feedback 901 plus positive feedback 902.

## How variant proof catches it

The variant removes Ada hide 701 and adds a second report, changing suppression and review counts.

## What mutation should fail

Remove the viewer filter from hide/mute controls or treat reports as deleted content.

## What learner should inspect manually

Inspect `users, posts, hide_events, mute_edges, report_events, preference_feedback_events, follow_edges, review_queue_candidates` and the base and variant expected CSV files.
