import json
from pathlib import Path
from collections import Counter, defaultdict


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def read_candidate_pools(dataset): return dataset["pools"]

def merge_candidate_reasons(pools):
    reasons=defaultdict(list)
    for source in ["in_network","social_proof","similar_topic","trending","exploration"]:
        for item_id in pools[source]:
            if source not in reasons[item_id]: reasons[item_id].append(source)
    return reasons

def choose_primary_reason(reasons):
    priority={"in_network":0,"social_proof":1,"similar_topic":2,"trending":3,"exploration":4}
    return sorted(reasons, key=lambda source: priority[source])[0]

def apply_source_quotas(reason_map, lookup):
    page=[]; used=set()
    for source in ["in_network","social_proof","similar_topic","trending","exploration"]:
        choices=[item_id for item_id,reasons in reason_map.items() if source in reasons and item_id not in used]
        if choices:
            chosen=sorted(choices, key=lambda item_id: -lookup[item_id]["score"])[0]
            page.append(chosen); used.add(chosen)
    return page

def build_mixed_page(dataset):
    lookup=by_id(dataset); reason_map=merge_candidate_reasons(read_candidate_pools(dataset)); page=apply_source_quotas(reason_map, lookup)
    return page, reason_map

def run(dataset):
    data=load_dataset(dataset); lookup=by_id(data); final, reason_map=build_mixed_page(data)
    rows=[{"content_id":i,"source":choose_primary_reason(reason_map[i]),"source_actor":lookup[i]["author"],"reasons":reason_map[i]} for i in final]
    result=base_result(data); result.update({"eligible_candidates":[lookup[i] for i in final],"eligible_ids":final,"candidate_rows":rows,"ranked_items":final,"final_feed":final,"all_reasons":{str(i):reason_map[i] for i in final},"source_quotas":{"in_network":1,"social_proof":1,"similar_topic":1,"trending":1,"exploration":1},"debug_trace":[trace(i,True,f"{lookup[i]['author']} uses {choose_primary_reason(reason_map[i])} with preserved reasons {','.join(reason_map[i])}") for i in final]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
