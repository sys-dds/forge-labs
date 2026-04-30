# Interview Explanation

## Direct answer

following feed and For You feed ranks by the user's current intent, not by one universal score.

## Dataset walkthrough

Ada is the viewer. The named rows create valid candidates, rejected candidates, and tempting wrong candidates.

## Ranking reasoning

The corrected simulation applies eligibility first, computes visible signals, and then orders candidates for this surface.

## Common mistake

A common mistake is to reuse a feed ranker where the surface has a different intent.

## Senior trade-off

The trade-off is keeping the ranking simple enough to debug while still separating hard filters, penalties, boosts, and traceable reasons.

## Follow-up answer

For a larger system, I would add offline replay and guardrail metrics before changing the ranking rule.
