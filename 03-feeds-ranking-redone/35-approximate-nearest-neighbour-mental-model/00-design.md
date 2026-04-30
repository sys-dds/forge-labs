# Design

## What this clinic teaches

Compare exact nearest neighbour scan with an approximate bucket probe that is faster but misses one relevant item.

## Retrieval problem and user intent

Ada needs candidate retrieval before ranking. The clinic makes each source, match rule, missed candidate, and rejected item visible.

## Named users/items/sources and why each exists

- Item: 101 exact backend neighbour
- Why it exists: closest exact and ANN candidate
- Simulation/proof that uses it: Proof asserts 101 in exact and ANN
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 201 backend neighbour
- Why it exists: ANN finds lower backend candidate
- Simulation/proof that uses it: Proof asserts 201 in ANN
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 301 sports item
- Why it exists: distant item outside probed bucket
- Simulation/proof that uses it: Proof excludes 301
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 401 backend neighbour
- Why it exists: ANN finds close backend candidate
- Simulation/proof that uses it: Proof asserts 401 in ANN
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 501 stale_backend close item
- Why it exists: exact finds it but ANN misses bucket
- Simulation/proof that uses it: Proof asserts missed_by_ann 501
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 601 movies item
- Why it exists: different bucket not probed
- Simulation/proof that uses it: Proof excludes 601
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 701 blocked backend item
- Why it exists: eligibility still applies after probe
- Simulation/proof that uses it: Proof asserts 701 blocked_author
- Wrong behavior if removed: A retrieval proof loses coverage.

## Broken retrieval behavior

Broken pretends ANN equals exact search, scans all buckets, hides missed_by_ann, and includes blocked 701.

## Exact wrong result from the broken version

Broken pretends ANN equals exact search, scans all buckets, hides missed_by_ann, and includes blocked 701.

## Correct result from the solution

exact_top_k [101, 501, 401, 201], ann_probe_buckets [backend], ann_candidates [101, 401, 201], missed_by_ann [501].

## Proof assertions

Exact vs ANN differ, 501 missed_by_ann, ANN recall less than exact, blocked rejection, approximate trade-off trace.

## Beginner mental model

Retrieval is the candidate-finding step. Ranking cannot fix an item that retrieval never found.

## Senior engineering review angle

Check whether source labels, similarity rows, recall metrics, and missing-candidate traces would explain a real incident.

## What the learner should notice

Retrieval quality is measured by what it finds, what it misses, and whether those decisions are observable.

## Interview explanation target

Name the corpus, sources, match rule, misses, rejections, and proof that prevents shortcut candidate lists.
