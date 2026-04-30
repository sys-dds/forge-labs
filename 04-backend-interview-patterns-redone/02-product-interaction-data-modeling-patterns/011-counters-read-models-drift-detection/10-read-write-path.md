# Read/Write Path

## Write path

Write source interactions first, then update count read models; repair jobs compare read models against source counts.

## Read path

Compute source counts from source tables, join read-model rows, emit count rows, drift rows, no-drift rows, and repair candidates based on source minus stored values.
