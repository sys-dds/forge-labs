# How To Explain In Interview

## Direct answer

Model trust as named score components and a derived treatment, not as one unexplained number.

## Actual tables

Use `users, posts, report_events, block_edges, mute_edges, post_reactions, comments, policy_decisions, appeals, trust_score_components, trust_score_snapshots` in schema `bip_pim_018`.

## Actual trap rows

creator Ben 2 has report component -30, block/mute component -20, positive engagement +15, approved appeal +10 for a total -25 and review treatment; creator Cy 3 has healthy total 20 and allow treatment.

## Exact query mechanics

Aggregate trust_score_components by user, expose individual component values, compare total to treatment threshold -20, and emit debug trace labels.

## Write path

Append component rows from reports, blocks, mutes, engagement, and appeals; write snapshots after component aggregation.

## Moderation/safety follow-up

Ask which component caused review/downrank and whether an approved appeal offsets prior policy damage.

## Scaling follow-up

Snapshot storage can speed reads, but component rows are the audit layer.
