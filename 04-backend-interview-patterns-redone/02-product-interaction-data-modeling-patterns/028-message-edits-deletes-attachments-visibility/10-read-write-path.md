# Read Write Path

## Write path

Write messages first, append edit history rows, append deletion rows with scope, and attach files to message source rows.

## Read path

Read by joining conversation, participant, message lifecycle, per-user state, and communication debug trace rows.
