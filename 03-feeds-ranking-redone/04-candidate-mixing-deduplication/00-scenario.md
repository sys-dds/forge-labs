# Scenario

Ada can receive Lina post 501 from social proof, similar-topic retrieval, and trending, so the mixer must dedupe and preserve reasons.

The important behavior is deterministic: expected mixed page [101,501,601,701,901] with one Lina 501 carrying social_proof, similar_topic, trending; broken mixer duplicated 501 or lost reasons.
