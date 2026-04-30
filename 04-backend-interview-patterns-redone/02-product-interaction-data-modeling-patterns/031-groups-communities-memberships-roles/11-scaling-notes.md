# Scaling Notes

Stay small in the interview: index foreign keys, keep lifecycle rows explicit, and make the read contract deterministic.

- Keep role permission checks local to community_id.
- Index community_memberships(community_id,user_id,member_state).
- Index community_role_assignments(community_id,user_id).

Avoid jumping to infrastructure or realtime platform concerns for this clinic.
