# How To Explain In Interview

## Direct answer

Model design a small communication product model combining conversations, participants, messages, delivery, read receipts, edits/deletes, attachments, inbox ordering, mutes, blocks, and reports. with `users`, `conversations`, `conversation_participants`, `messages`, `message_delivery_states`, `message_read_receipts`, `message_edits`, `message_deletions`, `message_attachments`, `conversation_user_settings`, `block_edges`, `message_reports`, `review_queue_items`, then prove the communication read contract from source rows rather than from a cached unread or inbox shortcut.

## Actual tables

Use `users`, `conversations`, `conversation_participants`, `messages`, `message_delivery_states`, `message_read_receipts`, `message_edits`, `message_deletions`, `message_attachments`, `conversation_user_settings`, `block_edges`, `message_reports`, `review_queue_items` in schema `bip_pim_030`.

## Actual trap rows

Conversation 101 has Ada and Ben active, message 1001 is delivery/read state evidence, message 1002 is edited, message 1003 is delete-for-me for Ada, attachment 3001 is visible, conversation 102 is muted, Cy is blocked, and report 7001 links message 1004 to review item 8001. Ada, Ben, Cy, Diya, and message rows such as 1001, 1002, 1003, and 1004 give the concrete communication/product cases.

## Exact query mechanics

Compose participant membership, visible messages, latest edit, per-user deletion, delivery/read rows, unread count, inbox settings, block suppression, and report review rows into one communication_debug_trace_contract.

## Write path

Write conversation and participant source rows first, then append messages, delivery/read rows, edits/deletions, attachments, settings, block edges, reports, and review queue rows.

## Communication/product follow-up

Ask which source row explains visibility, unread count, inbox order, attachment access, mute/block handling, or report review state.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached inbox or unread counters.
