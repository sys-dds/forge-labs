# How To Explain In Interview

## Direct answer

Model design message edits, deletes, attachments, and visibility lifecycle. with `users`, `conversations`, `conversation_participants`, `messages`, `message_edits`, `message_deletions`, `message_attachments`, then prove the communication read contract from source rows rather than from a cached unread or inbox shortcut.

## Actual tables

Use `users`, `conversations`, `conversation_participants`, `messages`, `message_edits`, `message_deletions`, `message_attachments` in schema `bip_pim_028`.

## Actual trap rows

Message 1001 has edit rows 2001/2002 and latest body wins, message 1002 is delete-for-me for Ada only, message 1003 is delete-for-everyone, and attachment 3002 follows the hidden global message. Ada, Ben, Cy, Diya, and message rows such as 1001, 1002, 1003, and 1004 give the concrete communication/product cases.

## Exact query mechanics

Resolve current body from latest edit, keep edit history, apply viewer-specific and global deletion rows, then join attachment visibility to message visibility.

## Write path

Write messages first, append edit history rows, append deletion rows with scope, and attach files to message source rows.

## Communication/product follow-up

Ask which source row explains visibility, unread count, inbox order, attachment access, mute/block handling, or report review state.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached inbox or unread counters.
