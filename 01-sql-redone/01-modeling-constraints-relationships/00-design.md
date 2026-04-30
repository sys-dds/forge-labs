# Design

## What this clinic teaches

Constraints make marketplace relationship rules durable under retries and concurrent writes.

## Named rows and why each exists

- Ada has buyer profile 1001, follows Ben, blocks Cy, and saves Ben listing 101.
- Ben has seller profile 1002 and listings 101 and 102.
- Cy has seller profile 1003 and listing 201.
- Diya also saves Ben listing 101 to prove saves are per user/listing pair.
- Noor has no relationships to prove a user can exist before activity.

## Broken query bug

The broken implementation leaves profiles, follows, blocks, listings, and saves as loose rows without the needed duplicate, self-action, and reference protection.

## Exact wrong result from the broken query

The proof can insert a second Ada profile, a duplicate Ada save for listing 101, Ada following Ada, and a listing owned by missing seller 999.

## Correct result from the solution

Those invalid writes are rejected while Ada can still follow Ben, block Cy, and share Ben listing 101 with Diya as separate save facts.

## Proof assertions

The proof checks duplicate profile rejection, duplicate save rejection, self-follow rejection, missing seller rejection, Ada follow/block rows, Noor's no-relationship account, and Ada/Diya saves for listing 101.

## What the learner should notice

Composite keys describe relationship facts directly, and Noor's absence of relationship rows is valid data.

## Interview explanation target

Explain one-to-one profile, one-to-many listings, many-to-many saved listings, self-referencing follows/blocks, and database-owned invariants under concurrent requests.

