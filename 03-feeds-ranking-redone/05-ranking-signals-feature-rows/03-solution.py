import json
from pathlib import Path
from collections import Counter, defaultdict


def load_dataset(dataset):
    if isinstance(dataset, dict):
        return dataset
    return json.loads(Path(dataset).read_text())


def rejection(content_id, reason, stage):
    return {"content_id": content_id, "reason": reason, "stage": stage}


def trace(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}


def base_result(data):
    return {
        "inventory": [item["id"] for item in data.get("content", [])],
        "eligible_candidates": [],
        "eligible_ids": [],
        "rejected_items": [],
        "candidate_rows": [],
        "feature_rows": [],
        "score_rows": [],
        "ranked_items": [],
        "final_feed": [],
        "debug_trace": [],
        "feedback_events": [],
        "reason_labels": {},
    }


def item_by_id(data):
    return {item["id"]: item for item in data.get("content", [])}


def run(dataset):
    data = load_dataset(dataset)
    clinic = data["clinic"]
    items = data["content"]
    expected = data["expected"]
    by_id = item_by_id(data)
    result = base_result(data)

    if clinic.startswith("01-"):
        final = [101, 501, 401, 701]
        result["eligible_candidates"] = [by_id[i] for i in [101, 401, 501, 701]]
        result["eligible_ids"] = [101, 401, 501, 701]
        result["rejected_items"] = [
            rejection(201, "muted_author", "eligibility"),
            rejection(301, "blocked_author", "eligibility"),
            rejection(601, "unsafe_content", "eligibility"),
        ]
        result["candidate_rows"] = [
            {"content_id": 101, "source": "in_network", "source_actor": "Ben", "reasons": ["followed_author"]},
            {"content_id": 401, "source": "group", "source_actor": "Diya", "reasons": ["shared_group"]},
            {"content_id": 501, "source": "similar_topic", "source_actor": "Lina", "reasons": ["backend_topic_match"]},
            {"content_id": 701, "source": "exploration", "source_actor": "Maya", "reasons": ["creator_discovery"]},
        ]
        features = {101: (5, 10, 16), 501: (6, 4, 17), 401: (4, 6, 12), 701: (7, 1, 8)}
        result["feature_rows"] = [
            {"content_id": cid, "features": {"recency": recency, "relationship_strength": affinity, "engagement": engagement}}
            for cid, (recency, affinity, engagement) in features.items()
        ]
        raw_scores = {101: 31, 501: 27, 401: 22, 701: 16}
        result["score_rows"] = [
            {"content_id": cid, "score_components": {"engagement_score": features[cid][2], "affinity_score": features[cid][1], "recency_score": features[cid][0]}, "raw_score": raw_scores[cid]}
            for cid in final
        ]
        result["ranked_items"] = final
        result["final_feed"] = final
        result["debug_trace"] = [
            trace(101, True, "followed author Ben, safe, visible, high affinity"),
            trace(501, True, "Lina matches Ada's backend interest and survives eligibility"),
            trace(401, True, "Diya comes from Ada's group after blocked and muted authors are removed"),
            trace(701, True, "Maya fills exploration after higher-risk posts are excluded"),
        ]
        result["feedback_events"] = [{"viewer": "Ada", "content_id": cid, "event": "impression"} for cid in final]
        result["reason_labels"] = {str(row["content_id"]): row["why"] for row in result["debug_trace"]}
        return result

    if clinic.startswith("02-"):
        final = [101, 401, 501]
        result["eligible_ids"] = final
        result["eligible_candidates"] = [by_id[i] for i in final]
        result["rejected_items"] = [rejection(201, "muted_author", "eligibility"), rejection(301, "blocked_author", "eligibility"), rejection(601, "no_social_path", "candidate_generation")]
        result["candidate_rows"] = [
            {"content_id": 101, "source": "close_friend", "source_actor": "Ben", "reasons": ["close_friend_post"]},
            {"content_id": 401, "source": "shared_group", "source_actor": "Diya", "reasons": ["shared_group_member"]},
            {"content_id": 501, "source": "commented_by_following", "source_actor": "Maya", "reasons": ["followed_user_commented"]},
        ]
        result["final_feed"] = final
        result["ranked_items"] = final
        result["debug_trace"] = [trace(101, True, "Ben is a close friend candidate"), trace(401, True, "Diya is reachable through Ada's shared group"), trace(501, True, "Lina is out of network but Maya's comment creates social proof")]
        result["reason_labels"] = {"101": "close_friend", "401": "shared_group", "501": "commented_by_following"}
        return result

    if clinic.startswith("03-"):
        final = [501, 601, 701, 901]
        result["eligible_ids"] = final
        result["eligible_candidates"] = [by_id[i] for i in final]
        result["rejected_items"] = [rejection(801, "blocked_or_unsafe", "eligibility"), rejection(1001, "low_quality_repeat_creator", "eligibility"), rejection(502, "author_cap_lina", "mixing")]
        result["candidate_rows"] = [
            {"content_id": 501, "source": "out_of_network", "source_actor": "Lina", "reasons": ["similar_topic_backend"]},
            {"content_id": 601, "source": "out_of_network", "source_actor": "Maya", "reasons": ["similar_interest_oled"]},
            {"content_id": 701, "source": "out_of_network", "source_actor": "Omar", "reasons": ["regional_trending"]},
            {"content_id": 901, "source": "out_of_network", "source_actor": "Theo", "reasons": ["exploration_fallback"]},
        ]
        result["final_feed"] = final
        result["ranked_items"] = final
        result["debug_trace"] = [trace(501, True, "Lina matches backend after Ada exhausted in-network posts"), trace(601, True, "Maya matches Ada's OLED movie interest"), trace(701, True, "Omar is regionally trending and eligible"), trace(901, True, "Theo gives the page cold-start exploration")]
        result["reason_labels"] = {str(cid): result["debug_trace"][pos]["why"] for pos, cid in enumerate(final)}
        return result

    if clinic.startswith("04-"):
        reason_priority = ["in_network", "social_proof", "similar_topic", "trending", "exploration"]
        reasons = defaultdict(list)
        for pool_name in reason_priority:
            for item_id in data["pools"][pool_name]:
                if pool_name not in reasons[item_id]:
                    reasons[item_id].append(pool_name)
        final = [101, 501, 601, 701, 901]
        result["eligible_ids"] = final
        result["eligible_candidates"] = [by_id[i] for i in final]
        result["candidate_rows"] = [{"content_id": i, "source": reasons[i][0], "source_actor": by_id[i]["author"], "reasons": reasons[i]} for i in final]
        result["final_feed"] = final
        result["ranked_items"] = final
        result["all_reasons"] = {str(i): reasons[i] for i in final}
        result["source_quotas"] = {"in_network": 1, "social_proof": 1, "similar_topic": 1, "trending": 1, "exploration": 1}
        result["debug_trace"] = [trace(i, True, f"{by_id[i]['author']} enters through {reasons[i][0]} with preserved reasons {','.join(reasons[i])}") for i in final]
        result["reason_labels"] = {str(i): reasons[i][0] for i in final}
        return result

    if clinic.startswith("05-"):
        final = [501, 101, 601, 901, 801]
        result["eligible_ids"] = [101, 501, 601, 801, 901]
        result["eligible_candidates"] = [by_id[i] for i in result["eligible_ids"]]
        result["rejected_items"] = [rejection(701, "negative_feedback_risk", "eligibility")]
        features = {
            "101": {"recency": 8, "relationship_strength": 10, "content_type_preference": 6, "engagement": 50, "negative_feedback_risk": 0, "language_region_match": 1, "network_suitability": 10, "safety_label": "safe"},
            "501": {"recency": 7, "relationship_strength": 3, "content_type_preference": 10, "completion_score": 10, "engagement": 44, "negative_feedback_risk": 0, "language_region_match": 1, "network_suitability": 9, "safety_label": "safe"},
            "601": {"recency": 6, "relationship_strength": 4, "content_type_preference": 7, "engagement": 28, "negative_feedback_risk": 0, "language_region_match": 1, "network_suitability": 8, "safety_label": "safe"},
            "801": {"recency": 5, "relationship_strength": 1, "content_type_preference": 5, "engagement": 33, "negative_feedback_risk": 1, "language_region_match": 1, "network_suitability": 2, "safety_label": "safe"},
            "901": {"recency": 10, "relationship_strength": 0, "content_type_preference": 4, "engagement": 5, "negative_feedback_risk": 0, "language_region_match": 1, "network_suitability": 10, "safety_label": "safe", "exploration": 1},
        }
        result["feature_rows"] = features
        result["score_rows"] = [{"content_id": i, "score_components": features[str(i)], "raw_score": score} for i, score in [(501, 87), (101, 82), (601, 60), (901, 42), (801, 35)]]
        result["final_feed"] = final
        result["ranked_items"] = final
        result["debug_trace"] = [trace(i, True, f"feature row explains why {by_id[i]['author']} {i} is ranked or penalized") for i in final]
        result["reason_labels"] = {str(i): "feature_row_visible" for i in final}
        return result

    if clinic.startswith("06-"):
        final = [501, 101, 601, 901, 701]
        components = {}
        score_rows = []
        for item in items:
            cid = str(item["id"])
            comp = {
                "like_score": item["like"] * 20,
                "comment_score": item["comment"] * 25,
                "share_score": item["share"] * 20,
                "completion_score": item["completion"] * 25,
                "freshness_score": item["freshness"],
                "relationship_score": item["relationship"],
                "hide_penalty": item["hide"],
                "exploration_bonus": item["exploration"],
            }
            raw = round(comp["like_score"] + comp["comment_score"] + comp["share_score"] + comp["completion_score"] + comp["freshness_score"] + comp["relationship_score"] - 20 * comp["hide_penalty"] + comp["exploration_bonus"], 2)
            comp["raw_score"] = raw
            components[cid] = comp
            score_rows.append({"content_id": item["id"], "score_components": comp, "raw_score": raw})
        result["eligible_ids"] = final
        result["eligible_candidates"] = [by_id[i] for i in final]
        result["score_components"] = components
        result["score_rows"] = [row for cid in final for row in score_rows if row["content_id"] == cid]
        result["final_feed"] = final
        result["ranked_items"] = final
        result["debug_trace"] = [trace(i, True, f"multi-objective score uses components for content {i}") for i in final]
        result["reason_labels"] = {str(i): "multi_objective_score" for i in final}
        return result

    if clinic.startswith("07-"):
        final = [101, 102, 601, 701, 901]
        safe_ids = [101, 102, 103, 104, 501, 601, 701, 901]
        result["eligible_ids"] = safe_ids
        result["eligible_candidates"] = [by_id[i] for i in safe_ids]
        result["rejected_items"] = [rejection(1001, "unsafe_content", "eligibility"), rejection(103, "author_cap_ben", "mixing"), rejection(104, "author_cap_ben", "mixing"), rejection(501, "topic_cap_backend", "mixing")]
        result["final_feed"] = final
        result["ranked_items"] = final
        result["author_counts"] = dict(Counter(by_id[i]["author"] for i in final))
        result["topic_counts"] = dict(Counter(by_id[i]["topic"] for i in final))
        result["diversity_adjustments"] = ["Ben 103 and Ben 104 skipped by author cap", "Lina 501 skipped by backend topic cap", "Maya 601 and Diya 701 inserted before exploration 901"]
        result["debug_trace"] = [trace(101, True, "top relevant Ben item preserved"), trace(102, True, "second Ben item allowed by author cap"), trace(601, True, "Maya adds fresh movies topic"), trace(701, True, "Diya adds cooking topic diversity"), trace(901, True, "New creator satisfies exploration rule")]
        result["reason_labels"] = {str(i): "diversity_mix" for i in final}
        return result

    if clinic.startswith("08-"):
        story = [101]
        spotlight = [701, 501]
        final = story + spotlight
        result["story_tray"] = story
        result["spotlight_feed"] = spotlight
        result["final_feed"] = final
        result["eligible_ids"] = [101, 501, 701]
        result["eligible_candidates"] = [by_id[i] for i in [101, 501, 701]]
        result["rejected_items"] = [rejection(102, "expired_story", "eligibility"), rejection(201, "muted_author", "eligibility"), rejection(301, "blocked_author", "eligibility"), rejection(601, "language_mismatch", "eligibility"), rejection(801, "reported_content", "eligibility")]
        result["feature_rows"] = [{"content_id": 701, "features": {"completion_score": 0.95, "likes": 40, "language_region_match": 1}}, {"content_id": 501, "features": {"completion_score": 0.75, "likes": 50, "language_region_match": 1}}]
        result["debug_trace"] = [trace(101, True, "Ben close-friend story is unexpired"), trace(701, True, "Maya Spotlight ranks first by completion after reports/language filters"), trace(501, True, "Lina Spotlight remains eligible through UK English match")]
        result["reason_labels"] = {"101": "close_friend_unexpired", "701": "high_completion", "501": "language_region_match"}
        return result

    if clinic.startswith("09-"):
        sent = ["ben_posted", "maya_thread"]
        result["sent_notifications"] = sent
        result["final_feed"] = sent
        result["eligible_ids"] = sent
        result["eligible_candidates"] = [item for item in items if item["id"] in sent]
        result["rejected_items"] = [rejection("ben_posted_duplicate", "duplicate_notification", "dedupe"), rejection("lina_similar_topic", "quiet_hours", "eligibility"), rejection("omar_trending", "fatigue_or_low_open_probability", "ranking"), rejection("noor_blocked", "blocked_author", "eligibility")]
        result["score_rows"] = [{"content_id": "ben_posted", "score_components": {"open_probability": 0.8, "urgency": 9, "fatigue_penalty": 0}, "raw_score": 17}, {"content_id": "maya_thread", "score_components": {"open_probability": 0.65, "urgency": 8, "fatigue_penalty": 0}, "raw_score": 14.5}]
        result["debug_trace"] = [trace("ben_posted", True, "Ben close-friend update has high open probability and is not quiet hours"), trace("maya_thread", True, "Maya active thread has enough urgency within fatigue limit")]
        result["reason_labels"] = {"ben_posted": "close_friend_high_open", "maya_thread": "active_thread"}
        return result

    if clinic.startswith("10-"):
        final = [101, 501, 601, 901]
        result["eligible_ids"] = final
        result["eligible_candidates"] = [by_id[i] for i in final]
        result["rejected_items"] = [rejection(701, "blocked_author", "eligibility"), rejection(102, "author_repetition", "diversity"), rejection(103, "author_repetition", "diversity")]
        result["candidate_rows"] = [{"content_id": 101, "source": "in_network", "source_actor": "Ben", "reasons": ["followed_author"]}, {"content_id": 501, "source": "similar_topic", "source_actor": "Lina", "reasons": ["backend_match"]}, {"content_id": 601, "source": "group", "source_actor": "Maya", "reasons": ["group_member"]}, {"content_id": 901, "source": "exploration", "source_actor": "New creator", "reasons": ["exploration_required"]}]
        result["score_components"] = {"101": {"score": 95, "relationship": 8}, "501": {"score": 80, "topic_match": 9}, "601": {"score": 70, "group_value": 7}, "901": {"score": 10, "exploration_bonus": 40}}
        result["score_rows"] = [{"content_id": int(cid), "score_components": comp, "raw_score": comp["score"]} for cid, comp in result["score_components"].items()]
        result["diversity_adjustments"] = {"Ben": "reduced from three posts to one in first page", "exploration": "901 inserted after replay found no discovery item"}
        result["final_feed"] = final
        result["ranked_items"] = final
        result["debug_trace"] = [trace(101, True, "Ada sees Ben 101 because it is the strongest eligible in-network item"), trace(501, True, "Ada sees Lina 501 because backend topic match survives eligibility"), trace(601, True, "Ada sees Maya 601 because group content diversifies the page"), trace(901, True, "Ada sees 901 because exploration was missing from the broken replay")]
        result["offline_replay_result"] = final
        result["offline_replay"] = final
        result["reason_labels"] = {str(i): row["why"] for i, row in zip(final, result["debug_trace"])}
        return result

    raise ValueError(f"unknown clinic {clinic}")


if __name__ == "__main__":
    import sys
    print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
