import json
import re
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def tokenize_query(query): return [token.lower() for token in re.findall(r"[A-Za-z]+", query)]
def compute_lexical_match(query_tokens, row): return any(token in row["title"].lower() for token in query_tokens)
def compute_semantic_topic_match(row): return False
def detect_language_trap(row): return False
def merge_lexical_and_semantic(content, lexical_ids, semantic_ids): return [{"content_id": item_id, "source": "lexical"} for item_id in lexical_ids], []
def explain_match_source(row, lexical_ids, semantic_ids): return f"{row['id']} lexical only"
def run(dataset_path):
    data = load_dataset(dataset_path)
    tokens = tokenize_query(data["query"])
    lexical_ids = [row["id"] for row in data["content"] if compute_lexical_match(tokens, row)]
    retrieved, rejected = merge_lexical_and_semantic(data["content"], lexical_ids, [])
    trace = [{"content_id": row["id"], "included": row["id"] in lexical_ids, "why": explain_match_source(row, lexical_ids, [])} for row in data["content"]]
    return {"corpus": [row["id"] for row in data["content"]], "inventory": [row["id"] for row in data["content"]], "retrieval_sources": ["lexical"], "lexical_matches": lexical_ids, "semantic_matches": [], "retrieved_candidates": retrieved, "final_candidate_pool": [row["content_id"] for row in retrieved], "missed_candidates": [], "rejected_items": rejected, "retrieval_debug_trace": trace, "debug_trace": trace}
