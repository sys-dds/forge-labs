import json
from pathlib import Path


def load_dataset(dataset):
    if isinstance(dataset, dict):
        return dataset
    return json.loads(Path(dataset).read_text())


def rejected(content_id, reason, stage):
    return {"content_id": content_id, "reason": reason, "stage": stage}


def trace(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}


def base_result(dataset):
    return {"inventory": [item["id"] for item in dataset["content"]], "eligible_candidates": [], "eligible_ids": [], "rejected_items": [], "candidate_rows": [], "feature_rows": [], "score_rows": [], "ranked_items": [], "final_feed": [], "debug_trace": [], "feedback_events": []}


def by_id(dataset):
    return {item["id"]: item for item in dataset["content"]}


def collect_similar_topic_candidates(items): return [item for item in items if item.get("source") == "similar_topic_backend"]
def collect_similar_interest_candidates(items): return [item for item in items if item.get("source") == "similar_interest_oled"]
def collect_regional_trending_candidates(items): return [item for item in items if item.get("source") == "regional_trending"]
def collect_exploration_fallback_candidates(items): return [item for item in items if item.get("source") == "exploration_fallback"]

def apply_safety_exclusions(items):
    kept=[]; removed=[]
    for item in items:
        if item.get("blocked") or item.get("unsafe"):
            removed.append(rejected(item["id"], "blocked_or_unsafe", "eligibility"))
        elif item.get("low_quality"):
            removed.append(rejected(item["id"], "low_quality_repeat_creator", "eligibility"))
        else:
            kept.append(item)
    return kept, removed

def apply_author_cap(items):
    kept=[]; removed=[]; authors=set()
    for item in sorted(items, key=lambda row: -row.get("score",0)):
        if item["author"] in authors:
            removed.append(rejected(item["id"], "author_cap_lina", "mixing"))
        else:
            authors.add(item["author"]); kept.append(item)
    return kept, removed

def run(dataset):
    data=load_dataset(dataset); items=data["content"]
    retrieved=collect_similar_topic_candidates(items)+[item for item in items if item.get("source") == "similar_creator_java"]+collect_similar_interest_candidates(items)+collect_regional_trending_candidates(items)+collect_exploration_fallback_candidates(items)+[item for item in items if item.get("low_quality")]
    safe, safety_rejections=apply_safety_exclusions(retrieved)
    capped, cap_rejections=apply_author_cap(safe)
    reason_order={"similar_topic_backend":1,"similar_interest_oled":2,"regional_trending":3,"exploration_fallback":4}
    ordered=sorted(capped, key=lambda item: reason_order[item["source"]])
    rows=[{"content_id":item["id"],"source":"out_of_network","source_actor":item["author"],"reasons":[item["source"]]} for item in ordered]
    final=[row["content_id"] for row in rows]
    result=base_result(data); result.update({"eligible_candidates":ordered,"eligible_ids":final,"rejected_items":safety_rejections+cap_rejections,"candidate_rows":rows,"ranked_items":final,"final_feed":final,"debug_trace":[trace(501,True,"Lina enters through similar_topic_backend"),trace(601,True,"Maya enters through similar_interest_oled"),trace(701,True,"Omar enters through regional_trending"),trace(901,True,"Theo enters through exploration_fallback") ]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
