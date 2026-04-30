# How To Explain In Interview

## Direct answer

Model notifications with `users, posts, comments, matches, interaction_events, notifications, notification_state` and make raw interaction events distinct from deduped notification rows.

## Actual tables

Use `users, posts, comments, matches, interaction_events, notifications, notification_state` in schema `bip_pim_007`.

## Actual trap rows

event 1001 Ben likes Ada post 201, 1002 Cy comments, 1003 Eli follows Ada, 1004 Diya matches Ada, 1005 is Ada self-like, and 1006 duplicates Ben like; notification 9001 is read.

## Exact query mechanics

Map interaction_events to recipient rules, suppress actor=recipient, dedupe notifications by recipient/actor/type/subject, and count only unread notification_state rows.

## Write path

Source interaction first, event second, notification upsert third, state update last.

## Scaling follow-up

Unread counters can be cached as long as self suppression and dedupe stay correct.
