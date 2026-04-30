# Beginner Walkthrough

## Retrieval problem this clinic solves

Shrink a mixed corpus into a labeled candidate pool before ranking sees it.

## Why beginners confuse retrieval with ranking

They see the final feed and assume ranking chose from everything. In reality retrieval decides which items ranking can even see.

## What the broken system did

Broken sends the whole corpus to ranking, leaks 201/301/801, omits 901, and has no source labels.

## What the corrected system did

final_candidate_pool [101, 401, 501, 601, 901], rejected 201/301/801, missed 701.

## Which rows/items prove the lesson

101 Ben followed backend post, 201 Cy muted backend post, 301 Noor blocked post, 401 Diya group backend post, 501 Lina semantic backend post, 601 Maya exploration post, 701 Omar sports post, 801 Theo unsafe post

## One tiny retrieval calculation

101 is kept because followed_author returns Ben; 701 has no source, so ranking never sees it.
