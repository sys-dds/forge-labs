# Design

## What this clinic teaches

search results vs feed ranking

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben exact Java testing
- Simulation/proof that uses it: Proof asserts 101 first
- Wrong behavior if removed: Exact match lost
- Item: 201
- Why it exists: Cy semantic testing
- Simulation/proof that uses it: Proof asserts 201 included
- Wrong behavior if removed: Semantic match lost
- Item: 301
- Why it exists: Diya JavaScript trap
- Simulation/proof that uses it: Proof asserts language_trap_javascript
- Wrong behavior if removed: Lexical trap leaks
- Item: 401
- Why it exists: Lina weak Java only
- Simulation/proof that uses it: Proof asserts weak_query_match
- Wrong behavior if removed: Weak match leaks
- Item: 501
- Why it exists: Omar viral mismatch
- Simulation/proof that uses it: Proof asserts query_mismatch
- Wrong behavior if removed: Popularity dominates
- Item: 601
- Why it exists: Maya JUnit guide
- Simulation/proof that uses it: Proof asserts 601 second
- Wrong behavior if removed: Strong semantic match lost
- Item: 701
- Why it exists: Noor blocked
- Simulation/proof that uses it: Proof asserts blocked_author
- Wrong behavior if removed: Blocked result leaks
- Item: 801
- Why it exists: Theo old relevant
- Simulation/proof that uses it: Proof asserts 801 included last
- Wrong behavior if removed: Stale but relevant lost

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

search [101,601,201,801]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
