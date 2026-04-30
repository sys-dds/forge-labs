# Shortcut Audit

## Likely shortcut

Read only post.deleted_at or the latest content flag and ignore appeals and audit history.

## How base proof catches it

The base proof checks post 201 is removed by action 601 and appeal 701 is pending, post 202 is restored by approved appeal 702 and audit row 9002, post 203 stays removed after rejected appeal 703, and moderator 10 plus operator 11 are traceable.

## How variant proof catches it

The variant approves appeal 701, restoring post 201 and changing pending_appeal_no_restore/current_treatment.

## What mutation should fail

Drop appeal_decisions or audit_log from the current treatment query.

## What learner should inspect manually

Inspect `users, posts, moderators, policy_decisions, policy_treatments, moderation_actions, appeals, appeal_decisions, audit_log` and compare the base and variant CSV contracts.
