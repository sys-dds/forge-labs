# Tables and Relationships Common Mistakes

## profile table with separate id but no unique user_id

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## posts without author foreign key

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## follows without composite primary key

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.

## settings as ever-growing nullable columns on users

This looks tempting when you focus on the immediate query or endpoint. It breaks real backend behavior because the database no longer protects the important shape, exclusion, or count. The chapter solution avoids it by making the rule explicit in constraints, predicates, ordering keys, or isolated aggregation.
