# Beginner Walkthrough

## Operating problem

Filter already-seen, stale, blocked, and duplicate rows while allowing an evergreen exception.

## Why beginners get it wrong

They see the final list and miss the filter or surface contract behind it.

## What the broken system did

Broken feed includes stale high-score 201 and already-seen 102.

## What the corrected system did

Final feed [101, 301, 401, 501] with specific rejection reasons.

## Which rows/items prove the lesson

101, 102, 201, 301, 401, 501, 601, 701

## One tiny trace/metric/score calculation where relevant

`build_freshness_report` derives the result and the proof checks the evidence row next to it.
