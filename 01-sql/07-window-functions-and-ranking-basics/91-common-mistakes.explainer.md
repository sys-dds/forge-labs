# Window Functions and Ranking Basics Common Mistakes

## ROW_NUMBER without deterministic tie-breaker

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## confusing RANK and DENSE_RANK

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## running total without partition

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## treating ranking input columns as a ranking algorithm

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.
