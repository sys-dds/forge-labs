# PIM Study Plan

Use this plan after the 40 Product Interaction Data Modeling clinics are present. The goal is not to memorize SQL; it is to learn how to explain product rows, lifecycle state, visibility, and read contracts under interview pressure.

## How To Study One Clinic

1. Read `00-interview-question.md` and answer out loud before opening the model.
2. Read `01-data-model.md`; name the source tables and the trap rows.
3. Open `03-seed.sql` and `03b-seed-variant.sql`; find what changes between them.
4. Run `./scripts/bip-pim-test-one.sh <clinic-path>`.
5. Read `05-verification-query.sql`; trace each `contract_name` back to seed rows.
6. Read `07-broken-model-or-query.sql`; explain why it executes but returns wrong rows.
7. Say the write path, read path, common mistake, and scaling follow-up in two minutes.

## Proof Commands

List clinics:

```bash
./scripts/bip-pim-list.sh
```

Run one clinic:

```bash
./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/010-capstone-small-social-product-model
```

Run all PIM clinics:

```bash
./scripts/bip-pim-test-all.sh
```

Run section quality:

```bash
./scripts/check-bip-pim-quality.sh
./scripts/check-bip-pim-packaging.sh
```

## 7-Day Fast Pass

Day 1: `001-005` identity, relationships, reactions, swipes.

Day 2: `006-010` feeds, notifications, activity, candidates, social capstone.

Day 3: `011-015` counters, read models, audience, saves, controls.

Day 4: `016-020` safety, moderation, trust, abuse, safety capstone.

Day 5: `021-025` marketplace and creator ecosystem.

Day 6: `026-035` messaging plus communities.

Day 7: `036-040`, then reread `PIM_CAPSTONE_GUIDE.md` and answer from `PIM_INTERVIEW_ANSWERS.md`.

## 14-Day Normal Pass

Days 1-2: `001-005`; focus on graph direction, lifecycle, and double counting.

Days 3-4: `006-010`; focus on per-viewer feed and event-derived reads.

Days 5-6: `011-015`; focus on source truth vs read models.

Days 7-8: `016-020`; focus on evidence, decision, treatment, and audit lineage.

Days 9-10: `021-025`; focus on relevance components and lifecycle.

Days 11-12: `026-035`; focus on per-user messaging and community permissions.

Days 13-14: `036-040`; focus on discovery debug traces and capstone storytelling.

## 30-Day Deep Pass

Spend one day per cluster of one or two clinics. For each clinic, mutate one seed row locally, predict the expected CSV change, then revert. Use the final week for capstones `010`, `015`, `020`, `025`, `030`, `035`, and `040`.

## How To Inspect Seed Data

Look for rows with names or ids called out in `13-how-to-explain-in-interview.md`. The trap rows are not incidental; they are the interview lesson. Compare base and variant seeds before looking at expected CSVs.

## How To Break A Query And Learn

Make one deliberate mistake: remove a `deleted` filter, ignore a block row, count historical rows, skip `member_state`, or count every RSVP. Run the proof and read the diff. Then restore the query and explain the bug out loud.

## When To Move On

Move on when you can:

- name the source tables without looking
- explain the hidden rows
- explain the variant change
- describe the write path and read path
- name the broken shortcut

## When To Repeat

Repeat a clinic when the proof passes but you cannot explain why. Repeat capstones until you can tell the interview story without reading notes.
