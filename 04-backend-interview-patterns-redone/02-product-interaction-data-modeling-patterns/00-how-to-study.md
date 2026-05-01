# How To Study Product Interaction Modeling

Start with the interview prompt, read the data model, then run the proof. After the proof passes, inspect the trap rows: blocked viewers, inactive users, removed follows, pending friend requests, inactive reactions, deleted comments, reports, unmatched pairs, muted feed authors, self-notification events, private activity rows, stale counters, audience rows, duplicate saves, viewer-specific hides, evidence rows, policy decisions, treatments, appeals, trust components, abuse signals, creator exposure budgets, buyer intent rows, seller quality components, offer/booking lifecycle rows, conversation participants, read receipts, message deletion rows, community memberships, role permissions, join requests, channel memberships, event RSVPs, hashtags, search filters, saved searches, trend components, collection items, and capstone rows that combine several rules.

For each clinic, say the write path out loud before the read query. Interviewers listen for constraints and lifecycle states as much as SQL syntax.

Use the packaging docs for navigation:

- [PIM_STUDY_PLAN.md](PIM_STUDY_PLAN.md) for 7-day, 14-day, and 30-day schedules.
- [PIM_PRACTICE_ROUTES.md](PIM_PRACTICE_ROUTES.md) for goal-based routes.
- [PIM_CHEATSHEET.md](PIM_CHEATSHEET.md) for pattern reminders.
- [PIM_INTERVIEW_ANSWERS.md](PIM_INTERVIEW_ANSWERS.md) for concise answer shapes.
- [PIM_CAPSTONE_GUIDE.md](PIM_CAPSTONE_GUIDE.md) when reviewing capstones.

Study loop:

1. Read `00-interview-question.md`.
2. Predict tables and lifecycle states.
3. Read `01-data-model.md`.
4. Compare `03-seed.sql` and `03b-seed-variant.sql`.
5. Run `./scripts/bip-pim-test-one.sh <clinic-path>`.
6. Trace every `contract_name` in `05-verification-query.sql`.
7. Explain why `07-broken-model-or-query.sql` is wrong.
8. Move on only when you can describe the write path, read path, trap rows, and variant difference.

Repeat a clinic if the proof passes but your explanation still sounds vague. The goal is not just green output; it is being able to explain why the output is green.
