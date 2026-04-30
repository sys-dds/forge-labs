# Dataset Story

## Scenario

Workspace alpha has Ada listing, beta has Ben listing, app_user switches tenant context.

## Named Dataset Rows

- Ada appears where the viewer, buyer, or tenant boundary needs a concrete actor.
- Ben carries the positive backend path that should survive the PostgreSQL rule.
- Cy or Noor carries the row that should be excluded, rejected, or treated differently.
- Maya appears as an operator or trusted actor when the example needs a controlled mutation or audit action.

## Why Each Important Row Exists

The positive row proves the feature does not block valid work. The negative row proves the database rejects or hides data that a backend endpoint must not trust blindly.

## Positive Cases

Ben or Ada has a valid row that the solution returns exactly.

## Negative/Exclusion Cases

forgotten RLS, broad policy, app WHERE-only tenancy.

## Proof Assertions

alpha sees alpha only, beta sees beta only, no context sees nothing.

## Deliberate Break/Fix

Edit `90-common-mistakes.sql` ideas into the schema or solution, rerun the chapter test, and restore the rule once the failure is visible.
