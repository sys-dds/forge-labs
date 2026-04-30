# Data Model

## Actual tables

`users`, `conversations`, `conversation_participants`, `messages`, `message_read_receipts`, `conversation_user_settings`, `block_edges`, `message_reports`, `review_queue_items`

## Trap rows

Ada inbox includes muted conversation 101 without notification, archives conversation 103, suppresses blocked Cy message 1003, reports message 1004 into review item 8001, and tie orders conversations by conversation_id after timestamp.

## Constraints

Do not collapse messaging into one global messages table. Participant state, per-user read/delete settings, blocks, reports, and deterministic inbox ordering all need source rows.
