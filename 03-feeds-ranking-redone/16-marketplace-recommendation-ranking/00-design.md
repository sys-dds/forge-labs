# Design

## What this clinic teaches

marketplace recommendations

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben best trusted sink repair
- Simulation/proof that uses it: Proof asserts 101 first
- Wrong behavior if removed: Best match lost
- Item: 201
- Why it exists: Cy cheap risky seller
- Simulation/proof that uses it: Proof asserts seller_risk_suppression
- Wrong behavior if removed: Cheapest wins
- Item: 301
- Why it exists: Diya trusted but far
- Simulation/proof that uses it: Proof asserts 301 survives lower
- Wrong behavior if removed: Distance nuance lost
- Item: 401
- Why it exists: Lina good trust tomorrow
- Simulation/proof that uses it: Proof asserts 401 second
- Wrong behavior if removed: Availability nuance lost
- Item: 501
- Why it exists: Omar wrong category
- Simulation/proof that uses it: Proof asserts wrong_category
- Wrong behavior if removed: Wrong category leaks
- Item: 601
- Why it exists: Maya unavailable
- Simulation/proof that uses it: Proof asserts unavailable
- Wrong behavior if removed: Unavailable listing leaks
- Item: 701
- Why it exists: Noor blocked seller
- Simulation/proof that uses it: Proof asserts blocked_seller
- Wrong behavior if removed: Blocked seller leaks

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

marketplace [101,401,301]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
