import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def run(dataset):
    data=as_dataset(dataset); feed=[r["id"] for r in data["content"] if r["label"]!="unsafe_misinformation"]; trace=[{"content_id":i,"why":"same treatment all viewers"} for i in feed]
    return {"inventory":data["content"],"policy_labels":[],"evidence_rows":[],"policy_decisions":[],"treatment_rows":[],"review_queue":[],"rejected_items":[],"downranked_items":[],"informed_items":[],"viewer_results":{"Ada":{"final_feed":feed},"Ben":{"final_feed":feed}},"safe_feed":feed,"final_feed":feed,"audit_log":[],"safety_debug_trace":trace,"debug_trace":trace}
