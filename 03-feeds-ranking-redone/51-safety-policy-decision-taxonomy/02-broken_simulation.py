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
    data = as_dataset(dataset); feed = [row["id"] for row in data["content"]]
    decisions = [{"content_id": row["id"], "policy_label": row["label"], "treatment":"reduce"} for row in data["content"]]
    trace = [{"content_id": row["id"], "why":"all risk downranked"} for row in data["content"]]
    return {"inventory": data["content"], "policy_labels": [], "evidence_rows": [], "policy_decisions": decisions, "treatment_rows": decisions, "review_queue": [], "rejected_items": [], "downranked_items": decisions, "informed_items": [], "safe_feed": feed, "final_feed": feed, "audit_log": [], "safety_debug_trace": trace, "debug_trace": trace}
