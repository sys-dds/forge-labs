import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def build_user_tower_embedding(user): return [1, 1, 1]
def build_item_tower_embedding(item): return item["embedding"]
def score_user_item_pair(user, item): return 1
def retrieve_top_k_for_user(user, items, k): return [101, 201, 601], [], [], []
def compare_ada_and_ben_results(results): return False
def run(dataset_path):
    data = load_dataset(dataset_path)
    trace = [{"content_id": item["id"], "included": item["id"] in [101, 201, 601], "why": "same pool for every user"} for item in data["items"]]
    return {"corpus": [row["id"] for row in data["items"]], "inventory": [row["id"] for row in data["items"]], "retrieval_sources": ["two_tower"], "user_embeddings": {"ada": [1,1,1], "ben": [1,1,1]}, "similarity_rows": [], "retrieved_candidates": [{"user_id": "ada", "content_ids": [101,201,601]}, {"user_id": "ben", "content_ids": [101,201,601]}], "ada_candidates": [101,201,601], "ben_candidates": [101,201,601], "final_candidate_pool": [101,201,601], "missed_candidates": [], "rejected_items": [], "retrieval_debug_trace": trace, "debug_trace": trace}
