# Beginner Walkthrough

## Retrieval problem this clinic solves

Recover new high-quality creators that pure engagement retrieval would miss, while filtering unsafe and unrelated rows.

## Why beginners confuse retrieval with ranking

They ask ranking why an item disappeared, but the item was excluded or missed before ranking ran.

## What the broken system did

Broken retrieves only popular items, misses 301/601, includes unrelated 701, and includes unsafe 501.

## What the corrected system did

retrieved_candidates [101, 201, 301, 601], cold_start_backfill [301, 601], exact rejections.

## Which rows/items prove the lesson

101 popular backend post, 201 popular movie post, 301 new backend creator, 401 cooking creator, 501 unsafe new creator, 601 profile-topic new creator, 701 old popular unrelated

## One tiny retrieval calculation

301 has zero likes but topic_match backend and quality 0.9, so cold-start quality passes the 0.7 threshold.
