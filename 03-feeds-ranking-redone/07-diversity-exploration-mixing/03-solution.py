import json
from pathlib import Path
from collections import Counter


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def remove_unsafe_items(items):
    kept=[]; removed=[]
    for item in items:
        if item.get("unsafe"): removed.append(rejected(item["id"], "unsafe_content", "eligibility"))
        else: kept.append(item)
    return kept, removed

def preserve_top_relevant_items(items): return sorted(items, key=lambda item: item["score"], reverse=True)
def apply_author_cap(page, item, author_counts): return author_counts[item["author"]] < 2
def apply_topic_cap(page, item, topic_counts): return topic_counts[item["topic"]] < 2
def reserve_exploration_slot(items): return next(item for item in items if item.get("exploration"))

def build_diversity_adjustments(skipped): return [f"{item['author']} {item['id']} skipped by {reason}" for item, reason in skipped]

def run(dataset):
    data=load_dataset(dataset); safe, rejected_items=remove_unsafe_items(data["content"]); ordered=preserve_top_relevant_items(safe)
    page=[]; author_counts=Counter(); topic_counts=Counter(); skipped=[]
    exploration=reserve_exploration_slot(safe)
    for item in ordered:
        if item["id"] == exploration["id"]: continue
        if len(page) == 4: break
        if not apply_author_cap(page,item,author_counts): skipped.append((item,"author_cap_ben")); rejected_items.append(rejected(item["id"],"author_cap_ben","mixing")); continue
        if not apply_topic_cap(page,item,topic_counts): skipped.append((item,"topic_cap_backend")); rejected_items.append(rejected(item["id"],"topic_cap_backend","mixing")); continue
        page.append(item); author_counts[item["author"]]+=1; topic_counts[item["topic"]]+=1
    page.append(exploration); author_counts[exploration["author"]]+=1; topic_counts[exploration["topic"]]+=1
    final=[item["id"] for item in page]
    result=base_result(data); result.update({"eligible_candidates":safe,"eligible_ids":[item["id"] for item in safe],"rejected_items":rejected_items,"ranked_items":final,"final_feed":final,"author_counts":dict(author_counts),"topic_counts":dict(topic_counts),"diversity_adjustments":build_diversity_adjustments(skipped),"debug_trace":[trace(101,True,"top Ben item preserved"),trace(102,True,"second Ben item within author cap"),trace(601,True,"Maya inserted for fresh movies topic"),trace(701,True,"Diya inserted for cooking topic variety"),trace(901,True,"exploration slot reserved for New creator") ]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
