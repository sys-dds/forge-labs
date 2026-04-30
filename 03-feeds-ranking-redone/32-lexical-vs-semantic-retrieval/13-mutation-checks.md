# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Use lexical only | semantic match assertion |
| Allow JavaScript trap | 301 rejection assertion |
| Leak blocked exact match | 701 rejection assertion |
| Drop semantic reasons | 201/401 trace assertion |
| Return unsourced IDs | retrieved candidate source assertion |
