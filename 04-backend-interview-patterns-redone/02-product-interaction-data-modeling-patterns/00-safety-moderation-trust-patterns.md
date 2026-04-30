# Safety Moderation Trust Patterns

Safety modeling keeps evidence, decision, treatment, and debug trace rows separate.

- `report_events` and `report_evidence` describe what was reported and why.
- `review_queue_items` describe work to be reviewed.
- `policy_decisions` record the reviewed policy outcome.
- `policy_treatments` and `moderation_actions` describe what changes for product visibility or ranking.
- `trust_score_components` and `abuse_signal_evidence` explain risk outcomes with component rows, not opaque totals.

Clinics 016-020 use named rows such as report 1001, evidence 2001, appeal 702, component 6001, abuse evidence 8001, and audit row 1304.
