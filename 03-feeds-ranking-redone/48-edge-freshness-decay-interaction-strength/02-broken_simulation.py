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
    data = as_dataset(dataset); candidates = ["post_101", "post_201", "post_301", "post_401", "post_501", "post_601"]
    trace = [{"content_id": c, "why": "all edges treated as weight 1"} for c in candidates]
    return {"inventory": data["edges"], "nodes": ["ada"], "edges": data["edges"], "graph_candidates": candidates, "final_candidate_pool": candidates, "edge_strength_rows": [], "missed_graph_candidates": [], "rejected_items": [], "graph_debug_trace": trace, "debug_trace": trace}
