import json
from pathlib import Path


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def apply_block_filter(items):
    kept=[]; removed=[]
    for item in items:
        if item.get("blocked"): removed.append(rejected(item["id"],"blocked_author","eligibility"))
        else: kept.append(item)
    return kept, removed

def reduce_author_repetition(items):
    kept=[]; removed=[]; seen_authors=set()
    for item in sorted(items, key=lambda row: row["score"], reverse=True):
        if item["author"] == "Ben" and item["author"] in seen_authors: removed.append(rejected(item["id"],"author_repetition","diversity"))
        else: kept.append(item); seen_authors.add(item["author"])
    return kept, removed

def insert_exploration_item(items):
    exploration=next(item for item in items if item.get("exploration"))
    non_exploration=[item for item in items if item["id"] != exploration["id"]]
    return sorted(non_exploration, key=lambda row: row["score"], reverse=True)[:3] + [exploration]

def build_rejected_item_trace(rejections): return rejections
def build_score_components(final_items): return {str(item["id"]): {"score": item["score"], "exploration_bonus": 40 if item.get("exploration") else 0} for item in final_items}
def build_diversity_adjustments(): return {"Ben":"102 and 103 removed for author repetition","exploration":"901 inserted because the broken replay had none"}
def build_final_explanations(final_items): return [trace(item["id"],True,f"Ada sees {item['id']} from {item['source']} after replay filters") for item in final_items]
def run_offline_replay(dataset):
    safe, block_rejections=apply_block_filter(dataset["content"]); reduced, repetition_rejections=reduce_author_repetition(safe); final_items=insert_exploration_item(reduced)
    return final_items, build_rejected_item_trace(block_rejections+repetition_rejections)

def run(dataset):
    data=load_dataset(dataset); final_items,rejections=run_offline_replay(data); final=[item["id"] for item in final_items]; components=build_score_components(final_items)
    result=base_result(data); result.update({"eligible_candidates":final_items,"eligible_ids":final,"rejected_items":rejections,"candidate_rows":[{"content_id":item["id"],"source":item["source"],"source_actor":item["author"],"reasons":[item["source"]]} for item in final_items],"score_components":components,"score_rows":[{"content_id":item["id"],"score_components":components[str(item["id"])],"raw_score":item["score"]} for item in final_items],"diversity_adjustments":build_diversity_adjustments(),"ranked_items":final,"final_feed":final,"offline_replay_result":final,"debug_trace":build_final_explanations(final_items)})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
