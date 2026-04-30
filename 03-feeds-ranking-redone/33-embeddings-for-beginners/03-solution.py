import json
from pathlib import Path
import sys
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from retrieval_math import dot_product, cosine_similarity

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def build_user_vector(data): return data["user_vector"]
def build_item_vectors(data): return {row["id"]: row["vector"] for row in data["items"]}
def compute_dot_product_similarity(user_vector, item_vector): return dot_product(user_vector, item_vector)
def compute_cosine_similarity(user_vector, item_vector): return cosine_similarity(user_vector, item_vector)
def rank_by_similarity(data):
    user_vector = build_user_vector(data)
    rows = []
    rejected = []
    missed = []
    for item in data["items"]:
        dot = compute_dot_product_similarity(user_vector, item["vector"])
        cosine = compute_cosine_similarity(user_vector, item["vector"])
        retrieval_score = round(dot + (0.2 * item["vector"][0]), 3)
        row = {"content_id": item["id"], "dot_product": dot, "cosine_similarity": cosine, "retrieval_score": retrieval_score, "dimensions": data["dimensions"]}
        rows.append(row)
        if item.get("blocked"):
            rejected.append({"content_id": item["id"], "reason": "blocked_author", "stage": "retrieval_eligibility"})
        elif cosine < 0.45:
            missed.append({"content_id": item["id"], "reason": "below_vector_similarity_threshold", "stage": "semantic_retrieval"})
    rejected_ids = {row["content_id"] for row in rejected}
    missed_ids = {row["content_id"] for row in missed}
    candidates = [row for row in sorted(rows, key=lambda r: (-r["retrieval_score"], r["content_id"])) if row["content_id"] not in rejected_ids and row["content_id"] not in missed_ids][:4]
    return rows, candidates, rejected, missed

def explain_vector_match(row):
    return f"{row['content_id']} vector dimensions backend movies cooking dot {row['dot_product']} cosine {row['cosine_similarity']} retrieval_score {row['retrieval_score']}"

def run(dataset_path):
    data = load_dataset(dataset_path)
    rows, candidates, rejected, missed = rank_by_similarity(data)
    candidate_ids = [row["content_id"] for row in candidates]
    trace = [{"content_id": row["content_id"], "included": row["content_id"] in candidate_ids, "why": explain_vector_match(row)} for row in rows]
    return {"corpus": [row["id"] for row in data["items"]], "inventory": [row["id"] for row in data["items"]], "retrieval_sources": ["semantic_embedding"], "embedding_rows": rows, "similarity_rows": rows, "retrieved_candidates": [{"content_id": row["content_id"], "source": "semantic_embedding", "cosine_similarity": row["cosine_similarity"]} for row in candidates], "final_candidate_pool": candidate_ids, "missed_candidates": missed, "rejected_items": rejected, "retrieval_debug_trace": trace, "debug_trace": trace}
