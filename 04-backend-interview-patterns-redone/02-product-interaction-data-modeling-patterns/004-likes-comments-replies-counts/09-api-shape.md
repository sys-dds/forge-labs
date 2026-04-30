# API Shape

No implementation here, only request/response contracts.

```http
GET /interview/product-model/likes-comments-replies-counts
```

Response shape:

```json
{"contract_name":"example_contract","subject_id":"example","observed_value":"derived value","expected_reason":"why the model allows or hides it"}
```

A post detail response returns active like count, visible top-level comment count, and visible reply count.
