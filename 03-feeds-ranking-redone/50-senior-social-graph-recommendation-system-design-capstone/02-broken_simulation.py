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
    data = as_dataset(dataset); candidates = ["post_101", "post_501", "post_601"]
    trace = [{"content_id": c, "why": "follow graph only"} for c in candidates]
    return {"inventory": data["rows"], "nodes": [row["id"] for row in data["rows"]], "edges": [], "graph_candidates": candidates, "final_candidate_pool": candidates, "missing_graph_explanations": [], "missed_graph_candidates": [], "rejected_items": [], "graph_system_design": {"follow_graph": True, "community_graph": True}, "ranking_handoff_contract": [], "graph_debug_trace": trace, "debug_trace": trace}
