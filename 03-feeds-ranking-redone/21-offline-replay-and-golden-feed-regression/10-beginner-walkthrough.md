# Beginner Walkthrough

## Operating problem

Replay a fixed feed inventory and compare the derived actual feed with a golden feed before shipping.

## Why beginners get it wrong

They look only at the final list and miss the row that explains why the list changed.

## What the broken system did

Broken feed leaks 701 and omits 901.

## What the corrected system did

Actual feed [101, 501, 601, 901], rejected 701 blocked_author and 801 unsafe_content, regression_report [].

## Rows that prove the lesson

101, 501, 601, 701, 801, 901

## Tiny calculation or trace

The proof follows `101` through `build_actual_feed` and requires a debug trace, so a copied final list is not enough.
