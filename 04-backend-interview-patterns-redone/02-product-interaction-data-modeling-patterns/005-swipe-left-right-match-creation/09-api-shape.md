# API Shape

No implementation here, only request/response contracts.

```http
GET /interview/product-model/swipe-left-right-match-creation
```

Response shape:

```json
{"contract_name":"example_contract","subject_id":"example","observed_value":"derived value","expected_reason":"why the model allows or hides it"}
```

A discovery response returns active candidates and match status derived from latest swipes and suppression tables.
