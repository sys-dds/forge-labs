# Messaging Inbox Communication Patterns

Messaging product models need per-user rows. `conversation_participants` decides whether Ada, Ben, Cy, or Diya belongs in a conversation; `message_read_receipts` decides unread counts; `message_deletions` decides whether message `1003` is hidden for Ada only or everyone; and `conversation_user_settings` decides whether a muted or archived conversation appears in the default inbox.

The read contract should preserve the trace: participant lifecycle, delivery state, read marker, current edit, deletion scope, attachment visibility, mute/archive state, block suppression, message report, and review queue link.
