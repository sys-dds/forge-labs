# Embedding Maths For Beginners

## Embedding and vector

Plain-English meaning: a small list of numbers that represents a user or item along named dimensions.

Tiny example from clinic 33: Ada is [0.9, 0.4, 0.1] for backend, movies, cooking.

Common beginner mistake: saying embedding without showing numbers.

How to debug it: print the query vector and item vector beside the item ID.

What a senior engineer asks next: which version produced this vector?

## Dot product

Plain-English meaning: multiply matching dimensions and add them.

Tiny example from clinic 33: for item 101, 0.9*1.0 + 0.4*0.1 + 0.1*0.0 = 0.94.

Common beginner mistake: treating the score as unexplained model output.

How to debug it: write each dimension contribution next to the total.

What a senior engineer asks next: which dimension dominates the score?

## Cosine similarity

Plain-English meaning: compare vector direction after accounting for vector length.

Tiny example from clinic 33: 101 has cosine similarity 0.949 with Ada, while 401 has 0.998.

Common beginner mistake: comparing raw likes to vector similarity.

How to debug it: compute dot product and cosine rows for the same item.

What a senior engineer asks next: do vector magnitudes carry useful signal or just noise?

## Query vector and item vector

Plain-English meaning: the query or user vector is what retrieval searches with; item vectors are what it searches over.

Tiny example from clinic 34: Ada uses [0.9, 0.8, 0.1], Ben uses [0.1, 0.2, 0.9], so their pools differ.

Common beginner mistake: using the same candidates for every user.

How to debug it: print user_id, item_id, and pair score for each comparison.

What a senior engineer asks next: how fresh are user vectors and item vectors?

## Nearest neighbour and top-k

Plain-English meaning: nearest neighbour returns the closest items; top-k keeps the first k after sorting by distance or similarity.

Tiny example from clinic 35: exact top-k is [101, 501, 401, 201].

Common beginner mistake: hiding the distance rows and only showing IDs.

How to debug it: print distance or similarity rows before truncating.

What a senior engineer asks next: which relevant item was just outside top-k?
