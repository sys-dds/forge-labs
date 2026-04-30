# Scenario

Ada retries a listing create request; Ben uses the same key in his own actor scope.

Expected result: duplicate Ada request collapses to one row; Ben scoped key survives.
