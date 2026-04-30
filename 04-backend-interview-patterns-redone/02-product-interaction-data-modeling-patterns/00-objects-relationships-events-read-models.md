# Objects, Relationships, Events, Read Models

Product interaction systems usually start with durable objects, then relationship tables, then event history, then read models. Keep the first model boring and correct: primary keys, uniqueness rules, lifecycle states, and query contracts. Add caches or denormalised counters later only when the read path demands it.

Clinics 006-010 make that split visible:

- `posts` plus `follow_edges`, `block_edges`, and `mute_edges` derive a home feed.
- `interaction_events` derive deduped `notifications` and unread state.
- `activity_events` are filtered into user-visible activity, not blindly exposed as audit history.
- `follow_edges`, `user_interests`, `swipe_events`, `matches`, `block_edges`, and `report_events` derive recommendation candidates before ranking.
- The capstone composes these contracts without turning the answer into a large system design.
- Clinics 011-015 add read-model counters, drift evidence, audience groups, private saves, repost references, hide/mute/report controls, preference feedback, and a capstone that compares source truth with read-model rows.
- Clinics 016-020 add safety evidence, review queues, policy decisions, treatments, appeals, reversals, audit lineage, trust components, abuse signals, and exact safety debug traces.
- Clinics 021-025 add marketplace and creator ecosystem rows: exposure budgets, buyer intent, listing relevance, seller quality components, offer/booking lifecycle, supply/demand snapshots, marketplace risk rows, and treatment/debug traces.
- Clinics 026-030 add communication rows: conversations, participants, messages, delivery states, read receipts, edit/delete lifecycle, attachments, inbox settings, blocks, reports, review queue rows, and exact communication debug traces.
- Clinics 031-035 add community rows: memberships, roles, role permissions, join requests, invites, bans, channels, channel memberships, posts, threads, moderation actions, events, RSVPs, waitlists, attendance, and exact community debug traces.
- Clinics 036-040 add discovery rows: topics, hashtags, topic follows, search queries, filters, facets, saved searches, trend windows, trend signal components, safety treatments, collections, collection members, ordered collection items, saved items, and exact discovery debug traces.
