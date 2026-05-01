# PIM Practice Routes

Use these routes when you are preparing for a specific interview shape. Each route names the clinics, what to say, what proof to run, and one deliberate mistake to introduce.

## Route A: Social Product Modeling

Clinics: `001`, `002`, `004`, `006`, `007`, `010`.

Say in interview: "I model objects, directed relationships, active interactions, per-viewer feed visibility, event-derived notifications, and a capstone read contract."

Proof to run: run each listed clinic, then `010-capstone-small-social-product-model`.

Deliberate mistake: remove a block or self-notification filter and explain the diff.

## Route B: Safety/Trust Modeling

Clinics: `016`, `017`, `018`, `019`, `020`.

Say in interview: "Reports produce evidence; decisions produce treatments; appeals and audits preserve lineage; trust uses components."

Proof to run: run `016-020`, then inspect `020` expected output.

Deliberate mistake: treat report count as the final decision.

## Route C: Marketplace Modeling

Clinics: `022`, `023`, `024`, `025`.

Say in interview: "Marketplace relevance comes from buyer intent, listing fit, seller quality, lifecycle, availability, supply/demand, and treatments."

Proof to run: run `022`, `023`, `024`, and `025`.

Deliberate mistake: rank by popularity only.

## Route D: Messaging/Inbox Modeling

Clinics: `026`, `027`, `028`, `029`, `030`.

Say in interview: "Conversations have participants; messages have sequence; read receipts are per user; deletes/settings are viewer-specific; inbox order is deterministic."

Proof to run: run `026-030`.

Deliberate mistake: replace per-user read receipts with one conversation unread count.

## Route E: Communities Modeling

Clinics: `031`, `032`, `033`, `034`, `035`.

Say in interview: "Active membership grants access, role permissions grant actions, requests/invites are lifecycle inputs, channels and events have their own visibility, and audit traces explain decisions."

Proof to run: run `031-035`.

Deliberate mistake: treat any historical membership or invite as active access.

## Route F: Discovery/Search Modeling

Clinics: `036`, `037`, `038`, `039`, `040`.

Say in interview: "Discovery uses normalized topics, query/filter/facet rows, saved-search state, trend components, safety suppression, and collection item lifecycle."

Proof to run: run `036-040`.

Deliberate mistake: use raw text match only or count raw trend events only.

## Route G: Senior Backend Interview Route

Clinics: SQL interview patterns `001-030` from `01-sql-interview-patterns`, plus PIM `010`, `015`, `020`, `025`, `030`, `035`, and `040`.

Say in interview: "I can reason about SQL correctness and product data contracts: source truth, read models, lifecycle state, safety lineage, marketplace relevance, messaging state, community permissions, and discovery traces."

Proof to run: run the selected PIM capstones and the relevant SQL section runner.

Deliberate mistake: pick one capstone and remove the rule that suppresses invalid rows; explain the failing contract.
