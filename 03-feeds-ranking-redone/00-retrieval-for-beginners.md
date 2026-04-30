# Retrieval For Beginners

## Corpus

Plain-English meaning: the full set of items the system could search before ranking.

Tiny example from clinic 31: the corpus contains 101, 201, 301, 401, 501, 601, 701, 801, and 901.

Common beginner mistake: assuming ranking scored the whole corpus.

How to debug it: print corpus IDs, then print the candidate pool handed to ranking.

What a senior engineer asks next: which source failed to cover an important part of the corpus?

## Retrieval

Plain-English meaning: finding a smaller candidate pool before ranking runs.

Tiny example from clinic 31: retrieval shrinks the corpus to [101, 401, 501, 601, 901].

Common beginner mistake: blaming ranking for a candidate that retrieval never found.

How to debug it: check source labels and missed-candidate reasons.

What a senior engineer asks next: what recall did the retrieval layer protect?

## Candidate generation

Plain-English meaning: the set of retrieval sources that propose items.

Tiny example from clinic 36: followed_author, lexical, semantic, and exploration sources combine into [101, 601, 201, 301, 501].

Common beginner mistake: using one source and calling it the whole retrieval system.

How to debug it: list candidates by source before blending.

What a senior engineer asks next: which source has the worst miss rate?

## Lexical retrieval

Plain-English meaning: matching exact query words or tokens.

Tiny example from clinic 32: Java testing matches 101 and 601 lexically.

Common beginner mistake: accepting JavaScript as Java because the token starts similarly.

How to debug it: inspect tokens and language-trap filters.

What a senior engineer asks next: which tokenizer change would silently alter recall?

## Semantic retrieval

Plain-English meaning: matching meaning or topic rather than exact words.

Tiny example from clinic 32: Spring Boot integration tests is retrieved semantically for Java testing.

Common beginner mistake: treating semantic retrieval as a black box with no trace.

How to debug it: print semantic topic or vector score rows.

What a senior engineer asks next: how do semantic matches degrade when embeddings drift?

## Approximate nearest neighbour

Plain-English meaning: a faster vector lookup that probes part of the index instead of scanning everything.

Tiny example from clinic 35: exact scan checks every row and finds [101, 501, 401, 201], while ANN probes only backend and returns [101, 401, 201], missing 501.

Common beginner mistake: pretending approximate search equals exact search.

How to debug it: compare exact_top_k with ann_candidates and inspect missed_by_ann.

What a senior engineer asks next: what recall loss is acceptable for the latency saved?

## Recall and precision

Plain-English meaning: recall asks how many relevant items were found; precision asks how much retrieved output was relevant.

Tiny example from clinic 37: Strategy A recall is 1.0 and precision is 0.5; Strategy B recall is 0.6 and precision is 1.0.

Common beginner mistake: choosing the precise strategy while missing important candidates before ranking.

How to debug it: print false negatives as item IDs.

What a senior engineer asks next: where should recall be protected before rankers filter junk?
