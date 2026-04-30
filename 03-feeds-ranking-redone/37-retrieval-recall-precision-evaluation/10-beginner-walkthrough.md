# Beginner Walkthrough

## Retrieval problem this clinic solves

Compare a broad high-recall strategy with a precise narrow strategy and choose recall protection for first-stage retrieval.

## Why beginners confuse retrieval with ranking

They debug ranking output even when the item never reached ranking.

## What the broken system did

Broken chooses Strategy B because precision is higher, ignores missing 401/501, and hides false negatives.

## What the corrected system did

Strategy A recall 1.0 precision 0.5; Strategy B recall 0.6 precision 1.0; first-stage winner Strategy A.

## Which rows/items prove the lesson

Relevant items 101 201 301 401 501, Strategy A retrieved 10, Strategy B retrieved 3, 401 relevant missed by B, 501 relevant missed by B, 701 junk in A

## One tiny retrieval calculation

Strategy B recall is 3 relevant retrieved / 5 relevant total = 0.6, even though precision is 3 / 3 = 1.0.
