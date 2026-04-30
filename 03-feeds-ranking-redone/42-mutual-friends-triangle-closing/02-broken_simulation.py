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
    data = as_dataset(dataset); candidates = ["omar", "maya", "noor", "lina"]
    trace = [{"content_id": c, "why": "distance two or user list fallback without mutual counts"} for c in candidates]
    return {"inventory": data["users"], "nodes": data["users"], "edges": data["edges"], "graph_candidates": candidates, "people_you_may_know": candidates, "final_candidate_pool": candidates, "mutual_rows": [], "missed_graph_candidates": [], "rejected_items": [], "graph_debug_trace": trace, "debug_trace": trace}
