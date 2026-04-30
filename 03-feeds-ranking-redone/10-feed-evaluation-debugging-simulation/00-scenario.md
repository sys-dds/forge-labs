# Scenario

A bug report says Ada saw blocked content, too many Ben posts, and no exploration, so the feed is replayed with debug traces.

The important behavior is deterministic: expected final feed [101,501,601,901]; broken replay returned blocked Noor 701, repeated Ben 101/102/103, or omitted exploration 901.
