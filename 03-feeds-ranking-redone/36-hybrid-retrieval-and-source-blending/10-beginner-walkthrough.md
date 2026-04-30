# Beginner Walkthrough

## Retrieval problem this clinic solves

Blend followed, lexical, semantic, trending, and exploration sources while preserving source reasons and relevance quotas.

## Why beginners confuse retrieval with ranking

They debug ranking output even when the item never reached ranking.

## What the broken system did

Broken uses trending only, loses 601 multi-source reasons, includes blocked/unsafe items, and omits exploration 501.

## What the corrected system did

hybrid_candidates [101, 601, 201, 301, 501] with source reasons and exact rejections.

## Which rows/items prove the lesson

101 followed backend post, 201 lexical Java testing post, 301 semantic testing post, 401 trending unrelated post, 501 exploration new creator, 601 lexical plus semantic, 701 blocked trending post, 801 unsafe high-trending post

## One tiny retrieval calculation

601 appears in lexical and semantic; the merged reason stays lexical + semantic so ranking knows it was found twice.
