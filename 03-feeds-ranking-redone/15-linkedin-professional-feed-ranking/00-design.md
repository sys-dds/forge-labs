# Design

## What this clinic teaches

professional feed ranking

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben Java architecture
- Simulation/proof that uses it: Proof asserts 101 first
- Wrong behavior if removed: Connection relevance lost
- Item: 201
- Why it exists: Cy job spam
- Simulation/proof that uses it: Proof asserts professional_spam
- Wrong behavior if removed: Spam leaks
- Item: 301
- Why it exists: Diya fintech article
- Simulation/proof that uses it: Proof asserts 301 survives
- Wrong behavior if removed: Second-degree relevance lost
- Item: 401
- Why it exists: Lina distributed article
- Simulation/proof that uses it: Proof asserts article diversity
- Wrong behavior if removed: Article missing
- Item: 501
- Why it exists: Omar viral low relevance
- Simulation/proof that uses it: Proof asserts low_professional_relevance
- Wrong behavior if removed: Viral post wins
- Item: 601
- Why it exists: Maya UK Java job
- Simulation/proof that uses it: Proof asserts 601 ranks
- Wrong behavior if removed: Relevant job lost
- Item: 701
- Why it exists: Noor blocked account
- Simulation/proof that uses it: Proof asserts blocked_or_reported
- Wrong behavior if removed: Blocked account leaks
- Item: 801
- Why it exists: Theo repeated update
- Simulation/proof that uses it: Proof asserts repeated_company_update
- Wrong behavior if removed: Company spam leaks

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

professional [101,601,301,401]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
