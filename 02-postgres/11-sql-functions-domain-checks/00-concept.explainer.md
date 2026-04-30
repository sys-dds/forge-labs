# Concept Explainer

## PostgreSQL Feature

This chapter focuses on SQL functions, reusable domain predicates, clear inputs. The feature matters because the database can reject or shape data before a backend handler accidentally spreads a bad assumption across many code paths.

## Backend Reason

Ben eligible seller, Cy lacks reviews, Noor has open dispute. If this rule is only implied in application code, a retry, import job, admin edit, or second service can bypass it. PostgreSQL gives the rule a stable home next to the data.

## What To Inspect

Look at `01-schema.sql` for the object that owns the rule, `02-seed.sql` for the named rows, `04-solution.sql` for the read or write model, and `05-proof.tests.sql` for exact assertions. The proof is intentionally direct: it names the row that should survive and the row or write that must fail.

## Trade-Off

Do not push every product decision into the database. Use the feature when it protects a durable fact, preserves a write boundary, or makes a backend read model clearer. Keep volatile workflow policy documented near the query so future application code can still understand it.
