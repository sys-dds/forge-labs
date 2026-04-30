# Beginner Walkthrough

## Retrieval problem this clinic solves

Build separate user and item embeddings, then retrieve different candidates for Ada and Ben.

## Why beginners confuse retrieval with ranking

They expect the ranker to pick from the whole corpus, but retrieval controls the candidate pool first.

## What the broken system did

Broken uses the same candidates for every user, ignores user embedding, includes blocked 601, and hides pair scores.

## What the corrected system did

Ada embedding [0.9, 0.8, 0.1] retrieves [301, 101, 501]; Ben embedding [0.1, 0.2, 0.9] retrieves [201].

## Which rows/items prove the lesson

Ada backend feeds user, Ben movies user, 101 backend feed post, 201 movie recommendation post, 301 feed ranking post, 401 cooking post, 501 backend testing post, 601 blocked backend post

## One tiny retrieval calculation

Ada dot 301 = 0.9*0.9 + 0.8*0.9 + 0.1*0.1 = 1.54, so feed ranking wins her pool.
