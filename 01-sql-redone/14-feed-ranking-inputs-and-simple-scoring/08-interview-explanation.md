# Interview Explanation

## Direct answer

I would rank only eligible candidates and expose the feature columns used by the simple SQL score.

## Dataset walkthrough

Ben 101 has fewer likes than Ben 102 but more comments and recency, so it ranks first. Maya 301 gets shared-group affinity. Lina 601 has engagement but lower affinity. Lina 602 is older and lower-scoring. Ben and Lina each have repeated-author diversity groups.

## Query reasoning

The solution computes engagement as likes times 2 plus comments times 4, maps candidate sources to affinity scores, maps recency buckets to recency scores, adds raw_score, and ranks by raw_score, created_at, and post_id.

## Common mistake

The common mistake is sorting by likes only. That makes Ben 102 beat Ben 101 and hides why the ordering happened.

## Senior trade-off

Simple SQL scoring is enough when the product needs inspectable feature rows. A later ranking service can consume the same features, but unsafe candidates should already be gone.

## Follow-up answer

If personalization became more complex, I would keep this clinic's feature rows as the input contract and move model scoring to a later feed/ranking path.

