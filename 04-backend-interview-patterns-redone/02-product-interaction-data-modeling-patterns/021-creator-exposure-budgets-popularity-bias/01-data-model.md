# Data Model

## Actual tables

`creators`, `creator_profiles`, `creator_content`, `exposure_budget_windows`, `exposure_events`, `creator_quality_components`, `viewer_seen_events`, `creator_surface_candidates`

## Trap rows

MegaMaker has high popularity but spent all three exposure slots, QuietCraft is the long-tail creator with remaining budget, LowLift has low quality component rows, and RepeatRay is suppressed because Ada already saw that creator.

## Constraints

Use source rows for lifecycle and component math. Do not collapse the model into one opaque marketplace score, one static popularity rank, or one boolean trust flag.
