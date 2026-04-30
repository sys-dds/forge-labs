# Design

## What this clinic teaches

Timeline and notification tables are read models derived from posts and events; they still need safety filters, dedupe keys, and read-state handling.

## Named rows and why each exists

- Row: Ben post 101 in Ada timeline.
  Why it exists: proves valid fanout survives.
  Query/proof that uses it: `ada_home_timeline`.
  Wrong behavior if removed: no valid timeline row remains.
- Row: Cy post 201 in Ada timeline.
  Why it exists: proves muted author fanout must be filtered.
  Query/proof that uses it: timeline exclusion assertion.
  Wrong behavior if removed: mute read-time safety is untested.
- Row: Noor post 301 in Ada timeline.
  Why it exists: proves blocked author fanout must be filtered.
  Query/proof that uses it: timeline exclusion assertion.
  Wrong behavior if removed: block read-time safety is untested.
- Row: Ben comment notification `evt-ben-comment`.
  Why it exists: proves comment notification survives unread.
  Query/proof that uses it: inbox and unread count.
  Wrong behavior if removed: comment notification path is untested.
- Row: Diya like notification `evt-diya-like`.
  Why it exists: proves like notification survives unread.
  Query/proof that uses it: inbox and unread count.
  Wrong behavior if removed: like notification path is untested.
- Row: Maya mention notification `evt-maya-mention`.
  Why it exists: proves mention notification and read update.
  Query/proof that uses it: before/after unread count.
  Wrong behavior if removed: read-marker proof is impossible.
- Row: duplicate Maya mention with same source_event_id.
  Why it exists: proves source_event_id dedupe.
  Query/proof that uses it: duplicate dedupe assertion.
  Wrong behavior if removed: notification dedupe is untested.
- Row: Lina old read notification.
  Why it exists: proves read rows stay in inbox but not unread count.
  Query/proof that uses it: unread count assertion.
  Wrong behavior if removed: read filtering is untested.

## Broken query bug

The broken views read precomputed rows without safety filters, count read notifications as unread, and do not dedupe duplicate source events.

## Exact wrong result from the broken query

Ada timeline includes Cy 201 and Noor 301; inbox contains Maya mention twice; unread count is 5 instead of 3 before reading Maya and 2 after.

## Correct result from the solution

Ada timeline returns Ben 101 only; inbox has Ben comment, Diya like, one Maya mention, and Lina's read old notification; unread count becomes 2 after Ada reads Maya mention.

## Proof assertions

The proof checks exact timeline, Cy/Noor exclusions, deduped inbox rows, one Maya mention, Lina not unread, unread count 3 before update, and unread count 2 after update.

## What the learner should notice

Read models can be fast and still stale; read-time filters and dedupe keys protect correctness.

## Interview explanation target

Explain fanout-on-write, fanout-on-read, hybrid timelines, notification inboxes, unread counts, stale read-model trade-offs, and why this prepares for later infrastructure paths without implementing them.

