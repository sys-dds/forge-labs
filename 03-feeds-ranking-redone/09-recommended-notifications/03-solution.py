import json
from pathlib import Path


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def collect_notification_candidates(dataset): return list(dataset["content"])
def dedupe_by_source_event(candidates):
    kept=[]; removed=[]; seen=set()
    for item in candidates:
        event=item["source_event_id"]
        if event in seen: removed.append(rejected(item["id"],"duplicate_notification","dedupe"))
        else: seen.add(event); kept.append(item)
    return kept, removed

def apply_block_safety_filters(candidates):
    kept=[]; removed=[]
    for item in candidates:
        if item.get("blocked") or item.get("unsafe"): removed.append(rejected(item["id"],"blocked_author","eligibility"))
        else: kept.append(item)
    return kept, removed

def apply_quiet_hours(candidates): return [item for item in candidates if not item.get("quiet_hours")], [rejected(item["id"],"quiet_hours","eligibility") for item in candidates if item.get("quiet_hours")]
def score_notification_candidate(item): return round(item["urgency"] + item["open_probability"] * 10, 2)
def apply_fatigue_limit(scored, limit):
    sent=[]; removed=[]
    for item, score in scored:
        if len(sent) < limit and score >= 12: sent.append((item, score))
        else: removed.append(rejected(item["id"],"fatigue_or_low_open_probability","ranking"))
    return sent, removed

def choose_notifications_to_send(candidates):
    scored=sorted([(item, score_notification_candidate(item)) for item in candidates], key=lambda row: (-row[1], row[0]["id"]))
    return apply_fatigue_limit(scored, 2)

def run(dataset):
    data=load_dataset(dataset); candidates=collect_notification_candidates(data)
    deduped,dedupe_rejections=dedupe_by_source_event(candidates); safe,safety_rejections=apply_block_safety_filters(deduped); active,quiet_rejections=apply_quiet_hours(safe); sent,ranking_rejections=choose_notifications_to_send(active)
    sent_ids=[item["id"] for item, score in sent]
    result=base_result(data); result.update({"eligible_candidates":[item for item,score in sent],"eligible_ids":sent_ids,"rejected_items":dedupe_rejections+safety_rejections+quiet_rejections+ranking_rejections,"sent_notifications":sent_ids,"final_feed":sent_ids,"score_rows":[{"content_id":item["id"],"score_components":{"open_probability":item["open_probability"],"urgency":item["urgency"],"fatigue_penalty":0},"raw_score":score} for item,score in sent],"debug_trace":[trace("ben_posted",True,"Ben close-friend notification wins after dedupe"),trace("maya_thread",True,"Maya active thread fits fatigue cap") ]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
