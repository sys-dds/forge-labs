import json
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def classify_policy_label(row):
    return row["label"]

def map_label_to_treatment(label):
    mapping = {"spam_scam":"remove", "harassment_violation":"remove", "borderline_clickbait":"reduce", "medical_context_needed":"inform", "uncertain_report":"review", "election_review":"review"}
    return mapping.get(label, "allow")

def build_policy_decisions(data):
    return [{"content_id": row["id"], "policy_label": classify_policy_label(row), "treatment": map_label_to_treatment(row["label"])} for row in data["content"]]

def apply_remove_reduce_inform_review_allow(decisions):
    rejected = [{"content_id": row["content_id"], "reason": row["policy_label"], "stage":"safety_policy"} for row in decisions if row["treatment"] == "remove"]
    downranked = [{"content_id": row["content_id"], "reason":"reduce_distribution", "policy_label": row["policy_label"]} for row in decisions if row["treatment"] == "reduce"]
    informed = [{"content_id": row["content_id"], "reason":"context_label", "policy_label": row["policy_label"]} for row in decisions if row["treatment"] == "inform"]
    review = [{"content_id": row["content_id"], "reason": row["policy_label"], "stage":"human_review"} for row in decisions if row["treatment"] == "review"]
    return rejected, downranked, informed, review

def build_safe_feed(data, decisions):
    score = {row["id"]: row["score"] for row in data["content"]}
    allowed = [row for row in decisions if row["treatment"] in {"allow", "inform", "reduce"}]
    return [row["content_id"] for row in sorted(allowed, key=lambda row: (row["treatment"] == "reduce", -score[row["content_id"]]))]

def build_policy_debug_trace(decisions):
    return [{"content_id": row["content_id"], "why": f"treatment {row['treatment']} from policy {row['policy_label']}"} for row in decisions]

def run(dataset):
    data = as_dataset(dataset); decisions = build_policy_decisions(data)
    rejected, downranked, informed, review = apply_remove_reduce_inform_review_allow(decisions)
    feed = build_safe_feed(data, decisions); trace = build_policy_debug_trace(decisions)
    return {"inventory": data["content"], "policy_labels": [d["policy_label"] for d in decisions], "evidence_rows": decisions, "policy_decisions": decisions, "treatment_rows": decisions, "review_queue": review, "rejected_items": rejected, "downranked_items": downranked, "informed_items": informed, "safe_feed": feed, "final_feed": feed, "audit_log": trace, "safety_debug_trace": trace, "debug_trace": trace}
