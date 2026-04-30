# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Return expected["final_feed"] directly | quality gate and surface assertions fail |
| Use same list for Home and Up Next | proof fails surface difference assertion |
| Allow 501 clickbait | proof fails clickbait_abandonment rejection |
| Remove 901 exploration | proof fails exact Home and Up Next output |
| Remove trace for 801 | proof fails debug trace assertion |
