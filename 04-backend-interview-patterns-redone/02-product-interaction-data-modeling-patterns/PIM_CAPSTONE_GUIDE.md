# PIM Capstone Guide

The capstones are where the section becomes interview-ready. Each capstone composes earlier patterns without turning the answer into a large platform design.

## 010 Small Social Product Model

Combines: profiles, follows, blocks, posts, reactions, comments, swipes, matches, notifications, activity, interests, and tags.

Contract rows prove: profile visibility, follow feed, reaction/comment counts, match creation, notification behavior, and recommendation candidates.

Interview story: "I can model a small social product from source tables and per-viewer rules."

Trade-off: keep product contracts explicit before adding caches.

Inspect manually: blocked viewer rows, self-notification row, match rows, and recommendation exclusions.

## 015 Product Interaction Read Models

Combines: counters, read models, audience groups, reposts, bookmarks, hides, mutes, reports, and preference feedback.

Contract rows prove: source truth vs read model drift, audience visibility, private saves, repost lineage, and user controls.

Interview story: "I know when to trust source truth and how to detect stale reads."

Trade-off: faster reads require drift checks.

Inspect manually: stale counter rows, duplicate bookmark rows, close-friends rows, and hide events.

## 020 Safety-Aware Product Interaction Model

Combines: reports, evidence, queues, decisions, treatments, appeals, reversals, audit rows, abuse signals, and trust components.

Contract rows prove: evidence to decision to treatment to trace.

Interview story: "I can model safety systems without reducing them to report counts."

Trade-off: more rows, much better accountability.

Inspect manually: evidence rows, appeal reversal, treatment rows, abuse evidence, and component rows.

## 025 Marketplace Creator Ecosystem Model

Combines: creators, exposure budgets, buyer intent, listings, seller quality, offers, bookings, availability, supply/demand, and marketplace treatments.

Contract rows prove: exposure fairness, intent fit, seller quality, lifecycle, availability, and risk treatment.

Interview story: "I can model marketplace relevance without a popularity-only answer."

Trade-off: relevance is explainable but requires more source components.

Inspect manually: exposure budget rows, listing relevance rows, seller quality components, offer 301, booking 401, and risk event 1701.

## 030 Communication Product Interaction Model

Combines: conversations, participants, messages, delivery, read receipts, edits, deletes, attachments, settings, blocks, reports, and review queue rows.

Contract rows prove: visibility, unread count, current body, inbox order, mute/block behavior, and report review.

Interview story: "I can model messaging with per-user read and delete state."

Trade-off: per-user state is more complex than global flags but avoids incorrect reads.

Inspect manually: conversation 101 participants, message 1003 delete visibility, read receipt 4001, settings rows, and report 7001.

## 035 Community Product Interaction Model

Combines: communities, memberships, roles, permissions, join requests, invites, bans, channels, posts, threads, moderation, events, RSVPs, waitlists, attendance, and audit log.

Contract rows prove: membership, role permission, private access, channel visibility, post/thread visibility, moderation audit, RSVP, capacity, waitlist, attendance, and debug trace.

Interview story: "I can model communities with permissions and lifecycle without building a full community platform."

Trade-off: source rows stay clear while composed reads answer product questions.

Inspect manually: membership 2002, request 3003, invite 4004, ban 5004, post 8003, event 9001, waitlist 9305, and audit 11003.

## 040 Discovery/Search/Collections Product Model

Combines: topics, hashtags, content and creator topic links, topic follows, query/session/filter/facet rows, saved searches, trend components, snapshots, safety suppression, collections, members, items, saved items, and blocks.

Contract rows prove: topic discovery, filtered search results, facet counts, saved-search state, trend components, safety suppression, collection visibility, item lifecycle, and discovery debug trace.

Interview story: "I can model discovery product state without building a search engine."

Trade-off: explainable source rows come before optimized retrieval.

Inspect manually: hashtag 301, follow 5001, query 9001, filter 9101, saved search 9202, treatment 16001, collection 12001, and item 13003.
