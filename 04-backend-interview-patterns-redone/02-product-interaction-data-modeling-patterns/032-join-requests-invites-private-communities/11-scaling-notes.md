# Scaling Notes

Stay small in the interview: index foreign keys, keep lifecycle rows explicit, and make the read contract deterministic.

- Index request state by community_id and requester_user_id.
- Use unique accepted invite tokens.
- Keep audit append-only so approvals can be explained.

Avoid jumping to infrastructure or realtime platform concerns for this clinic.
