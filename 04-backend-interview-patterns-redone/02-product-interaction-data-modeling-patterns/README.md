# Product Interaction Data Modeling Patterns

This section teaches small backend interview models for product interactions: profile visibility, follows, friendships, reactions, comments, swipes, matches, home feeds, notifications, activity logs, simple recommendation candidates, counters, read models, sharing/saves, user controls, safety moderation, trust components, abuse evidence, audit lineage, marketplace/creator exposure, buyer intent, seller quality, offers/bookings, supply/demand, messaging/inbox communication, community memberships, roles, private access, posts, events, moderation traces, and read contracts.

Run:

```bash
./scripts/bip-pim-list.sh
./scripts/bip-pim-test-all.sh
```

Clinics:

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

Each clinic has base and variant data so the model has to work from relationships and constraints, not from memorised rows.
