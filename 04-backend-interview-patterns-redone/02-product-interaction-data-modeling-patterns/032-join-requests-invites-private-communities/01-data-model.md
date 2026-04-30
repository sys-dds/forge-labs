# Data Model

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_join_requests`
- `community_invites`
- `community_bans`
- `community_request_audit`

## Constraints

- Pending and rejected join requests never grant membership.
- Approved requests link to active membership rows.
- Invites require accepted state and unexpired expires_at before membership is granted.
- Bans suppress joins even when a request or invite exists.
- Audit rows link request or invite decisions to an actor.

## Trap rows

- Ada user 1 has pending request 2001 and no membership.
- Ben user 2 has approved request 2002 linked to membership 3002.
- Cy user 3 has rejected request 2003.
- Diya user 4 has expired invite 4004.
- Eli user 5 is banned by ban 5005 but still has invite 4005.

## Why this shape

Private access is a result of accepted membership, not the existence of a request or invite. The audit table explains who approved or rejected the transition.
