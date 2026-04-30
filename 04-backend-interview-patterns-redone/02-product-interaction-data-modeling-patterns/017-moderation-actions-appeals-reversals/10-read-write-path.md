# Read/Write Path

## Write path

Write policy decision and treatment, apply moderation_actions, append appeals and appeal_decisions, then append audit_log rows for action and reversal lineage.

## Read path

Read current treatment from moderation_actions, join appeals and appeal_decisions for pending/approved/rejected state, and join audit_log for reversal lineage.
