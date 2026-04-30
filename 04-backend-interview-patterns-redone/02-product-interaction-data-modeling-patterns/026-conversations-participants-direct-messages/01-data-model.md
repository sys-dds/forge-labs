# Data Model

## Actual tables

`users`, `conversations`, `conversation_participants`, `messages`, `block_edges`

## Trap rows

Direct conversation 101 has Ada and Ben active, group conversation 102 has Ada, Ben, and Cy, Diya is a non-participant, Ben left before message 1003, and blocked pair Ada/Cy prevents direct conversation 103.

## Constraints

Do not collapse messaging into one global messages table. Participant state, per-user read/delete settings, blocks, reports, and deterministic inbox ordering all need source rows.
