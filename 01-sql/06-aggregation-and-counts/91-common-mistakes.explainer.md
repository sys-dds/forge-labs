# Aggregation and Counts Common Mistakes

## counting hidden or deleted rows

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## COUNT(*) after joins inflating counts

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## using WHERE instead of HAVING for aggregate filters

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## missing DISTINCT when counting many-to-many activity

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.
