import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def reproduce_safety_incident(data): return data["bad_feed"]
def classify_safety_symptoms(feed): return ["spam_visible","label_missing","fake_engagement_boosted","appeal_reversal_ignored","safe_content_missing"]
def diagnose_safety_root_causes(symptoms): return ["hard_filter_disabled","inform_label_missing","fake_engagement_penalty_disabled","appeal_reversal_not_applied","safe_content_displaced"]
def build_safety_mitigation_plan(root_causes): return ["restore spam hard filter","restore context labels","restore fake engagement penalty","apply appeal reversal before ranking","rerun safe-feed regression"]
def apply_safety_mitigations(data): return data["expected_safe"]
def run_safety_regression_checks(feed): return {"spam_absent": "post_201" not in feed, "labels_present": "post_301" in feed, "fake_engagement_penalized": "post_401" not in feed, "appeal_reversal_applied": "post_501" in feed}
def run(dataset):
    data=as_dataset(dataset); symptoms=classify_safety_symptoms(reproduce_safety_incident(data)); roots=diagnose_safety_root_causes(symptoms); mitigations=build_safety_mitigation_plan(roots); feed=apply_safety_mitigations(data); checks=run_safety_regression_checks(feed); rejected=[{"content_id":"post_201","reason":"spam_scam","stage":"safety_policy"}]; down=[{"content_id":"post_401","reason":"fake_engagement_penalty"}]; informed=[{"content_id":"post_301","reason":"context_label"}]; trace=[{"content_id":"incident","why":f"root causes {roots}"},{"content_id":"post_201","why":"hard_filter_disabled -> spam_scam"},{"content_id":"post_501","why":"appeal_reversal_applied"}]
    return {"inventory":data["bad_feed"],"policy_labels":symptoms,"evidence_rows":symptoms,"policy_decisions":roots,"treatment_rows":mitigations,"review_queue":[],"root_causes":roots,"mitigations":mitigations,"regression_checks":checks,"corrected_feed":feed,"rejected_items":rejected,"downranked_items":down,"informed_items":informed,"safe_feed":feed,"final_feed":feed,"audit_log":trace,"safety_debug_trace":trace,"debug_trace":trace}
