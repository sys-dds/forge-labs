# Shortcut Audit

## Likely shortcut

Read only `messages`, count all messages as unread, or order conversations by a global max timestamp.

## How base proof catches it

The base proof checks named trap rows from `users`, `conversations`, `conversation_participants`, `messages` and requires per-user lifecycle evidence.

## How variant proof catches it

The variant proof catches it by changing a participant, read marker, delete visibility, inbox setting, or report row while reusing the same verification query.

## What mutation should fail

A mutation that removes the per-user state, participant lifecycle, deterministic tie-breaker, or debug trace should change the expected CSV and fail.

## What learner should inspect manually

Inspect participants, messages, per-user read/delete rows, settings, blocks, reports, and the debug trace before trusting the final communication read model.
