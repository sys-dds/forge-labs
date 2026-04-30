# Design

## What this clinic teaches

Shrink a mixed corpus into a labeled candidate pool before ranking sees it.

## Retrieval problem and user intent

Ada needs a small candidate pool before ranking. The clinic shows which retrieval source found each kept item, which source missed an item, and which exclusion happened before ranking.

## Named users/items/sources and why each exists

- Item: 101 Ben followed backend post
- Why it exists: proves followed_author retrieval
- Simulation/proof that uses it: Proof asserts 101 source is followed_author
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 201 Cy muted backend post
- Why it exists: proves retrieval eligibility removes muted authors
- Simulation/proof that uses it: Proof asserts 201 rejected muted_author
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 301 Noor blocked post
- Why it exists: proves blocked authors are excluded before ranking
- Simulation/proof that uses it: Proof asserts 301 rejected blocked_author
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 401 Diya group backend post
- Why it exists: proves group source contributes candidates
- Simulation/proof that uses it: Proof asserts 401 source group
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 501 Lina semantic backend post
- Why it exists: proves semantic source contributes meaning match
- Simulation/proof that uses it: Proof asserts 501 source semantic_similarity
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 601 Maya exploration post
- Why it exists: proves exploration source backfills candidate pool
- Simulation/proof that uses it: Proof asserts 601 source exploration
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 701 Omar sports post
- Why it exists: proves missed rows have retrieval reasons
- Simulation/proof that uses it: Proof asserts 701 no_retrieval_source
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 801 Theo unsafe post
- Why it exists: proves unsafe content is rejected before ranking
- Simulation/proof that uses it: Proof asserts 801 unsafe_content
- Wrong behavior if removed: The retrieval lesson loses one proof row.
- Item: 901 Ivy cold-start post
- Why it exists: proves fresh cold-start exploration is included
- Simulation/proof that uses it: Proof asserts 901 source exploration
- Wrong behavior if removed: The retrieval lesson loses one proof row.

## Broken retrieval behavior

Broken sends the whole corpus to ranking, leaks 201/301/801, omits 901, and has no source labels.

## Exact wrong result from the broken version

Broken sends the whole corpus to ranking, leaks 201/301/801, omits 901, and has no source labels.

## Correct result from the solution

final_candidate_pool [101, 401, 501, 601, 901], rejected 201/301/801, missed 701.

## Proof assertions

Exact pool, source labels for every kept candidate, exact rejected rows, 701 miss reason, and retrieval debug traces.

## Beginner mental model

Retrieval is the search for candidates before ranking. Ranking can only order items that retrieval managed to find and pass forward.

## Senior engineering review angle

Review the source labels, missed-candidate reasons, similarity or metric rows, and ranking handoff evidence before trusting the candidate pool.

## What the learner should notice

A retrieved list without source labels and miss reasons is not debuggable.

## Interview explanation target

Explain the corpus, retrieval sources, matching rule, excluded rows, recall risk, and proof that catches shortcut implementations.
