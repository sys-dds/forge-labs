# Design

## What this clinic teaches

Classify retrieval-stage misses without confusing them with ranking low-score explanations.

## Retrieval problem and user intent

Ada needs candidates to reach ranking with source labels and miss reasons. This clinic keeps all retrieval-stage decisions visible.

## Named users/items/sources and why each exists

- Item: 101 followed source
- Why it exists: kept retrieval control
- Simulation/proof that uses it: Proof asserts final pool includes 101
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 201 semantic source
- Why it exists: kept semantic control
- Simulation/proof that uses it: Proof asserts final pool includes 201
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 301 not indexed yet
- Why it exists: index freshness miss
- Simulation/proof that uses it: Proof asserts index_not_fresh
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 401 embedding version mismatch
- Why it exists: embedding drift miss
- Simulation/proof that uses it: Proof asserts embedding_version_mismatch
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 501 retrieval eligibility filtered
- Why it exists: eligibility miss
- Simulation/proof that uses it: Proof asserts retrieval_eligibility_filtered
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 601 source quota overflow
- Why it exists: quota miss
- Simulation/proof that uses it: Proof asserts source_quota_overflow
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 701 lexical tokenization miss
- Why it exists: tokenization miss
- Simulation/proof that uses it: Proof asserts lexical_tokenization_miss
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 801 ANN bucket not probed
- Why it exists: ANN probe miss
- Simulation/proof that uses it: Proof asserts ann_bucket_not_probed
- Wrong behavior if removed: Retrieval evidence gets weaker.
- Item: 901 exploration fallback
- Why it exists: kept fallback retrieval
- Simulation/proof that uses it: Proof asserts final pool includes 901
- Wrong behavior if removed: Retrieval evidence gets weaker.

## Broken retrieval behavior

Broken calls every missing candidate low_score, treats retrieval misses as ranking misses, and omits 901.

## Exact wrong result from the broken version

Broken calls every missing candidate low_score, treats retrieval misses as ranking misses, and omits 901.

## Correct result from the solution

final_candidate_pool [101, 201, 901] with exact retrieval-stage missing explanations for 301/401/501/601/701/801.

## Proof assertions

Exact final pool, exact missing explanations, no low_score, every missing stage retrieval, and trace reasons.

## Beginner mental model

Retrieval is the gate before ranking. Missing-candidate explanations belong to retrieval when an item never reached ranking.

## Senior engineering review angle

Review whether index freshness, embedding versioning, source quota, eligibility, and ANN probe misses are separately observable.

## What the learner should notice

Calling every missing candidate low score hides the actual retrieval failure.

## Interview explanation target

Explain each missing item by first failed retrieval stage and show the proof that catches vague explanations.
