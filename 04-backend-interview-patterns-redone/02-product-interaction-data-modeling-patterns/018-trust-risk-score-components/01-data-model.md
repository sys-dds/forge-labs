# Data Model

## Actual tables

`users, posts, report_events, block_edges, mute_edges, post_reactions, comments, policy_decisions, appeals, trust_score_components, trust_score_snapshots`.

## Trap rows

creator Ben 2 has report component -30, block/mute component -20, positive engagement +15, approved appeal +10 for a total -25 and review treatment; creator Cy 3 has healthy total 20 and allow treatment.

## Constraints

Every risk treatment must be explainable through component rows; snapshots summarize components but do not replace them.

## Read contract

Aggregate trust_score_components by user, expose individual component values, compare total to treatment threshold -20, and emit debug trace labels.
