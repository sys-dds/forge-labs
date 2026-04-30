# Read Write Path

## Write path

Write conversation and participant source rows first, then append messages, delivery/read rows, edits/deletions, attachments, settings, block edges, reports, and review queue rows.

## Read path

Read by joining conversation, participant, message lifecycle, per-user state, and communication debug trace rows.
