# Senior Review Notes

## Review questions

- Which source found each kept candidate?
- Which relevant candidate was missed, and why?
- Which calculation row proves the match rule?

## Telemetry

Log item ID, retrieval source, query vector or tokens, similarity score, rejection reason, miss reason, and handoff order.

## Remaining failure mode

A deterministic toy corpus cannot expose every traffic segment, index outage, or embedding drift case.

## Larger-scale change

Add retrieval replay, source-level recall dashboards, and missing-candidate traces for production reviews.

## Do not over-engineer yet

Do not add vector databases or ML libraries; the clinic teaches the mechanics with standard Python.
