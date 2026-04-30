# Beginner Walkthrough

## Operating problem

Build item-level explanations from candidate source, features, score, safety, and mixing traces.

## Why beginners get it wrong

They look only at the final list and miss the row that explains why the list changed.

## What the broken system did

Broken explanations say recommended for you and omit exploration reasoning.

## What the corrected system did

Final feed [101, 501, 601, 901] with four specific explanations and safety rejections.

## Rows that prove the lesson

101, 501, 601, 901, 701, 801

## Tiny calculation or trace

The proof follows `101` through `explain_seen_item` and requires a debug trace, so a copied final list is not enough.
