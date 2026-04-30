# Read Write Path

## Write path

Write offers first, create bookings only for accepted offers, record cancellations as booking state, and update supply/demand snapshots separately.

## Read path

Read by joining source tables to component, lifecycle, treatment, and trace rows so the output can explain the product decision.
