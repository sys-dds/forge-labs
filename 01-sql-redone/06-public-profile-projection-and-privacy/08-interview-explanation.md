# Interview Explanation

## Direct answer

I would build a public projection that chooses the exact response columns and computes counts in isolated subqueries or CTEs.

## Dataset walkthrough

Ben has private email `ben-private@example.test`, visible posts 201 and 202, hidden post 203, followers Ada and Maya, and one following edge to Ada. Cy is not searchable. Noor is blocked by Ada. Diya is searchable with no posts.

## Query reasoning

The profile card reads Ben's profile row, joins pre-aggregated visible posts, follower counts, and following counts, and never selects email. Ada-safe search starts from Ada, removes Ada herself, keeps searchable profiles, and applies Ada's block exclusion.

## Common mistake

The common mistake is using the table shape as the API shape. `SELECT *` makes Ben's email public and direct child joins multiply counts.

## Senior trade-off

Separate count CTEs are more verbose, but they protect the endpoint grain: one row for Ben's public card.

## Follow-up answer

If the query became slow, I would keep the privacy predicates and projection first, then inspect the plan and consider pre-aggregated profile counters. I would not make the endpoint faster by returning email or blocked profiles.

