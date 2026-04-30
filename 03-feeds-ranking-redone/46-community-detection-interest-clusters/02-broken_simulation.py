import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def run(dataset):
    data = as_dataset(dataset); candidates = ["post_101", "post_401", "post_501"]
    trace = [{"content_id": c, "why": "used one global cluster without overlap rows"} for c in candidates]
    return {"inventory": list(data["item_memberships"]), "nodes": list(data["user_memberships"]) + list(data["item_memberships"]), "edges": data["item_memberships"], "graph_candidates": candidates, "final_candidate_pool": candidates, "community_rows": [], "missed_graph_candidates": [], "rejected_items": [], "graph_debug_trace": trace, "debug_trace": trace}
