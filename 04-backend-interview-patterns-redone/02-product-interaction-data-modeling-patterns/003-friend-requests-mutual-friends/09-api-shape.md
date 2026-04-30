# API Shape

No implementation here, only request/response contracts.

```http
GET /interview/product-model/friend-requests-mutual-friends
```

Response shape:

```json
{"contract_name":"example_contract","subject_id":"example","observed_value":"derived value","expected_reason":"why the model allows or hides it"}
```

A friends response returns accepted edges in both directions and a mutual friend list.
