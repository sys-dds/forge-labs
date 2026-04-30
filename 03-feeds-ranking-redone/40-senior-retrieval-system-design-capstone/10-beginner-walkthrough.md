# Beginner Walkthrough

## Retrieval problem this clinic solves

Design a retrieval layer with multiple sources, diagnostics, evaluation, and ranking handoff.

## Why beginners confuse retrieval with ranking

They draw a ranker and forget that ranking only sees candidates produced by retrieval.

## What the broken system did

It used one source, leaked unsafe rows, skipped missing explanations, and returned boolean design flags.

## What the corrected system did

It blended six retrieval sources, rejected unsafe rows, explained stale-index and ANN probe misses, and built rich policies plus a ranking handoff contract.

## Which rows/items prove the lesson

101, 201, 301, 401, 501, 601, 701, 801, 901, 1001

## One tiny retrieval calculation

The ranking handoff for 401 carries source `two_tower`, score `0.94`, and a trace saying it came from high user-item similarity.
