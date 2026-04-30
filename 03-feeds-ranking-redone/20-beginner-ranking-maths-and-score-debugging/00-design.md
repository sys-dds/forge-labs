# Design

## What this clinic teaches

beginner ranking maths

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben raw likes old item
- Simulation/proof that uses it: Proof asserts age decay lowers 101
- Wrong behavior if removed: Raw likes lesson lost
- Item: 201
- Why it exists: Cy recent lower likes
- Simulation/proof that uses it: Proof asserts 201 above 101
- Wrong behavior if removed: Recency lost
- Item: 301
- Why it exists: Diya affinity boost
- Simulation/proof that uses it: Proof asserts affinity component
- Wrong behavior if removed: Affinity lost
- Item: 401
- Why it exists: Lina exploration boost
- Simulation/proof that uses it: Proof asserts exploration boost
- Wrong behavior if removed: Exploration lost
- Item: 501
- Why it exists: Omar high reports
- Simulation/proof that uses it: Proof asserts suppression
- Wrong behavior if removed: Reports ignored
- Item: 601
- Why it exists: Maya completion boost
- Simulation/proof that uses it: Proof asserts 601 first
- Wrong behavior if removed: Completion lost
- Item: 701
- Why it exists: Noor blocked
- Simulation/proof that uses it: Proof asserts blocked_author
- Wrong behavior if removed: Blocked item leaks

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

final [601,301,201,401,101]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
