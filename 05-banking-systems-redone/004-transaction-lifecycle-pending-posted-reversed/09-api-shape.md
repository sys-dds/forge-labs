# API Shape

This is a request/response sketch only, not application code.

```http
POST /bank-r2/004/example
Idempotency-Key: example-key
```

Request fields should include the account or transfer identifier, amount in cents, currency, and a client request fingerprint when retries matter.

Response fields should include the stable object id, current state, derived balance or contract result, and a debug trace pointing at tables such as `accounts` and `reversals`.
