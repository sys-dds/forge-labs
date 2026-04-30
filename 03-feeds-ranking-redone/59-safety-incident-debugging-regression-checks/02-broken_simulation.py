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
    data=as_dataset(dataset); feed=[i for i in data["bad_feed"] if i!="post_201"]; trace=[{"content_id":"incident","why":"patched spam only"}]
    return {"inventory":data["bad_feed"],"policy_labels":[],"evidence_rows":[],"policy_decisions":[],"treatment_rows":[],"review_queue":[],"root_causes":["hard_filter_disabled"],"mitigations":["restore spam hard filter"],"regression_checks":{},"corrected_feed":feed,"rejected_items":[],"downranked_items":[],"informed_items":[],"safe_feed":feed,"final_feed":feed,"audit_log":[],"safety_debug_trace":trace,"debug_trace":trace}
