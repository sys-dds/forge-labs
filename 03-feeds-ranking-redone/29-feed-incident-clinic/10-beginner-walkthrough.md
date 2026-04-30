# Beginner Walkthrough

## Operating problem

Reproduce a bad feed, diagnose disabled filters, apply mitigations, and run regression checks.

## Why beginners get it wrong

They see the final list and miss the filter or surface contract behind it.

## What the broken system did

Broken bad_feed [701, 101, 102, 103, 801].

## What the corrected system did

Corrected feed [101, 501, 601, 901], root causes and mitigations all present.

## Which rows/items prove the lesson

701, 101, 102, 103, 801, 501, 601, 901

## One tiny trace/metric/score calculation where relevant

`apply_mitigations` derives the result and the proof checks the evidence row next to it.
