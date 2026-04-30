# How To Study

1. Read the scenario.
2. Inspect the dataset.
3. Run the broken simulation proof.
4. Read the failure.
5. Inspect debugging notes.
6. Run the solution proof.
7. Change one scoring rule.
8. Rerun the proof.
9. Explain the ranking behavior out loud with item IDs and reasons.

## After hardening
When studying a clinic, read `10-mutation-checks.md` after the proof. Pick one mutation, make the change locally, and confirm the proof fails for the named reason before restoring it.

## Studying Part Two

For clinics 11-20, read the beginner walkthrough before the proof. Then inspect the shortcut audit and mutation checks so the lesson is tied to a product surface, not a reusable dispatcher.
