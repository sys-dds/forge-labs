# How To Explain In Interview

## Direct answer
I model follows as directed edges and apply block suppression in both visibility and count queries.

## Table explanation
Name the object table first, then relationship/event tables, then read contract columns.

## Query explanation
Explain which rows are eligible, which lifecycle states are excluded, and which counts are derived.

## Write path explanation
Describe the insert/update and the constraint that prevents duplicate or invalid state.

## Scaling follow-up answer
I would add read models or counters after proving the source-of-truth tables and query contract.
