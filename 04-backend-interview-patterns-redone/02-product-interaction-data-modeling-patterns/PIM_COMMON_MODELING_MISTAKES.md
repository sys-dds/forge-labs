# PIM Common Modeling Mistakes

## One Boolean Instead Of Lifecycle State

Why wrong: product rows usually move through states such as pending, active, removed, banned, declined, waitlisted, paused, or deleted.

Bug caused: old or pending rows grant access or get counted as live.

Correct model: use explicit state columns and filter active states in the read contract.

Clinic references: `003`, `011`, `031-040`.

## Follows As Friendships

Why wrong: follows are directed; friendships require accepted mutual relationship state.

Bug caused: one user following another exposes friend-only behavior.

Correct model: separate `follow_edges`, `friend_requests`, and `friendships`.

Clinic references: `002`, `003`.

## Counting History Rows Instead Of Latest State

Why wrong: history includes undone reactions, deleted comments, old read states, and stale lifecycle rows.

Bug caused: inflated counts and wrong unread or engagement values.

Correct model: count active source rows or latest state rows only.

Clinic references: `004`, `011`, `027`.

## Ignoring Deleted/Blocked/Hidden Rows

Why wrong: product visibility depends on object state and viewer suppression.

Bug caused: users see deleted posts, blocked authors, hidden listings, or removed community content.

Correct model: include object state, block edges, hide events, memberships, and treatment rows in the read path.

Clinic references: `001`, `006`, `014`, `028-040`.

## Trusting Counters As Truth

Why wrong: read models can drift from source writes.

Bug caused: stale follower, reaction, notification, or unread counts.

Correct model: keep source tables and run drift detection.

Clinic references: `011`, `015`.

## Global Unread Count

Why wrong: unread is per user, per conversation, based on visible messages and read receipts.

Bug caused: one participant reading changes another participant's unread state.

Correct model: `message_read_receipts` with per-user latest read sequence.

Clinic references: `027`, `029`, `030`.

## Report Count As Moderation Decision

Why wrong: reports are evidence, not a policy decision.

Bug caused: content is removed without review, treatment, appeal, or audit lineage.

Correct model: reports feed evidence, queue, decision, treatment, appeal, and audit rows.

Clinic references: `016`, `017`, `020`.

## Opaque Trust Score

Why wrong: reviewers and product teams need to inspect why a user, seller, topic, or item is risky.

Bug caused: unexplained suppressions and impossible debugging.

Correct model: component rows plus snapshots.

Clinic references: `018`, `023`, `025`, `038`, `040`.

## Marketplace Popularity-Only Ranking

Why wrong: marketplace relevance depends on buyer intent, availability, seller quality, offers/bookings, and risk.

Bug caused: popular but irrelevant or risky listings win.

Correct model: model intent, listing fit, quality components, supply/demand, lifecycle, and treatments.

Clinic references: `021-025`.

## Search As Only Raw Text Match

Why wrong: product search also needs query rows, filters, facets, saved state, visibility, and safety suppression.

Bug caused: wrong facets, unsafe results, and saved searches that cannot be explained.

Correct model: `search_queries`, `search_filters`, `search_facets`, `saved_searches`, treatments, and blocks.

Clinic references: `037`, `040`.

## Roles As One Admin Boolean

Why wrong: community actions differ by owner, admin, moderator, and member.

Bug caused: moderators can transfer ownership or members can moderate.

Correct model: role rows, role assignments, permission rows, and active membership.

Clinic references: `031`, `035`.

## Collections As One Bookmark Flag

Why wrong: collections have owner, visibility, members, ordering, duplicate attempts, item lifecycle, and saved item state.

Bug caused: private folders leak, item order changes, or duplicates appear.

Correct model: `collections`, `collection_members`, `collection_items`, and `saved_items`.

Clinic references: `039`, `040`.

## Message Delete As One Global Deleted Flag

Why wrong: messages may be deleted for one viewer or for everyone.

Bug caused: one user's delete hides the message from all users.

Correct model: `message_deletions` with delete scope and viewer.

Clinic references: `028`, `030`.

## Ignoring Variant Datasets

Why wrong: a query can memorize base rows and still pass a shallow check.

Bug caused: brittle answers that fail when one role, treatment, filter, or lifecycle row changes.

Correct model: run the same verification query against base and variant seeds.

Clinic references: all `001-040`.
