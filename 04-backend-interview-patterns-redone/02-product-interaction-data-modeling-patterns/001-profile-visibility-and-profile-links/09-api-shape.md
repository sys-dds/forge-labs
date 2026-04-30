# API Shape

No implementation here, only request/response contracts.

```http
GET /interview/product-model/profile-visibility-and-profile-links
```

Response shape:

```json
{"contract_name":"example_contract","subject_id":"example","observed_value":"derived value","expected_reason":"why the model allows or hides it"}
```

A profile response includes public fields for strangers and private fields only for the owner.
