# Senior Review Notes

## Review questions

- Does every decision have evidence and stage ownership?
- Are remove, reduce, inform, review, and allow separated?
- Can an appeal or incident replay explain the old and new decision?

## Telemetry

Log policy label, evidence row, risk score, treatment, queue reason, appeal state, and safety_debug_trace.

## Remaining failure mode

A stale trust/report/evidence row can silently over- or under-enforce unless replayed.

## Larger-scale change

Move from hand-written rows to versioned policy snapshots with offline replay and audited review queues.

## Do not over-engineer yet

Keep this deterministic; the clinic teaches inspectable policy treatment, not real moderation automation.
