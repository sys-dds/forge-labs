# Interview Explanation

## Direct answer

I would build Ada's creator discovery as an endpoint query: generate graph candidates, apply exclusions, require visible public signal, aggregate counts separately, and return only shaped response fields with stable cursor values.

## Dataset walkthrough

Ada follows Ben. Ben points to Diya, Maya, Lina, and Omar. Diya has two visible posts and three followers. Lina and Maya each have one visible post and two followers with the same latest timestamp. Ben is already followed, Cy is blocked, Noor is private, Omar has only hidden posts, Theo is disconnected, and Ada is the viewer.

## Query reasoning

The solution starts with second-degree candidates through Ada's followed users. It removes Ada, already-followed users, and blocked users. It keeps searchable profiles and joins only creators with visible post counts. Follower counts, mutual follow counts, and visible post counts are separate summaries, then the final query orders by post count, follower count, latest visible post timestamp, and creator id.

## Common mistake

The common mistake is treating this as a user-table query with joins. That leaks Ben, Cy, Noor, Omar, and Theo, and direct joins multiply Diya's two posts by Diya's three followers.

## Senior trade-off

The endpoint query is longer than a raw join, but each CTE protects a contract: graph eligibility, safety, count grain, and pagination stability.

## Follow-up answer

If this query became too slow, I would keep correctness first, inspect the query plan later, consider pre-aggregated read models for follower and post counts, keep the cursor stable, and not remove safety predicates for speed.

