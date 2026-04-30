import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def classify_safety_label(row): return row["label"]
def apply_hard_filters(row): return row["label"] in {"blocked_author","spam"}
def route_to_review_queue(row): return row["label"] == "reported_once"
def apply_downranking(row): return 40 if row["label"] == "borderline_clickbait" else 0
def apply_sensitive_content_treatment(row): return row["label"] == "sensitive_allowed"
def build_safety_decision_trace(item_id, decision): return trace(item_id, True, f"safety decision for {item_id}: {decision}")
def run(dataset_path):
    data=load_dataset(dataset_path); kept=[]; rejected_rows=[]; review=[]; downranked=[]; decisions=[]
    for row in data["content"]:
        label=classify_safety_label(row)
        if apply_hard_filters(row): rejected_rows.append(rejection(row["id"],"blocked_author" if label=="blocked_author" else "spam_hard_filter","eligibility")); decisions.append({"content_id":row["id"],"decision":"hard_filter"})
        elif route_to_review_queue(row): review.append({"content_id":row["id"],"reason":"review_reported_content"}); decisions.append({"content_id":row["id"],"decision":"review_queue"})
        else:
            adjusted=row["score"]-apply_downranking(row); kept.append((row,adjusted)); decisions.append({"content_id":row["id"],"decision":"downrank" if apply_downranking(row) else "rank"});
            if apply_downranking(row): downranked.append({"content_id":row["id"],"reason":"borderline_clickbait"})
    final=[row["id"] for row,score in sorted(kept, key=lambda pair:-pair[1])]
    return {"inventory":inventory(data),"eligible_candidates":[row for row,score in kept],"rejected_items":rejected_rows,"review_queue":review,"downranked":downranked,"safety_decisions":decisions,"final_feed":final,"debug_trace":[build_safety_decision_trace(i,"ranked or treated") for i in final]}
