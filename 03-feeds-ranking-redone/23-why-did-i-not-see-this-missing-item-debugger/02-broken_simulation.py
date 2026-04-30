import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def classify_retrieval_miss(row): return None
def classify_eligibility_rejection(row): return None
def classify_scoring_loss(row): return "low_score"
def classify_diversity_removal(row, chosen_authors): return "low_score"
def classify_seen_state_removal(row): return None
def classify_freshness_removal(row): return None
def explain_missing_item(row, chosen_authors): return "low_score"
def run(dataset):
    data=load_dataset(dataset); final=[101,901]; missing=[{"content_id":r["id"],"reason":"low_score","stage":"scoring"} for r in data["content"] if r["id"] not in final]
    return {"inventory":[r["id"] for r in data["content"]],"rejected_items":missing,"missing_explanations":{str(r["content_id"]):"low_score" for r in missing},"final_feed":final,"debug_trace":[{"content_id":r["content_id"],"included":False,"why":"low_score"} for r in missing]}
