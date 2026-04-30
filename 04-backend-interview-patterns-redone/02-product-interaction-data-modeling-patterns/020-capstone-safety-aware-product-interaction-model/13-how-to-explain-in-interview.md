# How To Explain In Interview

## Direct answer

Use `users, profiles, posts, comments, post_reactions, follow_edges, block_edges, mute_edges, report_events, report_evidence, review_queue_items, policy_decisions, policy_treatments, moderation_actions, appeals, appeal_decisions, audit_log, abuse_signal_events, abuse_signal_evidence, trust_score_components, trust_score_snapshots` to show how reports become evidence, evidence supports decisions, decisions create treatments, appeals can reverse treatments, and debug traces explain outcomes.

## Actual tables

Use `users, profiles, posts, comments, post_reactions, follow_edges, block_edges, mute_edges, report_events, report_evidence, review_queue_items, policy_decisions, policy_treatments, moderation_actions, appeals, appeal_decisions, audit_log, abuse_signal_events, abuse_signal_evidence, trust_score_components, trust_score_snapshots` in schema `bip_pim_020`.

## Actual trap rows

safe post 201 remains visible, reported post 202 enters queue item 501 but treatment allow keeps it visible, confirmed post 203 gets remove treatment 703, creator 3 is downranked from component rows 1101/1102, approved appeal 901 restores post 204, rejected appeal 902 keeps post 205 removed, abuse signal 1001 has evidence rows 1201/1202, and audit rows 1301-1304 link report to decision to treatment to appeal. 

## Exact query mechanics

Join reports to evidence, queue items, policy decisions, treatments, appeals, trust components, abuse evidence, and audit logs to emit safety visibility and debug contracts.

## Write path

Write each safety source row separately so later decisions and reversals can be audited.

## Moderation/safety follow-up

Ask whether the final treatment came from a report, a decision, an appeal, a trust component, or an abuse evidence row.

## Scaling follow-up

Materialize only after this trace remains reproducible from source rows.
