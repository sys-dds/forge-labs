# Beginner Walkthrough

## Operating problem

Compare CTR with completion, skips, hides, dwell, diversity, and repeat-author pressure.

## Why beginners get it wrong

They optimize one visible number and miss the protection around it.

## What the broken system did

Broken comparison chooses Variant A on CTR alone.

## What the corrected system did

Winner Variant B because quality and guardrails beat CTR-only uplift.

## Which rows/items prove the lesson

Variant A, Variant B, clicks, completed, hides_reports, distinct_authors

## One tiny trace/metric/score calculation where relevant

The proof calls `choose_variant_with_guardrails` and also checks trace or metric evidence, so the result must be derived from rules.
