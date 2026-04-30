# Design

## What this clinic teaches

safety and integrity ranking

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben safe post
- Simulation/proof that uses it: Proof asserts 101 first
- Wrong behavior if removed: Safe baseline lost
- Item: 201
- Why it exists: Cy borderline downrank
- Simulation/proof that uses it: Proof asserts downranked remains lower
- Wrong behavior if removed: Soft treatment becomes hard filter
- Item: 301
- Why it exists: Noor blocked author
- Simulation/proof that uses it: Proof asserts blocked_author
- Wrong behavior if removed: Blocked content leaks
- Item: 401
- Why it exists: Diya reported once
- Simulation/proof that uses it: Proof asserts review queue
- Wrong behavior if removed: Review queue missing
- Item: 501
- Why it exists: Lina sensitive allowed
- Simulation/proof that uses it: Proof asserts treatment
- Wrong behavior if removed: Sensitive treatment lost
- Item: 601
- Why it exists: Omar spam pattern
- Simulation/proof that uses it: Proof asserts spam_hard_filter
- Wrong behavior if removed: Spam leaks
- Item: 701
- Why it exists: Maya safe exploration
- Simulation/proof that uses it: Proof asserts 701 second
- Wrong behavior if removed: Exploration lost

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

final [101,701,501,201]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
