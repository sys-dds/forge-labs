# Data Model

## Actual tables

`users, posts, comments, matches, interaction_events, notifications, notification_state`.

## Trap rows

event 1001 Ben likes Ada post 201, 1002 Cy comments, 1003 Eli follows Ada, 1004 Diya matches Ada, 1005 is Ada self-like, and 1006 duplicates Ben like; notification 9001 is read.

## Constraints

Deduped notifications must have a stable unique product key, self events are suppressed, and read state is separate from notification existence.

## Read contract

Map interaction_events to recipient rules, suppress actor=recipient, dedupe notifications by recipient/actor/type/subject, and count only unread notification_state rows.
