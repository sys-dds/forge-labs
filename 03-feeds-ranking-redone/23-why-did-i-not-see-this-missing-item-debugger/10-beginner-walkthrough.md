# Beginner Walkthrough

## Operating problem

Classify why an absent item failed at retrieval, eligibility, scoring, diversity, seen state, or freshness.

## Why beginners get it wrong

They chase the top score or the final IDs and skip the stage that changed the result.

## What the broken system did

Broken debugger labels every missing item low_score.

## What the corrected system did

Final feed [101, 901] and stage-specific missing explanations for 201, 301, 401, 501, 601, 701, 801.

## Which rows/items prove the lesson

101, 901, 201, 301, 401, 501, 601

## Tiny trace/metric/score calculation

The proof checks `explain_missing_item` output plus debug evidence, so returning the expected feed alone fails.
