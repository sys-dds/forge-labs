# PIM Cheatsheet

## Objects

Mental model: durable things users interact with.

Table shape: `users`, `profiles`, `posts`, `listings`, `communities`, `topics`, `collections`.

Common trap: placing lifecycle or viewer state directly on the object when it belongs in a relationship or event table.

Clinic references: `001`, `004`, `021-025`, `031-040`.

## Relationships

Mental model: edges between people, objects, or product surfaces.

Table shape: `follow_edges`, `friendships`, `content_topic_links`, `creator_topic_links`, `collection_members`.

Common trap: assuming every edge is symmetric or active forever.

Clinic references: `002`, `003`, `009`, `036`, `039`.

## Events

Mental model: append-only history of something that happened.

Table shape: `swipe_events`, `interaction_events`, `activity_events`, `report_events`, `abuse_signal_events`.

Common trap: exposing audit or event history directly as the product read.

Clinic references: `005`, `007`, `008`, `016`, `019`, `038`.

## Lifecycle State

Mental model: rows move through product states; the latest or active state controls reads.

Table shape: `request_state`, `member_state`, `rsvp_state`, `saved_state`, `item_state`.

Common trap: using one boolean instead of `pending`, `active`, `removed`, `banned`, `declined`, or `waitlisted`.

Clinic references: `003`, `011`, `017`, `027`, `031-040`.

## Visibility

Mental model: visibility is a query contract, not a property of one row.

Table shape: object state plus blocks, mutes, audience rows, memberships, channel rows, treatments.

Common trap: forgetting deleted, blocked, hidden, private, or removed rows.

Clinic references: `001`, `006`, `012-015`, `028-035`, `036-040`.

## Counters/Read Models

Mental model: counters are cached reads derived from source truth.

Table shape: source event tables plus `*_read_models` and drift checks.

Common trap: trusting read-model counts without recomputing source truth.

Clinic references: `011`, `015`, `027`.

## Source Of Truth Vs Read Model

Mental model: writes go to source tables; reads may use materialized rows after correctness is proven.

Table shape: `post_reactions` before like count, `message_read_receipts` before unread count, `trend_signal_components` before trend snapshot.

Common trap: updating a count directly and losing explainability.

Clinic references: `011`, `015`, `027`, `038`, `040`.

## Dedupe Constraints

Mental model: one product fact should not be counted twice.

Table shape: unique active reaction, deduped notification, duplicate collection attempt row.

Common trap: counting every historical row.

Clinic references: `004`, `007`, `011`, `039`.

## Per-User State

Mental model: the same object can read differently for different users.

Table shape: `block_edges`, `hide_events`, `conversation_user_settings`, `message_deletions`, `collection_members`.

Common trap: using one global flag for viewer-specific behavior.

Clinic references: `001`, `014`, `027-030`, `039`.

## Audit Lineage

Mental model: decisions need evidence, actor, treatment, and trace.

Table shape: `report_evidence`, `policy_decisions`, `policy_treatments`, `audit_log`, `community_audit_log`.

Common trap: storing final status only.

Clinic references: `016`, `017`, `020`, `032`, `035`.

## Safety Evidence

Mental model: reports and abuse signals are evidence, not decisions.

Table shape: `report_events`, `report_evidence`, `abuse_signal_events`, `abuse_signal_evidence`.

Common trap: "three reports means remove".

Clinic references: `016`, `019`, `020`, `038`, `040`.

## Trust/Risk Components

Mental model: explain risk as components that can be inspected.

Table shape: `trust_score_components`, `seller_quality_components`, `trend_signal_components`.

Common trap: one opaque score with no reason rows.

Clinic references: `018`, `023`, `025`, `038`, `040`.

## Recommendation Candidates

Mental model: candidate generation comes before ranking.

Table shape: interests, follows, swipes, matches, blocks, reports, seen rows.

Common trap: ranking all rows and filtering invalid candidates later.

Clinic references: `009`, `010`, `021`, `022`.

## Marketplace Relevance

Mental model: relevance combines buyer intent, listing fit, seller quality, availability, and treatments.

Table shape: `buyer_intents`, `listings`, `listing_tags`, `seller_quality_components`, `offers`, `bookings`.

Common trap: popularity-only marketplace ranking.

Clinic references: `021-025`.

## Inbox/Read Receipts

Mental model: unread is per user, per conversation, derived from message sequence and read receipt.

Table shape: `messages`, `message_delivery_states`, `message_read_receipts`, `conversation_user_settings`.

Common trap: one unread count on the conversation.

Clinic references: `026-030`.

## Community Roles

Mental model: membership grants access; role permissions grant actions.

Table shape: `community_memberships`, `community_roles`, `community_role_assignments`, `community_permissions`.

Common trap: one global admin boolean.

Clinic references: `031`, `035`.

## Discovery/Search/Trending

Mental model: discovery reads need normalized topics, filters, facets, saved state, component traces, safety, and collections.

Table shape: `topics`, `hashtags`, `search_queries`, `search_filters`, `search_facets`, `saved_searches`, `trend_signal_components`, `collections`, `collection_items`.

Common trap: raw text search only, one trend score, or one bookmark flag.

Clinic references: `036-040`.
