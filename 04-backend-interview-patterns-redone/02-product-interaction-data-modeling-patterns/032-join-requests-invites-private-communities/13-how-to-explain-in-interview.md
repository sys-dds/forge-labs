# How To Explain In Interview

## Direct answer

Use private communities, explicit request/invite state machines, active membership rows, bans, and an audit table linking decisions to request or invite rows.

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_join_requests`
- `community_invites`
- `community_bans`
- `community_request_audit`

## Actual trap rows

- Ada user 1 has pending request 2001 and no membership.
- Ben user 2 has approved request 2002 linked to membership 3002.
- Cy user 3 has rejected request 2003.
- Diya user 4 has expired invite 4004.
- Eli user 5 is banned by ban 5005 but still has invite 4005.

## Exact query mechanics

The query derives active_access from community_memberships, valid_accepted_invites from invite state and expiry, and audit_trace from community_request_audit before emitting pending_request_not_member and private_access_contract.

## Write path

Insert request rows as pending, approved, or rejected. When approving request 2002, write membership 3002 and audit row 6002. When accepting valid invite 4006, write active membership 3006 and audit row 6006. Write ban 5005 before checking Eli invite 4005.

## Community/product follow-up

A product can show pending, rejected, invited, and member states separately without confusing them.

## Scaling follow-up

Move token lookup or request queues later; the interview model only needs state, constraints, and traceability.
