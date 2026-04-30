# Read/Write Path

## Write path

- Insert request rows as pending, approved, or rejected.
- When approving request 2002, write membership 3002 and audit row 6002.
- When accepting valid invite 4006, write active membership 3006 and audit row 6006.
- Write ban 5005 before checking Eli invite 4005.

## Read path

- Grant private access only from active community_memberships.
- Check invite state and expiry before considering membership creation.
- Join community_request_audit to request or invite rows for decision trace.
- Suppress banned users before access is returned.

The verification query is intentionally a read contract over stored rows.
