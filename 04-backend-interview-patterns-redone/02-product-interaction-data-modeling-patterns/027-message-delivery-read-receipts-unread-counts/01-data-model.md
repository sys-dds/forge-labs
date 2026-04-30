# Data Model

## Actual tables

`users`, `conversations`, `conversation_participants`, `messages`, `message_delivery_states`, `message_read_receipts`

## Trap rows

Message 1001 from Ada has delivery row 3001 for Ben, delivered is not read until receipt 4001, Ada does not count her own message 1003 as unread, and Cy has a different read marker from Ben.

## Constraints

Do not collapse messaging into one global messages table. Participant state, per-user read/delete settings, blocks, reports, and deterministic inbox ordering all need source rows.
