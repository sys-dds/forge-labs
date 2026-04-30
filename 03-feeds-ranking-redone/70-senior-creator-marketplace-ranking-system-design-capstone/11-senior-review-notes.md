# Senior Review Notes

## Review questions
- Does Senior creator marketplace ranking system design capstone derive treatment from rows or from fixed outcome lists?
- Which demand, supply, trust, risk, exposure, or fairness row changed ranking order?

## Telemetry
Emit score components, rejected items, suppressed items, budget decisions, and ecosystem debug trace rows with concrete IDs.

## Remaining failure mode
The simulator is deterministic and small; a larger service still needs drift monitoring and abuse review.

## Larger-scale change
Move these score rows into versioned ranking handoff events before tuning weights.

## Do not over-engineer yet
Keep this clinic as row-level teaching infrastructure before adding live services or model training.
