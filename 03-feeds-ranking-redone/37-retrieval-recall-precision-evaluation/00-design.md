# Design

## What this clinic teaches

Compare a broad high-recall strategy with a precise narrow strategy and choose recall protection for first-stage retrieval.

## Retrieval problem and user intent

Ada needs a candidate pool before ranking. This clinic makes the retrieval sources, missed candidates, and excluded items inspectable.

## Named users/items/sources and why each exists

- Item: Relevant items 101 201 301 401 501
- Why it exists: ground truth for recall
- Simulation/proof that uses it: Proof asserts exact recall denominators
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: Strategy A retrieved 10
- Why it exists: high recall low precision strategy
- Simulation/proof that uses it: Proof asserts recall 1.0 precision 0.5
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: Strategy B retrieved 3
- Why it exists: high precision low recall strategy
- Simulation/proof that uses it: Proof asserts recall 0.6 precision 1.0
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 401 relevant missed by B
- Why it exists: first-stage recall risk
- Simulation/proof that uses it: Proof asserts B false negative 401
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 501 relevant missed by B
- Why it exists: second recall risk
- Simulation/proof that uses it: Proof asserts B false negative 501
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 701 junk in A
- Why it exists: precision cost after recall protected
- Simulation/proof that uses it: Proof asserts A false positive includes 701
- Wrong behavior if removed: A retrieval proof loses coverage.

## Broken retrieval behavior

Broken chooses Strategy B because precision is higher, ignores missing 401/501, and hides false negatives.

## Exact wrong result from the broken version

Broken chooses Strategy B because precision is higher, ignores missing 401/501, and hides false negatives.

## Correct result from the solution

Strategy A recall 1.0 precision 0.5; Strategy B recall 0.6 precision 1.0; first-stage winner Strategy A.

## Proof assertions

Exact recall/precision reports, B false negatives [401, 501], winner Strategy A, and recall-first debug trace.

## Beginner mental model

Retrieval finds the pool; ranking orders the pool. A candidate missing from retrieval cannot be rescued later by ranking.

## Senior engineering review angle

Review source coverage, miss reasons, recall and precision, index freshness, and the ranking handoff contract.

## What the learner should notice

Good retrieval infrastructure explains both successful candidates and absent candidates.

## Interview explanation target

Explain the corpus, retrieval sources, matching rule, excluded items, recall risk, and shortcut-proof tests.
