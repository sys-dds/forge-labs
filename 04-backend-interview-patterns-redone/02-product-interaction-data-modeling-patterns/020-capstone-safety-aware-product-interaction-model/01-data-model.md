# Data Model

## Actual tables

`users, profiles, posts, comments, post_reactions, follow_edges, block_edges, mute_edges, report_events, report_evidence, review_queue_items, policy_decisions, policy_treatments, moderation_actions, appeals, appeal_decisions, audit_log, abuse_signal_events, abuse_signal_evidence, trust_score_components, trust_score_snapshots`.

## Trap rows

safe post 201 remains visible, reported post 202 enters queue item 501 but treatment allow keeps it visible, confirmed post 203 gets remove treatment 703, creator 3 is downranked from component rows 1101/1102, approved appeal 901 restores post 204, rejected appeal 902 keeps post 205 removed, abuse signal 1001 has evidence rows 1201/1202, and audit rows 1301-1304 link report to decision to treatment to appeal. 

## Constraints

Reports are evidence, decisions create treatments, appeals can reverse treatments, trust/risk outputs need components, abuse signals need evidence, and audit logs preserve lineage.

## Read contract

Join reports to evidence, queue items, policy decisions, treatments, appeals, trust components, abuse evidence, and audit logs to emit safety visibility and debug contracts.
