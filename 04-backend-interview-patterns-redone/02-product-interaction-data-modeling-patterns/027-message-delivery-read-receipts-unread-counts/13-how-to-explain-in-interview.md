# How To Explain In Interview

## Direct answer

Model design message delivery states, read receipts, and unread counts. with `users`, `conversations`, `conversation_participants`, `messages`, `message_delivery_states`, `message_read_receipts`, then prove the communication read contract from source rows rather than from a cached unread or inbox shortcut.

## Actual tables

Use `users`, `conversations`, `conversation_participants`, `messages`, `message_delivery_states`, `message_read_receipts` in schema `bip_pim_027`.

## Actual trap rows

Message 1001 from Ada has delivery row 3001 for Ben, delivered is not read until receipt 4001, Ada does not count her own message 1003 as unread, and Cy has a different read marker from Ben. Ada, Ben, Cy, Diya, and message rows such as 1001, 1002, 1003, and 1004 give the concrete communication/product cases.

## Exact query mechanics

Join messages to participant recipients, compare message_seq to per-user latest_read_seq, exclude sender-owned messages, and emit a read_state_debug_trace.

## Write path

Write participant rows, message rows, delivery rows per recipient, and read receipt markers per conversation participant.

## Communication/product follow-up

Ask which source row explains visibility, unread count, inbox order, attachment access, mute/block handling, or report review state.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached inbox or unread counters.
