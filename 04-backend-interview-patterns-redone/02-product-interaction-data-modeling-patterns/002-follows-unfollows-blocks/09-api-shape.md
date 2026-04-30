# API Shape

No implementation here, only request/response contracts.

```http
GET /interview/product-model/follows-unfollows-blocks
```

Response shape:

```json
{"contract_name":"example_contract","subject_id":"example","observed_value":"derived value","expected_reason":"why the model allows or hides it"}
```

A profile or post response should say whether the viewer can see the author and show derived counts.
