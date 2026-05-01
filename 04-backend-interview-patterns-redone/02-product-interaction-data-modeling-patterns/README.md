# Product Interaction Data Modeling Patterns

This section teaches backend interview data modeling for product interactions. It is data modeling and query-contract practice: schemas, seed rows, verification queries, expected CSV output, and broken queries that demonstrate common shortcuts. It is not app implementation.

The section is complete at 40 clinics and now includes a packaging layer for interview study.

## Run

List clinics:

```bash
./scripts/bip-pim-list.sh
```

Run all clinic proofs:

```bash
./scripts/bip-pim-test-all.sh
```

Run one clinic:

```bash
./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/010-capstone-small-social-product-model
```

Run quality checks:

```bash
./scripts/check-bip-pim-quality.sh
./scripts/check-bip-pim-packaging.sh
```

## Study Pack

- [PRODUCT_INTERACTION_PATTERN_MAP.md](PRODUCT_INTERACTION_PATTERN_MAP.md) maps all 40 clinics by pattern family.
- [PIM_STUDY_PLAN.md](PIM_STUDY_PLAN.md) gives 7-day, 14-day, and 30-day study plans.
- [PIM_CHEATSHEET.md](PIM_CHEATSHEET.md) summarizes mental models, table shapes, traps, and clinic references.
- [PIM_INTERVIEW_ANSWERS.md](PIM_INTERVIEW_ANSWERS.md) gives concise interview answer templates.
- [PIM_COMMON_MODELING_MISTAKES.md](PIM_COMMON_MODELING_MISTAKES.md) catalogs common modeling bugs and the clinics that catch them.
- [PIM_CAPSTONE_GUIDE.md](PIM_CAPSTONE_GUIDE.md) explains capstones `010`, `015`, `020`, `025`, `030`, `035`, and `040`.
- [PIM_PRACTICE_ROUTES.md](PIM_PRACTICE_ROUTES.md) gives targeted practice routes for social, safety, marketplace, messaging, communities, discovery, and senior backend interviews.

## Clinic Range Map

- `001-005`: identity/profile, relationship graph, content interactions, and swipe/match basics.
- `006-010`: feeds, notifications, activity, recommendation candidates, and small social capstone.
- `011-015`: counters, read models, audience groups, saves/reposts, user controls, and read-model capstone.
- `016-020`: reports, moderation, appeals, trust components, abuse signals, and safety capstone.
- `021-025`: creator exposure, buyer intent, seller quality, offers/bookings, supply/demand, and marketplace capstone.
- `026-030`: conversations, messages, delivery, read receipts, edits/deletes, inbox ordering, and communication capstone.
- `031-035`: communities, memberships, roles, join requests, channels, events, RSVPs, moderation, and community capstone.
- `036-040`: topics, search queries, filters, facets, trends, collections, and discovery capstone.

## Clinics

- `001-profile-visibility-and-profile-links`
- `002-follows-unfollows-blocks`
- `003-friend-requests-mutual-friends`
- `004-likes-comments-replies-counts`
- `005-swipe-left-right-match-creation`
- `006-simple-home-feed-from-follows`
- `007-notifications-from-interaction-events`
- `008-activity-feed-event-log`
- `009-simple-recommendation-candidates`
- `010-capstone-small-social-product-model`
- `011-counters-read-models-drift-detection`
- `012-audience-groups-visibility-rules`
- `013-shares-reposts-bookmarks-saves`
- `014-hides-mutes-reports-preference-feedback`
- `015-capstone-product-interaction-read-models`
- `016-reports-review-queues-policy-decisions`
- `017-moderation-actions-appeals-reversals`
- `018-trust-risk-score-components`
- `019-abuse-signals-fake-engagement-spam`
- `020-capstone-safety-aware-product-interaction-model`
- `021-creator-exposure-budgets-popularity-bias`
- `022-buyer-intent-listing-relevance`
- `023-seller-quality-fulfilment-response-ranking`
- `024-offers-bookings-supply-demand-availability`
- `025-capstone-marketplace-creator-ecosystem-model`
- `026-conversations-participants-direct-messages`
- `027-message-delivery-read-receipts-unread-counts`
- `028-message-edits-deletes-attachments-visibility`
- `029-inbox-ordering-mutes-blocks-message-reports`
- `030-capstone-communication-product-interaction-model`
- `031-groups-communities-memberships-roles`
- `032-join-requests-invites-private-communities`
- `033-community-posts-channels-thread-visibility`
- `034-community-events-rsvps-attendance`
- `035-capstone-community-product-interaction-model`
- `036-topics-tags-hashtags-topic-follows`
- `037-search-queries-filters-facets-saved-searches`
- `038-trending-signals-time-windows-safety-suppression`
- `039-collections-playlists-bookmark-folders`
- `040-capstone-discovery-search-collections-product-model`

Each clinic has base and variant data so the model has to work from relationships and constraints, not from memorized rows.
