# How To Explain In Interview

## Direct answer

Model design direct and group conversations with participants and messages. with `users`, `conversations`, `conversation_participants`, `messages`, `block_edges`, then prove the communication read contract from source rows rather than from a cached unread or inbox shortcut.

## Actual tables

Use `users`, `conversations`, `conversation_participants`, `messages`, `block_edges` in schema `bip_pim_026`.

## Actual trap rows

Direct conversation 101 has Ada and Ben active, group conversation 102 has Ada, Ben, and Cy, Diya is a non-participant, Ben left before message 1003, and blocked pair Ada/Cy prevents direct conversation 103. Ada, Ben, Cy, Diya, and message rows such as 1001, 1002, 1003, and 1004 give the concrete communication/product cases.

## Exact query mechanics

Count active participants for direct/group conversations, join messages to participants by joined/left sequence, and exclude blocked direct pairs with a conversation_visibility_trace.

## Write path

Write users, then conversations, participants with lifecycle sequence markers, block rows, and messages with sender and sequence.

## Communication/product follow-up

Ask which source row explains visibility, unread count, inbox order, attachment access, mute/block handling, or report review state.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached inbox or unread counters.
