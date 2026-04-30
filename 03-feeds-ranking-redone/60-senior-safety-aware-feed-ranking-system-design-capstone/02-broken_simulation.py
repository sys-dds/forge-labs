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
    data=as_dataset(dataset); feed=[r["id"] for r in sorted(data["candidates"],key=lambda r:-r["score"])] ; trace=[{"content_id":i,"why":"score-only safety"} for i in feed]
    return {"inventory":data["candidates"],"policy_labels":[],"evidence_rows":[],"risk_score_rows":[],"policy_decisions":[],"treatment_rows":[],"review_queue":[],"rejected_items":[],"downranked_items":[],"informed_items":[],"restored_items":[],"safe_feed":feed,"final_feed":feed,"safety_system_design":{"safety":True},"ranking_handoff_contract":[],"audit_log":[],"safety_debug_trace":trace,"debug_trace":trace}
