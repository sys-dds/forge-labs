# Beginner Walkthrough

## Operating problem

Keep unsafe content out early, heavy-rank only a shortlist, rerank for diversity and freshness, and stay under 100ms.

## Why beginners get it wrong

They trust the exciting metric or output and skip the operational constraint.

## What the broken system did

Broken pipeline heavy-ranks every candidate and lets unsafe 301 through.

## What the corrected system did

Final feed [101, 401, 501, 801], 301 rejected early, total latency <= 100ms, shortlist only heavy-ranked.

## Which rows/items prove the lesson

101, 401, 501, 801, 301, latency, shortlist

## One tiny trace/metric/score calculation where relevant

`run_reranker` produces both the user-visible answer and the evidence checked by the proof.
