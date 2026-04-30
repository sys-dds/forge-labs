# Shortcut Audit

- What shortcut might happen: hard-code the expected contract rows from the base dataset.
- How base proof catches it: the base CSV checks the exact derived contract values.
- How variant proof catches it: the variant proof catches static answers because at least one visibility, count, relationship, or candidate result changes.
- What mutation should fail: changing the trap row described in `01-data-model.md` should change the proof output.
- What learner should inspect manually: verify `05-verification-query.sql` reads source tables and does not echo expected rows.
