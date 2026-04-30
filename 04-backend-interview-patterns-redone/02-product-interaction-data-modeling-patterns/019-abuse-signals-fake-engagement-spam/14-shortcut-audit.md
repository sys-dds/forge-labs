# Shortcut Audit

## Likely shortcut

Use report count or a static risky flag as the only truth.

## How base proof catches it

The base proof checks Cy user 3 repeats duplicate comments 301/302/303 creating spam signal 7001, Ben user 2 has like burst signal 7002 on post 201, Diya user 4 has normal engagement and no signal, report 6001 plus evidence rows 8001 and 8002 put Cy into review, and treatment 9001 reviews Cy while treatment 9002 allows Diya.

## How variant proof catches it

The variant changes at least one signal classification or treatment while the same verification query runs.

## What mutation should fail

Remove evidence joins or component/signal labels from the query.

## What learner should inspect manually

Inspect `users, posts, post_reactions, comments, follow_edges, report_events, abuse_signal_events, abuse_signal_evidence, policy_treatments` and compare both expected CSV files.
