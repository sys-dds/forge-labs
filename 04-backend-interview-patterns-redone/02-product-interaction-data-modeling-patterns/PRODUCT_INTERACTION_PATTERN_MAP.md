# Product Interaction Pattern Map

This map groups the 40 Product Interaction Data Modeling clinics by the product pattern family they prepare you to explain in interviews. Each clinic still uses the same proof contract: schema, base seed, variant seed, verification query, expected CSVs, and a broken query that runs but returns wrong rows.

## Identity/Profile Patterns

Range: `001`

Clinics:

- `001-profile-visibility-and-profile-links`

Teaches: durable `users`, `profiles`, profile links, field visibility, and blocked-viewer suppression.

Interview question: "How would you model a user profile with public and private fields?"

Common mistake prevented: treating a profile as one public row and forgetting per-field visibility and blocks.

## Relationship Graph Patterns

Range: `002-003`

Clinics:

- `002-follows-unfollows-blocks`
- `003-friend-requests-mutual-friends`

Teaches: directed follows, unfollow state, blocks, friend request lifecycle, accepted friendships, and mutual-friend reads.

Interview question: "How do you model follow vs friendship?"

Common mistake prevented: treating follows as symmetric friendships or counting pending friend requests as accepted edges.

## Content Interaction Patterns

Range: `004`

Clinics:

- `004-likes-comments-replies-counts`

Teaches: reactions, comments, replies, soft deletion, latest active state, and count contracts.

Interview question: "How do you model likes and comments without double counting?"

Common mistake prevented: counting historical reaction rows or deleted comments as live engagement.

## Matching/Swipe Patterns

Range: `005`

Clinics:

- `005-swipe-left-right-match-creation`

Teaches: swipe events, mutual right-swipe match creation, blocks, reports, and unmatched candidates.

Interview question: "How do you model swipe matching?"

Common mistake prevented: creating a match from one right swipe or ignoring block/report suppression.

## Feed/Notification/Activity Patterns

Range: `006-008`

Clinics:

- `006-simple-home-feed-from-follows`
- `007-notifications-from-interaction-events`
- `008-activity-feed-event-log`

Teaches: feed visibility from follows, notification dedupe, unread state, and activity event filtering.

Interview question: "How would you build a basic home feed or notification table from product events?"

Common mistake prevented: showing global recent content, notifying users about their own action, or exposing audit events as user activity.

## Recommendation Candidate Patterns

Range: `009-010`

Clinics:

- `009-simple-recommendation-candidates`
- `010-capstone-small-social-product-model`

Teaches: candidate generation from interests, follows, swipes, matches, blocks, reports, and capstone composition.

Interview question: "How do you model recommendation candidates before ranking?"

Common mistake prevented: ranking everyone first and filtering blocked, matched, or already-followed users later.

## Counters/Read-Model Patterns

Range: `011-015`

Clinics:

- `011-counters-read-models-drift-detection`
- `012-audience-groups-visibility-rules`
- `013-shares-reposts-bookmarks-saves`
- `014-hides-mutes-reports-preference-feedback`
- `015-capstone-product-interaction-read-models`

Teaches: source truth vs read models, drift checks, audience groups, private saves, repost lineage, hides, mutes, reports, and preference feedback.

Interview question: "How do you model counters and read models safely?"

Common mistake prevented: trusting denormalized counters as truth or treating private saves and hides as global deletes.

## Visibility/User-Control Patterns

Range: `012-015`

Clinics:

- `012-audience-groups-visibility-rules`
- `013-shares-reposts-bookmarks-saves`
- `014-hides-mutes-reports-preference-feedback`
- `015-capstone-product-interaction-read-models`

Teaches: per-viewer visibility, audience membership, bookmarks, reposts, hides, mutes, reports, and controls that alter reads without deleting source rows.

Interview question: "How do you model user-specific visibility controls?"

Common mistake prevented: storing one global `hidden` decision when the product needs viewer-specific state.

## Safety/Moderation/Trust Patterns

Range: `016-020`

Clinics:

- `016-reports-review-queues-policy-decisions`
- `017-moderation-actions-appeals-reversals`
- `018-trust-risk-score-components`
- `019-abuse-signals-fake-engagement-spam`
- `020-capstone-safety-aware-product-interaction-model`

Teaches: reports, evidence, review queues, policy decisions, treatments, appeals, audit logs, trust components, abuse signals, and safety-aware composition.

Interview question: "How do you model moderation and trust without hiding everything behind one score?"

Common mistake prevented: treating report count as a decision or using an opaque trust score with no component rows.

## Marketplace/Creator Ecosystem Patterns

Range: `021-025`

Clinics:

- `021-creator-exposure-budgets-popularity-bias`
- `022-buyer-intent-listing-relevance`
- `023-seller-quality-fulfilment-response-ranking`
- `024-offers-bookings-supply-demand-availability`
- `025-capstone-marketplace-creator-ecosystem-model`

Teaches: creator exposure budgets, buyer intent, listing relevance, seller quality components, offers, bookings, availability, supply/demand, and marketplace treatments.

Interview question: "How do you model marketplace ranking inputs before scoring?"

Common mistake prevented: ranking by popularity only and losing buyer intent, seller quality, availability, and risk evidence.

## Messaging/Inbox Patterns

Range: `026-030`

Clinics:

- `026-conversations-participants-direct-messages`
- `027-message-delivery-read-receipts-unread-counts`
- `028-message-edits-deletes-attachments-visibility`
- `029-inbox-ordering-mutes-blocks-message-reports`
- `030-capstone-communication-product-interaction-model`

Teaches: conversations, participants, messages, delivery state, read receipts, unread counts, edits, deletes, attachments, inbox ordering, mutes, blocks, reports, and review queues.

Interview question: "How do you model messaging read receipts and inbox ordering?"

Common mistake prevented: storing one global unread count or one global deleted flag.

## Community/Group/Event Patterns

Range: `031-035`

Clinics:

- `031-groups-communities-memberships-roles`
- `032-join-requests-invites-private-communities`
- `033-community-posts-channels-thread-visibility`
- `034-community-events-rsvps-attendance`
- `035-capstone-community-product-interaction-model`

Teaches: communities, memberships, role permissions, join requests, invites, bans, channels, threads, moderation, events, RSVPs, waitlists, attendance, and audit traces.

Interview question: "How do you model private communities and roles?"

Common mistake prevented: modeling roles as one admin boolean, invites as membership, or RSVPs as attendance.

## Discovery/Search/Topic/Collection Patterns

Range: `036-040`

Clinics:

- `036-topics-tags-hashtags-topic-follows`
- `037-search-queries-filters-facets-saved-searches`
- `038-trending-signals-time-windows-safety-suppression`
- `039-collections-playlists-bookmark-folders`
- `040-capstone-discovery-search-collections-product-model`

Teaches: topics, hashtags, topic follows, query rows, filters, facets, saved searches, trend windows, trend components, safety suppression, collections, playlist/bookmark-folder ownership, item lifecycle, and debug traces.

Interview question: "How do you model discovery and search product state without building a search engine?"

Common mistake prevented: using raw text only, one opaque trend score, or one bookmark boolean for collections.
