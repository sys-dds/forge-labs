# Beginner Walkthrough

## Retrieval problem this clinic solves

Use hand-written user and item vectors to compute dot product and cosine similarity without ML libraries.

## Why beginners confuse retrieval with ranking

They ask why ranking did not choose an item even when retrieval never handed that item to ranking.

## What the broken system did

Broken ranks by likes, includes blocked 501, hides similarity scores, and misses mixed-interest 401.

## What the corrected system did

retrieved_candidates [101, 401, 601, 201], rejected 501, similarity_rows expose dot and cosine values.

## Which rows/items prove the lesson

Ada user vector [backend, movies, cooking], 101 backend tutorial, 201 movie ranking video, 301 cooking post, 401 backend movie architecture, 501 blocked backend post, 601 exploration mixed vector

## One tiny retrieval calculation

For 101, dot product is 0.9*1.0 + 0.4*0.1 + 0.1*0.0 = 0.94; cosine rounds to 0.945; the retrieval score adds backend weight so 101 stays first.
