# Beginner Walkthrough

## Retrieval problem this clinic solves

Compare exact nearest neighbour scan with an approximate bucket probe that is faster but misses one relevant item.

## Why beginners confuse retrieval with ranking

They expect the ranker to pick from the whole corpus, but retrieval controls the candidate pool first.

## What the broken system did

Broken pretends ANN equals exact search, scans all buckets, hides missed_by_ann, and includes blocked 701.

## What the corrected system did

exact_top_k [101, 501, 401, 201], ann_probe_buckets [backend], ann_candidates [101, 401, 201], missed_by_ann [501].

## Which rows/items prove the lesson

101 exact backend neighbour, 201 backend neighbour, 301 sports item, 401 backend neighbour, 501 stale_backend close item, 601 movies item, 701 blocked backend item

## One tiny retrieval calculation

Exact distance for 101 is 0.0; ANN probes only backend, so close stale_backend item 501 is missed.
