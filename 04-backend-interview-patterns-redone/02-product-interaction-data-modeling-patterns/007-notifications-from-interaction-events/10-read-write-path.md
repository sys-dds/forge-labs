# Read/Write Path

## Write path

Write product interactions to their source tables, append `interaction_events`, then create or update deduped `notifications` and `notification_state`.

## Read path

Map interaction_events to recipient rules, suppress actor=recipient, dedupe notifications by recipient/actor/type/subject, and count only unread notification_state rows.
