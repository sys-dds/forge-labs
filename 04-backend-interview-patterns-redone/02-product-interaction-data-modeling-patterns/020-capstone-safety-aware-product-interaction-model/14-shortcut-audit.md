# Shortcut Audit

## Likely shortcut

Use report count as the only truth, apply static removals, ignore appeals, ignore components, and return a boolean risky flag.

## How base proof catches it

The base proof checks safe post 201 remains visible, reported post 202 enters queue item 501 but treatment allow keeps it visible, confirmed post 203 gets remove treatment 703, creator 3 is downranked from component rows 1101/1102, approved appeal 901 restores post 204, rejected appeal 902 keeps post 205 removed, abuse signal 1001 has evidence rows 1201/1202, and audit rows 1301-1304 link report to decision to treatment to appeal. 

## How variant proof catches it

The variant changes reported post 202 from allow to downrank and creator 3 from downrank to review through component changes.

## What mutation should fail

Remove appeal, audit, trust component, abuse evidence, or treatment joins from the trace.

## What learner should inspect manually

Inspect `users, profiles, posts, comments, post_reactions, follow_edges, block_edges, mute_edges, report_events, report_evidence, review_queue_items, policy_decisions, policy_treatments, moderation_actions, appeals, appeal_decisions, audit_log, abuse_signal_events, abuse_signal_evidence, trust_score_components, trust_score_snapshots` and compare both expected CSV files.
