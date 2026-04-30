# Design

## What this clinic teaches

vertical short-video feed

## Product surface and user intent

Ada expects this surface to rank by its own intent and not by a universal popularity list.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben proves completion plus rewatch
- Simulation/proof that uses it: Proof asserts 101 after 201
- Wrong behavior if removed: Dragon signal disappears
- Item: 201
- Why it exists: Cy proves completion beats likes
- Simulation/proof that uses it: Proof asserts 201 first
- Wrong behavior if removed: Completion lesson disappears
- Item: 301
- Why it exists: Noor proves block filter
- Simulation/proof that uses it: Proof asserts 301 blocked_author
- Wrong behavior if removed: Blocked video leaks
- Item: 401
- Why it exists: Lina proves topic match
- Simulation/proof that uses it: Proof asserts 401 in output
- Wrong behavior if removed: OLED interest unused
- Item: 501
- Why it exists: Omar proves likes can be bad
- Simulation/proof that uses it: Proof asserts 501 high_negative_feedback
- Wrong behavior if removed: Clickbait wins
- Item: 601
- Why it exists: Maya proves exploration slot
- Simulation/proof that uses it: Proof asserts 601 included
- Wrong behavior if removed: No discovery
- Item: 701
- Why it exists: Theo proves creator fatigue
- Simulation/proof that uses it: Proof asserts fatigue component
- Wrong behavior if removed: Repeated creator dominates

## Broken ranking behavior

The broken simulation follows the wrong primary signal and ignores at least one eligibility rule.

## Exact wrong result from the broken version

The proof prints the wrong output from the broken simulation and names the offending item.

## Correct result from the solution

short_video_feed [201,101,401,601,701]

## Proof assertions

The proof checks exact output, rejected items, debug traces, and surface-specific signal rows.

## Beginner mental model

Start with intent, remove ineligible rows, compute visible signals, then order the remaining candidates.

## What the learner should notice

Changing surfaces changes the meaning of a good rank.

## Interview explanation target

Explain the product intent, the hard filters, the visible signals, and the debugging output.
