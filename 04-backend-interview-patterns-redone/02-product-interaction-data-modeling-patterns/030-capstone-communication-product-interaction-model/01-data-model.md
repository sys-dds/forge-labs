# Data Model

## Actual tables

`users`, `conversations`, `conversation_participants`, `messages`, `message_delivery_states`, `message_read_receipts`, `message_edits`, `message_deletions`, `message_attachments`, `conversation_user_settings`, `block_edges`, `message_reports`, `review_queue_items`

## Trap rows

Conversation 101 has Ada and Ben active, message 1001 is delivery/read state evidence, message 1002 is edited, message 1003 is delete-for-me for Ada, attachment 3001 is visible, conversation 102 is muted, Cy is blocked, and report 7001 links message 1004 to review item 8001.

## Constraints

Do not collapse messaging into one global messages table. Participant state, per-user read/delete settings, blocks, reports, and deterministic inbox ordering all need source rows.
