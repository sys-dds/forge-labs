# Mutation Checks

| Mutation | Expected failing proof |
|---|---|
| Allow Cy 201 into final_feed | proof fails rejected_items muted_author and final_feed exact assertions |
| Allow Noor 301 into final_feed | proof fails rejected_items blocked_author and final_feed exact assertions |
| Allow Omar 601 into scoring output | proof fails rejected_items unsafe_content and eligible_ids assertions |
| Remove candidate source for Ben 101 | proof fails candidate source assertion for 101 in_network |
| Remove feedback event for Lina 501 | proof fails feedback impression assertion for [101,501,401,701] |
| Remove debug trace for Maya 701 | proof fails debug_trace assertion for final item 701 |
