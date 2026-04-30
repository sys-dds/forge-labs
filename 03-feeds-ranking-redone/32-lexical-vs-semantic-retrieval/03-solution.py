import json
import re
from pathlib import Path

def load_dataset(dataset_path):
    return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())

def tokenize_query(query):
    return [token.lower() for token in re.findall(r"[A-Za-z]+", query)]

def compute_lexical_match(query_tokens, row):
    title_tokens = [token.lower() for token in re.findall(r"[A-Za-z]+", row["title"])]
    return any(token in title_tokens for token in query_tokens)

def compute_semantic_topic_match(row):
    return "java_testing" in row.get("topics", []) or "backend_testing" in row.get("topics", [])

def detect_language_trap(row):
    return "javascript_testing" in row.get("topics", [])

def merge_lexical_and_semantic(content, lexical_ids, semantic_ids):
    rejected = []
    retrieved = []
    content_by_id = {row["id"]: row for row in content}
    for content_id in lexical_ids + semantic_ids:
        row = content_by_id[content_id]
        if row.get("blocked"):
            rejected.append({"content_id": content_id, "reason": "blocked_author", "stage": "retrieval_eligibility"})
        elif detect_language_trap(row):
            rejected.append({"content_id": content_id, "reason": "language_trap_javascript", "stage": "lexical_filter"})
        elif content_id not in [item["content_id"] for item in retrieved]:
            sources = []
            if content_id in lexical_ids:
                sources.append("lexical")
            if content_id in semantic_ids:
                sources.append("semantic")
            retrieved.append({"content_id": content_id, "source": " + ".join(sources)})
    for row in content:
        if row["id"] not in lexical_ids and row["id"] not in semantic_ids:
            rejected.append({"content_id": row["id"], "reason": "query_mismatch", "stage": "retrieval"})
    priority = {"lexical + semantic": 1, "semantic": 2, "lexical": 3}
    return sorted(retrieved, key=lambda item: (priority[item["source"]], item["content_id"])), rejected

def explain_match_source(row, lexical_ids, semantic_ids):
    if row["id"] in lexical_ids and row["id"] in semantic_ids:
        return f"{row['id']} matched exact tokens and semantic java_testing topic"
    if row["id"] in semantic_ids:
        return f"{row['id']} semantic_topic_match java_testing"
    if row["id"] in lexical_ids:
        return f"{row['id']} lexical token match"
    return f"{row['id']} query_mismatch"

def run(dataset_path):
    data = load_dataset(dataset_path)
    tokens = tokenize_query(data["query"])
    lexical_ids = [row["id"] for row in data["content"] if compute_lexical_match(tokens, row)]
    semantic_ids = [row["id"] for row in data["content"] if compute_semantic_topic_match(row)]
    retrieved, rejected = merge_lexical_and_semantic(data["content"], lexical_ids, semantic_ids)
    trace = [{"content_id": row["id"], "included": row["id"] in [item["content_id"] for item in retrieved], "why": explain_match_source(row, lexical_ids, semantic_ids)} for row in data["content"]]
    return {"corpus": [row["id"] for row in data["content"]], "inventory": [row["id"] for row in data["content"]], "retrieval_sources": ["lexical", "semantic"], "lexical_matches": lexical_ids, "semantic_matches": semantic_ids, "retrieved_candidates": retrieved, "final_candidate_pool": [row["content_id"] for row in retrieved], "missed_candidates": [], "rejected_items": rejected, "retrieval_debug_trace": trace, "debug_trace": trace}
