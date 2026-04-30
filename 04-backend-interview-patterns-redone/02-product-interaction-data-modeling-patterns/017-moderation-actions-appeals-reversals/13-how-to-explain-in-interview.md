# How To Explain In Interview

## Direct answer

Model deletion-like outcomes as reversible moderation treatments with appeals and audit rows, not as only post.deleted_at.

## Actual tables

Use `users, posts, moderators, policy_decisions, policy_treatments, moderation_actions, appeals, appeal_decisions, audit_log` in schema `bip_pim_017`.

## Actual trap rows

post 201 is removed by action 601 and appeal 701 is pending, post 202 is restored by approved appeal 702 and audit row 9002, post 203 stays removed after rejected appeal 703, and moderator 10 plus operator 11 are traceable.

## Exact query mechanics

Read current treatment from moderation_actions, join appeals and appeal_decisions for pending/approved/rejected state, and join audit_log for reversal lineage.

## Write path

Write policy decision and treatment, apply moderation_actions, append appeals and appeal_decisions, then append audit_log rows for action and reversal lineage.

## Moderation/safety follow-up

Ask whether the current treatment is hide/remove/restore and which actor produced the latest audit row.

## Scaling follow-up

Action history may be indexed or cached, but the appeal and audit lineage stays authoritative.
