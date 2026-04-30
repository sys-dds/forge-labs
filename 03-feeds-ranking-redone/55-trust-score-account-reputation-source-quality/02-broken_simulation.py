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
    data=as_dataset(dataset); feed=[a["post"] for a in sorted(data["authors"], key=lambda a:-a["followers"])] ; trace=[{"content_id":i,"why":"ranked by popularity"} for i in feed]
    return {"inventory":data["authors"],"policy_labels":[],"evidence_rows":[],"trust_score_rows":[],"risk_score_rows":[],"policy_decisions":[],"treatment_rows":[],"review_queue":[],"rejected_items":[],"downranked_items":[],"informed_items":[],"safe_feed":feed,"final_feed":feed,"audit_log":[],"safety_debug_trace":trace,"debug_trace":trace}
