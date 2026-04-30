import json
from pathlib import Path
import sys
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from retrieval_math import dot_product

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def build_user_tower_embedding(user): return list(user["embedding"])
def build_item_tower_embedding(item): return list(item["embedding"])
def score_user_item_pair(user, item): return dot_product(build_user_tower_embedding(user), build_item_tower_embedding(item))
def retrieve_top_k_for_user(user, items, k):
    score_rows = []
    rejected = []
    missed = []
    for item in items:
        score = score_user_item_pair(user, item)
        score_rows.append({"user_id": user["id"], "item_id": item["id"], "score": score})
        if item.get("blocked"):
            rejected.append({"content_id": item["id"], "reason": "blocked_author", "stage": "retrieval_eligibility"})
        elif score < 0.4:
            missed.append({"content_id": item["id"], "reason": "low_user_item_similarity", "stage": "two_tower_retrieval", "user_id": user["id"]})
    rejected_ids = {row["content_id"] for row in rejected}
    missed_ids = {row["content_id"] for row in missed}
    candidates = [row for row in sorted(score_rows, key=lambda row: (-row["score"], row["item_id"])) if row["item_id"] not in rejected_ids and row["item_id"] not in missed_ids][:k]
    return candidates, score_rows, rejected, missed

def compare_ada_and_ben_results(results): return results["ada"] != results["ben"]
def run(dataset_path):
    data = load_dataset(dataset_path)
    all_scores = []
    rejected = []
    missed = []
    user_results = {}
    for user in data["users"]:
        k = 3 if user["id"] == "ada" else 1
        candidates, scores, user_rejected, user_missed = retrieve_top_k_for_user(user, data["items"], k)
        all_scores.extend(scores); rejected.extend(user_rejected); missed.extend(user_missed)
        user_results[user["id"]] = [row["item_id"] for row in candidates]
    rejected_unique = []
    seen_rejected = set()
    for row in rejected:
        if row["content_id"] not in seen_rejected:
            rejected_unique.append(row); seen_rejected.add(row["content_id"])
    trace = [{"content_id": row["item_id"], "included": row["item_id"] in user_results[row["user_id"]], "why": f"{row['user_id']} pair score for {row['item_id']} is {row['score']}"} for row in all_scores]
    return {"corpus": [row["id"] for row in data["items"]], "inventory": [row["id"] for row in data["items"]], "retrieval_sources": ["two_tower"], "user_embeddings": {user["id"]: build_user_tower_embedding(user) for user in data["users"]}, "similarity_rows": all_scores, "retrieved_candidates": [{"user_id": user_id, "content_ids": ids, "source": "two_tower"} for user_id, ids in user_results.items()], "ada_candidates": user_results["ada"], "ben_candidates": user_results["ben"], "final_candidate_pool": user_results["ada"], "missed_candidates": missed, "rejected_items": rejected_unique, "retrieval_debug_trace": trace, "debug_trace": trace}
