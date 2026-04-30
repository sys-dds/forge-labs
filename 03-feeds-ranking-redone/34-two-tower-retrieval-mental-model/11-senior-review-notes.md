# Senior Review Notes

## Review questions

- Which source found each kept candidate?
- Which relevant item was missed before ranking?
- Which calculation or metric proves the trade-off?

## Telemetry

Log user ID, item ID, source, vector version, pair score, probe bucket, miss reason, rejection reason, and handoff order.

## Remaining failure mode

Small deterministic rows cannot model all source outages, embedding drift, or traffic segment changes.

## Larger-scale change

Add sampled replay, source recall dashboards, and traceable missing-candidate diagnostics.

## Do not over-engineer yet

Stay standard-library only and avoid real ANN or ML infrastructure.
