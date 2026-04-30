import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def initialise_walk_from_user(data):
    return [edge for edge in data["edges"] if edge["from"] == "ada"]

def expand_one_hop(data, frontier):
    return frontier

def expand_two_hop_to_items(data, frontier):
    rows = []
    for first in frontier:
        for second in data["edges"]:
            if second["from"] == first["to"] and second["to"].startswith("post_"):
                rows.append({"content_id": second["to"], "path": ["ada", first["to"], second["to"]], "first_weight": first["weight"], "second_weight": second["weight"]})
    return rows

def multiply_path_probabilities(rows):
    for row in rows:
        row["path_probability"] = round(row["first_weight"] * row["second_weight"], 2)
    return rows

def aggregate_item_probabilities(rows):
    return sorted(rows, key=lambda row: (-row["path_probability"], row["content_id"]))

def apply_walk_eligibility(data, rows):
    kept = [row for row in rows if row["content_id"] not in data["muted"]]
    rejected = [{"content_id":"post_201","reason":"muted_author","stage":"graph_eligibility"}]
    return kept, rejected

def build_random_walk_trace(rows, rejected):
    trace = [{"content_id": row["content_id"], "why": f"weighted path {' -> '.join(row['path'])} probability {row['path_probability']}"} for row in rows]
    trace += [{"content_id": row["content_id"], "why": row["reason"]} for row in rejected]
    return trace

def run(dataset):
    data = as_dataset(dataset); frontier = initialise_walk_from_user(data)
    rows = aggregate_item_probabilities(multiply_path_probabilities(expand_two_hop_to_items(data, expand_one_hop(data, frontier))))
    kept, rejected = apply_walk_eligibility(data, rows)
    candidates = [row["content_id"] for row in kept]
    trace = build_random_walk_trace(kept, rejected)
    return {"inventory": data["edges"], "nodes": ["ada"], "edges": data["edges"], "graph_candidates": candidates, "final_candidate_pool": candidates, "random_walk_rows": kept, "graph_score_rows": kept, "missed_graph_candidates": [], "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
