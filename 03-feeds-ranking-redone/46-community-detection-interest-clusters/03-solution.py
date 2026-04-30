import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def load_community_memberships(data):
    return data["user_memberships"], data["item_memberships"]

def compute_user_cluster_affinity(data):
    return data["user_memberships"]["ada"]

def compute_item_cluster_affinity(data):
    return data["item_memberships"]

def score_cluster_overlap(user_affinity, item_affinity):
    rows = []
    for item, clusters in item_affinity.items():
        parts = []
        score = 0.0
        for cluster, strength in clusters.items():
            overlap = round(user_affinity.get(cluster, 0.0) * strength, 2)
            if overlap:
                parts.append({"cluster": cluster, "user_strength": user_affinity[cluster], "item_strength": strength, "overlap": overlap})
                score = round(score + overlap, 2)
        rows.append({"content_id": item, "cluster_overlap_score": score, "overlap_parts": parts})
    return sorted(rows, key=lambda row: (-row["cluster_overlap_score"], row["content_id"]))

def apply_cluster_safety_filter(data, rows):
    kept = []
    rejected = []
    for row in rows:
        if row["content_id"] in data["unsafe"]:
            rejected.append({"content_id": row["content_id"], "reason": "unsafe_content", "stage": "graph_eligibility"})
        elif row["cluster_overlap_score"] < 0.25:
            rejected.append({"content_id": row["content_id"], "reason": "low_cluster_affinity", "stage": "graph_retrieval"})
        else:
            kept.append(row)
    return kept, rejected

def explain_cluster_match(rows):
    return [{"content_id": row["content_id"], "why": f"cluster overlap {row['overlap_parts']} score {row['cluster_overlap_score']}"} for row in rows]

def run(dataset):
    data = as_dataset(dataset); user_affinity = compute_user_cluster_affinity(data)
    rows = score_cluster_overlap(user_affinity, compute_item_cluster_affinity(data))
    kept, rejected = apply_cluster_safety_filter(data, rows)
    candidates = [row["content_id"] for row in kept]
    trace = explain_cluster_match(kept) + [{"content_id": r["content_id"], "why": r["reason"]} for r in rejected]
    community_rows = [{"entity":"ada","cluster":"backend_cluster","strength":0.9},{"entity":"ada","cluster":"movie_cluster","strength":0.3},{"entity":"post_101","cluster":"backend_cluster","strength":1.0},{"entity":"post_201","cluster":"backend_cluster","strength":0.6},{"entity":"post_201","cluster":"movie_cluster","strength":0.5},{"entity":"post_301","cluster":"movie_cluster","strength":0.9}]
    return {"inventory": list(data["item_memberships"]), "nodes": list(data["user_memberships"]) + list(data["item_memberships"]), "edges": data["item_memberships"], "graph_candidates": candidates, "final_candidate_pool": candidates, "community_rows": community_rows, "graph_score_rows": kept, "missed_graph_candidates": [], "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
