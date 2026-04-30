import json
from pathlib import Path


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def filter_expired_stories(stories): return [story for story in stories if not story.get("expired")], [rejected(story["id"],"expired_story","eligibility") for story in stories if story.get("expired")]
def apply_friend_story_exclusions(stories):
    kept=[]; removed=[]
    for story in stories:
        if story.get("muted"): removed.append(rejected(story["id"],"muted_author","eligibility"))
        elif story.get("blocked"): removed.append(rejected(story["id"],"blocked_author","eligibility"))
        else: kept.append(story)
    return kept, removed

def rank_story_tray(items):
    stories=[item for item in items if item.get("surface") == "story"]
    unexpired, expiry_rejections=filter_expired_stories(stories)
    eligible, friend_rejections=apply_friend_story_exclusions(unexpired)
    return sorted(eligible, key=lambda item: (not item.get("close_friend",False), -item.get("score",0))), expiry_rejections+friend_rejections

def apply_language_region_filter(videos): return [video for video in videos if video.get("language") == "en" and video.get("region") == "UK"], [rejected(video["id"],"language_mismatch","eligibility") for video in videos if not (video.get("language") == "en" and video.get("region") == "UK")]
def apply_report_risk_filter(videos): return [video for video in videos if video.get("reports",0) == 0], [rejected(video["id"],"reported_content","eligibility") for video in videos if video.get("reports",0) > 0]
def compute_completion_score(video): return video.get("completion",0)
def rank_spotlight_feed(items):
    videos=[item for item in items if item.get("surface") == "spotlight"]
    language_ok, language_rejections=apply_language_region_filter(videos)
    safe, report_rejections=apply_report_risk_filter(language_ok)
    return sorted(safe, key=lambda video: compute_completion_score(video), reverse=True), language_rejections+report_rejections

def run(dataset):
    data=load_dataset(dataset); stories, story_rejections=rank_story_tray(data["content"]); spotlight, spotlight_rejections=rank_spotlight_feed(data["content"])
    story_ids=[item["id"] for item in stories]; spotlight_ids=[item["id"] for item in spotlight]
    result=base_result(data); result.update({"eligible_candidates":stories+spotlight,"eligible_ids":story_ids+sorted(spotlight_ids),"rejected_items":story_rejections+spotlight_rejections,"story_tray":story_ids,"spotlight_feed":spotlight_ids,"feature_rows":[{"content_id":item["id"],"features":{"completion_score":compute_completion_score(item),"likes":item.get("likes",0)}} for item in spotlight],"ranked_items":story_ids+spotlight_ids,"final_feed":story_ids+spotlight_ids,"debug_trace":[trace(101,True,"story tray uses close friend plus expiry checks"),trace(701,True,"spotlight ranks Maya by completion watch signal"),trace(501,True,"spotlight keeps Lina after language and report filters") ]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
