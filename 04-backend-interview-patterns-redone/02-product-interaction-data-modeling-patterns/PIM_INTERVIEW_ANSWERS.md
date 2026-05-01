# PIM Interview Answers

Use these as short answer templates. In an interview, lead with the direct model, then name the read path, write path, mistake, and scaling follow-up.

## How Do You Model Follow Vs Friendship?

Direct answer: follows are directed edges; friendships are accepted symmetric relationships created after a request lifecycle.

Tables: `follow_edges`, `block_edges`, `friend_requests`, `friendships`, `users`.

Query/read path: for follows, read active directed edges and suppress blocks; for friendships, read accepted friendship rows in either direction.

Write path: write follow/unfollow state for follows; write request, accept/reject, then friendship for friends.

Common mistake: treating a follow as a friendship or pending request as accepted.

Scaling follow-up: index both directions and materialize counts after source truth is correct.

Clinics: `002`, `003`.

## How Do You Model Likes/Comments Without Double Counting?

Direct answer: store reaction/comment rows with lifecycle state and count only active source rows.

Tables: `post_reactions`, `comments`, `posts`, `users`.

Query/read path: filter inactive reactions, deleted comments, and reply parent state before counts.

Write path: insert or update reaction state; soft-delete comments instead of erasing history.

Common mistake: counting history rows instead of latest active state.

Scaling follow-up: cache counts in read models and run drift checks.

Clinics: `004`, `011`.

## How Do You Model Swipes And Matches?

Direct answer: store swipe events, then create a match only when both users have compatible right-swipe state and no block/report suppression.

Tables: `swipe_events`, `matches`, `block_edges`, `report_events`, `user_profiles`.

Query/read path: find latest valid swipes, exclude blocked or reported pairs, derive match contract.

Write path: insert swipe event; on right swipe, check reciprocal right swipe and write match.

Common mistake: one right swipe creates a match.

Scaling follow-up: add pair indexes and dedupe match creation.

Clinics: `005`.

## How Do You Model A Home Feed From Follows?

Direct answer: start with active follow edges, then join posts and suppress blocks, mutes, deleted posts, and seen rows.

Tables: `follow_edges`, `posts`, `block_edges`, `mute_edges`, `feed_seen_events`.

Query/read path: viewer follows author, author not blocked/muted, post active, stable ordering.

Write path: write follows, posts, mutes, blocks, and seen events separately.

Common mistake: global recent posts.

Scaling follow-up: materialize a feed read model later, keeping source filters testable.

Clinics: `006`, `010`.

## How Do You Model Notifications And Unread Counts?

Direct answer: derive notification rows from interaction events, dedupe self-events and duplicate causes, and store per-user read state.

Tables: `interaction_events`, `notifications`, `notification_state`.

Query/read path: visible recipient notifications minus read marker.

Write path: write interaction event, create notification if eligible, update read state when opened.

Common mistake: notifying a user about their own action.

Scaling follow-up: precompute notification rows, not eligibility rules hidden in app code.

Clinics: `007`, `011`.

## How Do You Model Read Models And Drift?

Direct answer: source tables are truth; read models are derived rows that need verification against source recomputation.

Tables: `post_count_read_models`, `user_count_read_models`, `notification_count_read_models`, source interaction tables.

Query/read path: compare read-model counts with source-derived counts and emit drift rows.

Write path: update source row first, then update read model asynchronously or transactionally depending on need.

Common mistake: trusting cached counts blindly.

Scaling follow-up: schedule drift checks and repair jobs.

Clinics: `011`, `015`.

## How Do You Model Visibility And Blocks?

Direct answer: visibility is a read contract combining object state, audience rows, viewer controls, blocks, mutes, and product-specific membership.

Tables: `block_edges`, `audience_groups`, `audience_group_members`, `hide_events`, `mute_edges`, visibility fields.

Query/read path: start from candidate rows, then apply viewer-specific suppression.

Write path: write block/hide/mute/audience membership rows separately from the content.

Common mistake: one global hidden flag.

Scaling follow-up: cache eligibility only after the rule is explicit.

Clinics: `001`, `012`, `014`, `015`.

## How Do You Model Reports, Moderation, Appeals, And Audit Logs?

Direct answer: reports create evidence, review queues organize work, policy decisions choose treatment, appeals can reverse decisions, and audit rows explain actors and times.

Tables: `report_events`, `report_evidence`, `review_queue_items`, `policy_decisions`, `policy_treatments`, `appeals`, `audit_log`.

Query/read path: join evidence to decision to treatment and audit trace.

Write path: report, evidence, queue item, decision, treatment, appeal, reversal.

Common mistake: report count equals decision.

Scaling follow-up: keep decision lineage inspectable even when queues are optimized.

Clinics: `016`, `017`, `019`, `020`.

## How Do You Model Trust/Risk Without An Opaque Score?

Direct answer: store component rows with reasons and weights, then snapshot the aggregate separately.

Tables: `trust_score_components`, `trust_score_snapshots`, `abuse_signal_events`, `policy_treatments`.

Query/read path: sum or inspect component rows and show treatment trace.

Write path: write component updates from evidence, then write snapshot.

Common mistake: a single risk score with no explanation.

Scaling follow-up: snapshot for speed, components for correctness and review.

Clinics: `018`, `020`.

## How Do You Model Marketplace Buyer Intent And Seller Quality?

Direct answer: model buyer intent, listing attributes, availability, seller quality components, offers/bookings, and risk treatments as separate rows.

Tables: `buyer_intents`, `listings`, `listing_tags`, `seller_quality_components`, `offers`, `bookings`, `marketplace_treatments`.

Query/read path: match intent to listing, check seller quality and availability, then apply treatment.

Write path: update intent, listing, offer, booking, quality component, and supply/demand rows.

Common mistake: popularity-only ranking.

Scaling follow-up: precompute candidate rows but keep why-shown fields.

Clinics: `021-025`.

## How Do You Model Messaging Read Receipts?

Direct answer: store messages with sequence, delivery per recipient, read receipt per participant, and per-user delete/settings rows.

Tables: `messages`, `message_delivery_states`, `message_read_receipts`, `message_deletions`, `conversation_user_settings`.

Query/read path: unread = visible messages from others with `message_seq` greater than latest read.

Write path: send message, write delivery state, update read receipt on view, write per-user delete or settings rows.

Common mistake: one global unread count or delete flag.

Scaling follow-up: store per-conversation read markers and stable inbox ordering.

Clinics: `026-030`.

## How Do You Model Communities And Roles?

Direct answer: membership state controls access; role assignments plus permission rows control actions; joins, invites, bans, channels, events, and audit rows explain lifecycle.

Tables: `community_memberships`, `community_roles`, `community_role_assignments`, `community_permissions`, `community_join_requests`, `community_invites`, `community_bans`.

Query/read path: require active non-banned membership, then resolve permissions or channel/event visibility.

Write path: write membership, role assignment, request/invite decision, moderation action, RSVP, waitlist, attendance, and audit rows.

Common mistake: one admin boolean or invite equals membership.

Scaling follow-up: materialize permission summaries while preserving source rows.

Clinics: `031-035`.

## How Do You Model Search, Topics, Trending, And Collections?

Direct answer: normalize hashtags into topics, store query/filter/facet/saved-search rows, explain trends with component rows and safety treatments, and model collections with owner, visibility, members, and ordered item lifecycle.

Tables: `topics`, `hashtags`, `content_topic_links`, `search_queries`, `search_filters`, `search_facets`, `saved_searches`, `trend_signal_components`, `collections`, `collection_items`.

Query/read path: followed topic or filtered query produces candidates; facets derive from visible results; trends sum components; collections apply owner/member/public visibility and item state.

Write path: write topic links, query rows, saved searches, signal components, treatments, collection members, and collection items.

Common mistake: raw text only, one opaque trend score, or one bookmark flag.

Scaling follow-up: cache search/discovery reads later, keeping debug traces from source rows.

Clinics: `036-040`.
