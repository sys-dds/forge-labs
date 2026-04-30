# Design

## What this clinic teaches

community Hot ranking

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben fresh high votes
- Simulation/proof that uses it: Proof asserts 101 near top
- Wrong behavior if removed: Fresh score lost
- Item: 201
- Why it exists: Cy old high votes
- Simulation/proof that uses it: Proof asserts 201 last
- Wrong behavior if removed: Raw votes dominate
- Item: 301
- Why it exists: Noor removed post
- Simulation/proof that uses it: Proof asserts removed_by_moderation
- Wrong behavior if removed: Removed post leaks
- Item: 401
- Why it exists: Diya very fresh post
- Simulation/proof that uses it: Proof asserts 401 first
- Wrong behavior if removed: Freshness lost
- Item: 501
- Why it exists: Lina comments add heat
- Simulation/proof that uses it: Proof asserts 501 before 701
- Wrong behavior if removed: Discussion signal lost
- Item: 601
- Why it exists: Omar controversy penalty
- Simulation/proof that uses it: Proof asserts 601 before old Cy only
- Wrong behavior if removed: Controversy ignored
- Item: 701
- Why it exists: Maya fresh low votes
- Simulation/proof that uses it: Proof asserts 701 above old Cy
- Wrong behavior if removed: New post buried

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

hot [401,101,501,701,601,201]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
