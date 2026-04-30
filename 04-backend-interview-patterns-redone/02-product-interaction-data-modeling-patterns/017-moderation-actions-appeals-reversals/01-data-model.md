# Data Model

## Actual tables

`users, posts, moderators, policy_decisions, policy_treatments, moderation_actions, appeals, appeal_decisions, audit_log`.

## Trap rows

post 201 is removed by action 601 and appeal 701 is pending, post 202 is restored by approved appeal 702 and audit row 9002, post 203 stays removed after rejected appeal 703, and moderator 10 plus operator 11 are traceable.

## Constraints

Moderation actions are reversible treatments; appeals create new decisions; audit_log preserves actor lineage and previous/current treatment.

## Read contract

Read current treatment from moderation_actions, join appeals and appeal_decisions for pending/approved/rejected state, and join audit_log for reversal lineage.
