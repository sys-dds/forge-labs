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
    data=as_dataset(dataset); cases=data["cases"]; trace=[{"content_id":c["content_id"],"why":"appeal upheld without snapshot"} for c in cases]
    return {"inventory":cases,"policy_labels":[],"evidence_rows":[],"policy_decisions":[],"treatment_rows":[],"review_queue":[],"appeal_rows":[],"reversal_rows":[],"upheld_rows":[{"case":c["case"],"reason":"upheld"} for c in cases],"rejected_items":[],"downranked_items":[],"informed_items":[],"safe_feed":[],"final_feed":[],"audit_log":[],"safety_debug_trace":trace,"debug_trace":trace}
