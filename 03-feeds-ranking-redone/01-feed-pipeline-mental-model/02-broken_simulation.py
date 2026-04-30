import json
from pathlib import Path

def load_dataset(dataset):
    if isinstance(dataset, dict):
        return dataset
    return json.loads(Path(dataset).read_text())

def content_id(item):
    return item["id"]

def run(dataset):
    data = load_dataset(dataset)
    items = data["content"]
    clinic = data["clinic"]

    if clinic.startswith("04-"):
        ids = []
        for pool_name in ["in_network", "social_proof", "similar_topic", "trending", "exploration"]:
            ids.extend(data["pools"][pool_name])
        return {"final_feed": ids[:5], "eligible_ids": ids, "reason_labels": {}, "feedback_log": [], "debug_trace": {}}

    if clinic.startswith("09-"):
        sent = [item["id"] for item in items]
        return {"final_feed": sent, "sent_notifications": sent, "eligible_ids": sent, "reason_labels": {}, "debug_trace": {}}

    if clinic.startswith("08-"):
        story = [item["id"] for item in items if item.get("surface") == "story"]
        spotlight = [item["id"] for item in sorted([i for i in items if i.get("surface") == "spotlight"], key=lambda row: row.get("likes", 0), reverse=True)]
        return {"story_tray": story, "spotlight_feed": spotlight, "final_feed": story + spotlight[:2], "eligible_ids": story + spotlight, "reason_labels": {}, "debug_trace": {}}

    ordered = sorted(items, key=lambda row: row.get("score", row.get("engagement", row.get("likes", row.get("like", 0)))), reverse=True)
    final = [content_id(item) for item in ordered[:5]]
    return {"final_feed": final, "eligible_ids": final, "reason_labels": {}, "feedback_log": [], "debug_trace": {}, "score_components": {}}

if __name__ == "__main__":
    import sys
    print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
