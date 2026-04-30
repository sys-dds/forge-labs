# Shortcut Audit

## Likely shortcut

Output one static trust score and one risky flag with no components.

## How base proof catches it

The base proof checks creator Ben 2 has report component -30, block/mute component -20, positive engagement +15, approved appeal +10 for a total -25 and review treatment; creator Cy 3 has healthy total 20 and allow treatment.

## How variant proof catches it

The variant adds positive engagement for Ben, changing component_total and risk_treatment from review to allow.

## What mutation should fail

Remove component aggregation or emit only snapshot total.

## What learner should inspect manually

Inspect `users, posts, report_events, block_edges, mute_edges, post_reactions, comments, policy_decisions, appeals, trust_score_components, trust_score_snapshots` and the expected CSV files.
