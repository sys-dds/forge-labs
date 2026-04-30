# Shortcut Audit

## Likely shortcut

Hard-code the expected marketplace row, use only popularity or recency, or emit one opaque score.

## How base proof catches it

The base proof checks named trap rows from `creators`, `creator_profiles`, `creator_content` and requires exact component or lifecycle evidence.

## How variant proof catches it

The variant proof catches it by changing a budget, component, lifecycle, or availability row while keeping the same verification query.

## What mutation should fail

A mutation that removes the trap row evidence, treatment reason, or debug trace should change the expected CSV and fail.

## What learner should inspect manually

Inspect the source rows, the component rows, and the treatment/debug trace before trusting any final feed or marketplace result.
