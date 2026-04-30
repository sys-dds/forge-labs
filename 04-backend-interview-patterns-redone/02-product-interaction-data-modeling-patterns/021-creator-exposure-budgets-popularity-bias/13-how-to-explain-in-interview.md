# How To Explain In Interview

## Direct answer

Model design creator exposure budgets and popularity-bias controls for a feed or marketplace surface. with `creators`, `creator_profiles`, `creator_content`, `exposure_budget_windows`, `exposure_events`, `creator_quality_components`, `viewer_seen_events`, `creator_surface_candidates`, then prove the read contract from source rows instead of a memorised answer.

## Actual tables

Use `creators`, `creator_profiles`, `creator_content`, `exposure_budget_windows`, `exposure_events`, `creator_quality_components`, `viewer_seen_events`, `creator_surface_candidates` in schema `bip_pim_021`.

## Actual trap rows

MegaMaker has high popularity but spent all three exposure slots, QuietCraft is the long-tail creator with remaining budget, LowLift has low quality component rows, and RepeatRay is suppressed because Ada already saw that creator. Ada is the buyer/viewer row used when the clinic needs a named person to test the read contract.

## Exact query mechanics

Aggregate `exposure_events` into spend, sum `creator_quality_components`, join `viewer_seen_events`, and emit budget, treatment, and exposure_decision_trace rows.

## Write path

Insert creator/profile/content rows first, then write budget windows, exposure events, quality components, and viewer seen events separately.

## Marketplace/product follow-up

Ask how the product should trade off quality, long-tail protection, and repeated creator suppression.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached marketplace read models.
