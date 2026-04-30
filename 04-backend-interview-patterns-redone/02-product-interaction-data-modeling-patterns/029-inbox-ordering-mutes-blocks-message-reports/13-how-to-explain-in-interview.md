# How To Explain In Interview

## Direct answer

Model design inbox ordering, muted conversations, blocked users, and message reports. with `users`, `conversations`, `conversation_participants`, `messages`, `message_read_receipts`, `conversation_user_settings`, `block_edges`, `message_reports`, `review_queue_items`, then prove the communication read contract from source rows rather than from a cached unread or inbox shortcut.

## Actual tables

Use `users`, `conversations`, `conversation_participants`, `messages`, `message_read_receipts`, `conversation_user_settings`, `block_edges`, `message_reports`, `review_queue_items` in schema `bip_pim_029`.

## Actual trap rows

Ada inbox includes muted conversation 101 without notification, archives conversation 103, suppresses blocked Cy message 1003, reports message 1004 into review item 8001, and tie orders conversations by conversation_id after timestamp. Ada, Ben, Cy, Diya, and message rows such as 1001, 1002, 1003, and 1004 give the concrete communication/product cases.

## Exact query mechanics

Filter per viewer settings, suppress blocked sender messages, derive unread badges from read receipts, order by latest visible timestamp with conversation_id tie-breaker, and join report queue rows.

## Write path

Write messages, read receipts, user settings, blocks, reports, and review queue rows as separate source rows for the inbox read contract.

## Communication/product follow-up

Ask which source row explains visibility, unread count, inbox order, attachment access, mute/block handling, or report review state.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached inbox or unread counters.
