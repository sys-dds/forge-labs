# Beginner Walkthrough

## Operating problem

Reject a treatment that raises CTR while failing safety, diversity, and retention guardrails.

## Why beginners get it wrong

They trust the exciting metric or output and skip the operational constraint.

## What the broken system did

Broken experiment launches treatment on CTR alone.

## What the corrected system did

launch_decision do_not_launch with failures hide_report_rate, creator_diversity, retention.

## Which rows/items prove the lesson

control, treatment, hide_report_rate, creator_diversity, retention, dwell

## One tiny trace/metric/score calculation where relevant

`make_launch_decision` produces both the user-visible answer and the evidence checked by the proof.
