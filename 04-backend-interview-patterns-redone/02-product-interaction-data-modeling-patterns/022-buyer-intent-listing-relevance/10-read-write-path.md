# Read Write Path

## Write path

Write buyer intent, listing tags, availability windows, seller trust components, and seen rows independently before reading relevance.

## Read path

Read by joining source tables to component, lifecycle, treatment, and trace rows so the output can explain the product decision.
