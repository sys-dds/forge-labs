# Read/Write Path

## Write path

Keep normalized product writes in their source tables, then derive the read contract.

## Read path

Union mutual-follow, shared-interest, and right-swipe source rows, then exclude already-followed, matched, blocked, reported, inactive, and undiscoverable users while preserving source labels.
