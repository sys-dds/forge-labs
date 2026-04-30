# Design

## What this clinic teaches

Ranking Signals and Feature Rows teaches feature extraction, negative feedback, safety labels, and inspectable inputs.

## Named users/content and why each exists

- Item: Ben post 101
- Why it exists: Ben has strong relationship and recency features.
- Simulation/proof that uses it: feature_rows_exact.
- Wrong behavior if removed: relationship strength would not be tested.

- Item: Lina video 501
- Why it exists: Lina has video preference and high completion history.
- Simulation/proof that uses it: feature_rows_exact.
- Wrong behavior if removed: watch/completion signals would be absent.

- Item: Maya story 601
- Why it exists: Maya proves language match and medium engagement.
- Simulation/proof that uses it: feature_rows_exact.
- Wrong behavior if removed: story feature extraction would be too narrow.

- Item: Omar video 701
- Why it exists: Omar has high raw likes but hides/reports and unsafe label.
- Simulation/proof that uses it: unsafe_excluded.
- Wrong behavior if removed: negative feedback could be ignored.

- Item: Theo video 801
- Why it exists: Theo proves poor network suitability demotion remains inspectable.
- Simulation/proof that uses it: feature_rows_exact.
- Wrong behavior if removed: device/network suitability would vanish.

- Item: New creator 901
- Why it exists: New creator proves exploration feature row survives low history.
- Simulation/proof that uses it: exploration_present.
- Wrong behavior if removed: cold-start input would be dropped.

## Broken ranking behavior

broken output ranks Omar 701 first by raw likes and hides the feature columns that explain the failure.

## Exact wrong result from the broken version

broken output ranks Omar 701 first by raw likes and hides the feature columns that explain the failure.

## Correct result from the solution

The corrected simulation returns [501,101,601,901,801].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected feature rows for [101,501,601,801,901] and unsafe Omar 701 excluded; broken likes-only scorer put 701 first and hid negative feedback.

## What the learner should notice

Lina video 501 survives for a specific reason, Omar video 701 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain ranking signals and feature rows using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
