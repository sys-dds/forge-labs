# Data Model

## Actual tables

`users`, `conversations`, `conversation_participants`, `messages`, `message_edits`, `message_deletions`, `message_attachments`

## Trap rows

Message 1001 has edit rows 2001/2002 and latest body wins, message 1002 is delete-for-me for Ada only, message 1003 is delete-for-everyone, and attachment 3002 follows the hidden global message.

## Constraints

Do not collapse messaging into one global messages table. Participant state, per-user read/delete settings, blocks, reports, and deterministic inbox ordering all need source rows.
