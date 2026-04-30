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
    data=as_dataset(dataset); queue=[{"content_id":i,"reason":"raw_report_volume"} for i in sorted(data["reports"], key=lambda k:-len(data["reports"][k]))]; trace=[{"content_id":r["content_id"],"why":"raw report volume"} for r in queue]
    return {"inventory":data["reports"],"policy_labels":[],"evidence_rows":[],"reporter_reliability_rows":[],"policy_decisions":[],"treatment_rows":[],"review_queue":queue,"rejected_items":[],"downranked_items":[],"informed_items":[],"safe_feed":[],"final_feed":[],"audit_log":[],"safety_debug_trace":trace,"debug_trace":trace}
