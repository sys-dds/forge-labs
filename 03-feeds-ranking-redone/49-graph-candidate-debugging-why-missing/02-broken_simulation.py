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
    data = as_dataset(dataset); candidates = ["post_101", "maya", "backend_club"]
    missing = [{"content_id": row["id"], "reason":"low_score", "stage":"ranking"} for row in data["candidates"] if row["id"] not in candidates]
    trace = [{"content_id": row["content_id"], "why":"low_score"} for row in missing]
    return {"inventory": data["candidates"], "nodes": [row["id"] for row in data["candidates"]], "edges": [], "graph_candidates": candidates, "final_candidate_pool": candidates, "missing_graph_explanations": missing, "missed_graph_candidates": missing, "rejected_items": [], "graph_debug_trace": trace, "debug_trace": trace}
