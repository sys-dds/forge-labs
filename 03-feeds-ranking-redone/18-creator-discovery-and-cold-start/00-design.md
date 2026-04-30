# Design

## What this clinic teaches

creator discovery

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: Ben
- Why it exists: Already followed famous creator
- Simulation/proof that uses it: Proof asserts already_followed
- Wrong behavior if removed: Discovery repeats follows
- Item: Cy
- Why it exists: Cold-start backend creator
- Simulation/proof that uses it: Proof asserts Cy included
- Wrong behavior if removed: Small creator lost
- Item: Diya
- Why it exists: Fintech backend creator
- Simulation/proof that uses it: Proof asserts Diya first
- Wrong behavior if removed: Relevance lost
- Item: Lina
- Why it exists: Secondary OLED creator
- Simulation/proof that uses it: Proof asserts Lina included
- Wrong behavior if removed: Secondary interest lost
- Item: Omar
- Why it exists: Reported viral creator
- Simulation/proof that uses it: Proof asserts low_quality_reported
- Wrong behavior if removed: Low quality leaks
- Item: Maya
- Why it exists: New quality creator
- Simulation/proof that uses it: Proof asserts Maya included
- Wrong behavior if removed: Cold-start quality lost
- Item: Noor
- Why it exists: Blocked creator
- Simulation/proof that uses it: Proof asserts blocked_creator
- Wrong behavior if removed: Blocked creator leaks
- Item: Theo
- Why it exists: Unrelated creator
- Simulation/proof that uses it: Proof asserts low_relevance
- Wrong behavior if removed: Irrelevant creator leaks

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

creators [Diya,Cy,Maya,Lina]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
