import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def compute_edge_age(edge):
    return edge["age_days"]

def apply_time_decay(edge):
    if edge["type"] in {"block", "mute"}:
        return 0.0
    decay = max(0.2, 1.0 - edge["age_days"] / 250.0)
    return round(decay, 2)

def compute_interaction_strength(edge):
    strength = edge["base_weight"] * apply_time_decay(edge)
    if edge["type"] == "view":
        strength *= 0.4
    return round(strength, 3)

def apply_hard_edge_exclusions(data):
    rejected = []
    usable = []
    for edge in data["edges"]:
        if edge["type"] == "block": rejected.append({"content_id": edge["post"], "reason":"blocked_author", "stage":"graph_eligibility"})
        elif edge["type"] == "mute": rejected.append({"content_id": edge["post"], "reason":"muted_author", "stage":"graph_eligibility"})
        else: usable.append(edge)
    return usable, rejected

def rank_candidates_by_edge_strength(edges):
    rows = []
    for edge in edges:
        rows.append({"content_id": edge["post"], "person": edge["to"], "edge_type": edge["type"], "age_days": edge["age_days"], "strength": compute_interaction_strength(edge)})
    return sorted(rows, key=lambda row: (-row["strength"], row["content_id"]))

def explain_edge_strength(rows):
    return [{"content_id": row["content_id"], "why": f"{row['edge_type']} to {row['person']} strength {row['strength']} after age {row['age_days']}"} for row in rows]

def run(dataset):
    data = as_dataset(dataset); usable, rejected = apply_hard_edge_exclusions(data)
    rows = rank_candidates_by_edge_strength(usable)
    candidates = [row["content_id"] for row in rows]
    trace = explain_edge_strength(rows) + [{"content_id": r["content_id"], "why": r["reason"]} for r in rejected]
    return {"inventory": data["edges"], "nodes": ["ada"], "edges": data["edges"], "graph_candidates": candidates, "final_candidate_pool": candidates, "edge_strength_rows": rows, "graph_score_rows": rows, "missed_graph_candidates": [], "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
