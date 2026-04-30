# Beginner Walkthrough

## Retrieval problem this clinic solves

Classify retrieval-stage misses without confusing them with ranking low-score explanations.

## Why beginners confuse retrieval with ranking

They say low score even when the item was not indexed, had a stale embedding, or hit a source quota before ranking.

## What the broken system did

Broken calls every missing candidate low_score, treats retrieval misses as ranking misses, and omits 901.

## What the corrected system did

final_candidate_pool [101, 201, 901] with exact retrieval-stage missing explanations for 301/401/501/601/701/801.

## Which rows/items prove the lesson

101 followed source, 201 semantic source, 301 not indexed yet, 401 embedding version mismatch, 501 retrieval eligibility filtered, 601 source quota overflow, 701 lexical tokenization miss, 801 ANN bucket not probed

## One tiny retrieval calculation

301 is missing because indexed=false, so the reason is index_not_fresh before ranking can score it.
