# Design

## What this clinic teaches

Feed candidate generation gathers recall sources before ranking while safety exclusions still remove muted and blocked authors.

## Named rows and why each exists

- Row: Ben post 101.
  Why it exists: proves followed-author candidate collection.
  Query/proof that uses it: exact candidate set and reason assertion.
  Wrong behavior if removed: followed-author branch is untested.
- Row: Cy post 201.
  Why it exists: proves muted followed authors are excluded.
  Query/proof that uses it: muted exclusion assertion.
  Wrong behavior if removed: mute predicate can be deleted unnoticed.
- Row: Maya post 301.
  Why it exists: proves shared group candidate collection.
  Query/proof that uses it: exact candidate set and reason assertion.
  Wrong behavior if removed: group branch is untested.
- Row: Lina post 601 liked by Diya.
  Why it exists: proves liked-by-following source actor.
  Query/proof that uses it: source actor Diya assertion.
  Wrong behavior if removed: liked source branch is untested.
- Row: Lina post 602 reposted by Diya.
  Why it exists: proves reposted-by-following source actor.
  Query/proof that uses it: source actor Diya assertion.
  Wrong behavior if removed: repost source branch is untested.
- Row: Noor post 701 liked by Diya.
  Why it exists: proves block exclusions beat social proof.
  Query/proof that uses it: blocked exclusion assertion.
  Wrong behavior if removed: unsafe liked candidate can pass.
- Row: Omar post 801.
  Why it exists: proves public visibility alone is not a home-feed candidate path.
  Query/proof that uses it: no-path exclusion assertion.
  Wrong behavior if removed: public-table scans look acceptable.
- Row: Theo post 901.
  Why it exists: proves disconnected public rows stay absent.
  Query/proof that uses it: no-path exclusion assertion.
  Wrong behavior if removed: disconnected leakage is not tested.

## Broken query bug

The broken query only pulls followed-author posts, includes muted Cy, misses group/liked/reposted candidates, and has no reasoned source actor output.

## Exact wrong result from the broken query

Ada candidates are Ben 101 and Cy 201 only, instead of Ben 101, Maya 301, Lina 601, and Lina 602 with exact reasons.

## Correct result from the solution

Ada candidates are Ben 101 followed_author, Maya 301 shared_group, Lina 601 liked_by_following from Diya, and Lina 602 reposted_by_following from Diya.

## Proof assertions

The proof checks exact ids, reasons, source actors, muted/blocked/no-path exclusions, no duplicate candidates, and all four candidate sources.

## What the learner should notice

Candidate generation is recall with safety filters; ranking is a later step.

## Interview explanation target

Explain candidate generation versus ranking, recall sources, safety exclusions, deduplication, and explainable candidate reasons.

