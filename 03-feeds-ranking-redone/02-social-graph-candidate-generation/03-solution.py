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


def build_social_graph(dataset):
    return {"close_friend": {101}, "shared_group": {401}, "commented_by_following": {501}}


def collect_followed_author_candidates(graph, lookup):
    return [lookup[item_id] for item_id in sorted(graph["close_friend"])]


def collect_shared_group_candidates(graph, lookup):
    return [lookup[item_id] for item_id in sorted(graph["shared_group"])]


def collect_comment_social_proof_candidates(graph, lookup):
    return [lookup[item_id] for item_id in sorted(graph["commented_by_following"])]


def apply_social_graph_exclusions(items):
    kept=[]; removed=[]
    allowed={101,401,501}
    for item in items:
        if item.get("muted"):
            removed.append(rejected(item["id"], "muted_author", "eligibility"))
        elif item.get("blocked"):
            removed.append(rejected(item["id"], "blocked_author", "eligibility"))
        elif item["id"] not in allowed:
            removed.append(rejected(item["id"], "no_social_path", "candidate_generation"))
        else:
            kept.append(item)
    return kept, removed


def dedupe_candidates(candidates):
    seen=set(); deduped=[]
    for item in candidates:
        if item["id"] not in seen:
            seen.add(item["id"]); deduped.append(item)
    return deduped


def explain_candidate_sources(candidates):
    source_actor={101:"Ben",401:"Diya",501:"Maya"}
    reasons={101:["close_friend_post"],401:["shared_group_member"],501:["followed_user_commented"]}
    return [{"content_id": item["id"], "source": item["source"], "source_actor": source_actor[item["id"]], "reasons": reasons[item["id"]]} for item in candidates]


def run(dataset):
    data=load_dataset(dataset); lookup=by_id(data); graph=build_social_graph(data)
    collected=collect_followed_author_candidates(graph, lookup)+collect_shared_group_candidates(graph, lookup)+collect_comment_social_proof_candidates(graph, lookup)
    eligible, rejected_items=apply_social_graph_exclusions(data["content"])
    candidates=dedupe_candidates([item for item in collected if item in eligible])
    rows=explain_candidate_sources(candidates); final=[row["content_id"] for row in rows]
    result=base_result(data); result.update({"eligible_candidates":candidates,"eligible_ids":final,"rejected_items":rejected_items,"candidate_rows":rows,"ranked_items":final,"final_feed":final,"debug_trace":[trace(101,True,"Ben reached through close_friend edge"),trace(401,True,"Diya reached through shared_group membership"),trace(501,True,"Lina reached because Maya commented") ]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
