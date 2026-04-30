import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def load_policy_cases(data): return data["cases"]
def build_original_decision_snapshot(case): return {"case":case["case"],"original_decision":case["original"],"evidence_snapshot":case["evidence"]}
def evaluate_appeal_evidence(case): return case["appeal"]
def decide_uphold_or_reverse(case): return "reverse" if case["final"].startswith(("reversed","restored")) else "uphold"
def build_reversal_rows(cases): return [{"case":c["case"],"content_id":c["content_id"],"reason":c["final"]} for c in cases if decide_uphold_or_reverse(c)=="reverse"]
def build_audit_log(cases): return [{**build_original_decision_snapshot(c),"reviewer_decision":decide_uphold_or_reverse(c),"final_decision":c["final"],"reason":c["evidence"] if c["final"]!="restored_after_creator_evidence" else "creator_evidence"} for c in cases]
def run(dataset):
    data=as_dataset(dataset); cases=load_policy_cases(data); reversals=build_reversal_rows(cases); upheld=[{"case":c["case"],"reason":c["final"]} for c in cases if decide_uphold_or_reverse(c)=="uphold"]; audit=build_audit_log(cases); trace=[{"content_id":c["content_id"],"why":f"{c['case']} {c['final']} original {c['original']}"} for c in cases]
    return {"inventory":cases,"policy_labels":[],"evidence_rows":audit,"policy_decisions":audit,"treatment_rows":audit,"review_queue":[],"appeal_rows":reversals,"reversal_rows":reversals,"upheld_rows":upheld,"rejected_items":[],"downranked_items":[],"informed_items":[],"safe_feed":[],"final_feed":[],"audit_log":audit,"safety_debug_trace":trace,"debug_trace":trace}
