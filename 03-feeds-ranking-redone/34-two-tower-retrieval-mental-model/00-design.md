# Design

## What this clinic teaches

Build separate user and item embeddings, then retrieve different candidates for Ada and Ben.

## Retrieval problem and user intent

Ada needs candidate retrieval before ranking. The clinic makes each source, match rule, missed candidate, and rejected item visible.

## Named users/items/sources and why each exists

- Item: Ada backend feeds user
- Why it exists: proves user tower changes candidates
- Simulation/proof that uses it: Proof asserts Ada embedding and candidates
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: Ben movies user
- Why it exists: proves different user gets different pool
- Simulation/proof that uses it: Proof asserts Ben movie candidate only
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 101 backend feed post
- Why it exists: Ada backend candidate
- Simulation/proof that uses it: Proof asserts 101 in Ada pool
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 201 movie recommendation post
- Why it exists: Ben movie candidate
- Simulation/proof that uses it: Proof asserts 201 in Ben pool
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 301 feed ranking post
- Why it exists: highest Ada feed candidate
- Simulation/proof that uses it: Proof asserts 301 first for Ada
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 401 cooking post
- Why it exists: low similarity miss
- Simulation/proof that uses it: Proof asserts 401 missed low_similarity
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 501 backend testing post
- Why it exists: Ada backend support candidate
- Simulation/proof that uses it: Proof asserts 501 in Ada pool
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 601 blocked backend post
- Why it exists: blocked retrieval eligibility
- Simulation/proof that uses it: Proof asserts 601 blocked_author
- Wrong behavior if removed: A retrieval proof loses coverage.

## Broken retrieval behavior

Broken uses the same candidates for every user, ignores user embedding, includes blocked 601, and hides pair scores.

## Exact wrong result from the broken version

Broken uses the same candidates for every user, ignores user embedding, includes blocked 601, and hides pair scores.

## Correct result from the solution

Ada embedding [0.9, 0.8, 0.1] retrieves [301, 101, 501]; Ben embedding [0.1, 0.2, 0.9] retrieves [201].

## Proof assertions

Different pools for Ada and Ben, exact embeddings, blocked rejection, score rows with user_id/item_id pairs, and trace coverage.

## Beginner mental model

Retrieval is the candidate-finding step. Ranking cannot fix an item that retrieval never found.

## Senior engineering review angle

Check whether source labels, similarity rows, recall metrics, and missing-candidate traces would explain a real incident.

## What the learner should notice

Retrieval quality is measured by what it finds, what it misses, and whether those decisions are observable.

## Interview explanation target

Name the corpus, sources, match rule, misses, rejections, and proof that prevents shortcut candidate lists.
