# Feed Notification Activity Patterns

Clinics 006-008 separate three read contracts that often get blurred in interviews.

- Home feed rows come from `posts` by followed active authors, then exclude `block_edges`, `mute_edges`, deleted posts, and inactive authors.
- Notification rows come from `interaction_events`, but self-events and duplicates should not create extra unread rows.
- Activity feed rows come from `activity_events`, but privacy, blocks, and deleted objects decide whether a viewer can see them.

The named trap rows are deliberately small: Eli post 103, Ada self-like event 1005, duplicate Ben like event 1006, Ben private activity 8002, blocked Cy, and deleted post activity 8004.
