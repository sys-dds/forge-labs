import argparse
import json
import sys
from pathlib import Path

SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))

from assertions import assert_equal, assert_true, ids_from_rejections, trace_ids
from import_simulation import import_simulation


def check(result, data):
    expected = data["expected"]
    clinic = data["clinic"]
    base_message = expected["message"]

    if clinic.startswith("08-"):
        assert_equal(result.get("story_tray"), [101], base_message)
        assert_equal(result.get("spotlight_feed"), [701, 501], base_message)
    elif clinic.startswith("09-"):
        assert_equal(result.get("sent_notifications"), expected["final_feed"], base_message)
    else:
        assert_equal(result.get("final_feed"), expected["final_feed"], base_message)

    assert_equal(result.get("eligible_ids"), expected["eligible_ids"], f"expected eligible IDs {expected['eligible_ids']}; broken simulation used the wrong candidate/eligibility set")

    rejected = ids_from_rejections(result.get("rejected_items", {}))
    for item_id in expected.get("excluded_ids", []):
        assert_true(
            str(item_id) in rejected or (item_id not in result.get("final_feed", []) and item_id not in result.get("eligible_ids", [])),
            f"expected content ID {item_id} excluded or rejected with a reason; broken simulation allowed it into the feed path",
        )

    labels = result.get("reason_labels", {})
    traced = trace_ids(result.get("debug_trace", {}))
    for item_id in expected["final_feed"]:
        assert_true(str(item_id) in labels or item_id in labels or str(item_id) in traced, f"expected debug trace or reason label for final item {item_id}; broken simulation returned an unexplained feed item")

    assert_true(result.get("debug_trace"), f"expected debug_trace entries tied to final output {expected['final_feed']}; broken simulation did not explain the feed")

    if clinic.startswith("01-"):
        impressions = [row.get("content_id") for row in result.get("feedback_events", result.get("feedback_log", []))]
        assert_equal(impressions, expected["final_feed"], "expected feedback event impressions for [101,501,401,701]; broken simulation did not log final impressions")
        assert_equal(rejected.get("201"), "muted_author", "expected Cy 201 rejected as muted_author before scoring")
        assert_equal(rejected.get("301"), "blocked_author", "expected Noor 301 rejected as blocked_author before scoring")
        assert_equal(rejected.get("601"), "unsafe_content", "expected Omar 601 rejected as unsafe_content before scoring")
    if clinic.startswith("02-"):
        sources = {str(row.get("content_id")): row.get("source") for row in result.get("candidate_rows", [])}
        assert_equal(sources, {"101": "close_friend", "401": "shared_group", "501": "commented_by_following"}, "expected candidates 101 close_friend, 401 shared_group, 501 commented_by_following; broken generator returned the wrong social paths")
    if clinic.startswith("03-"):
        reasons = {str(row.get("content_id")): row.get("reasons", []) for row in result.get("candidate_rows", [])}
        assert_true("exploration_fallback" in reasons.get("901", []), "expected Theo 901 kept as exploration_fallback; broken retriever omitted cold-start coverage")
        authors = [row.get("source_actor") for row in result.get("candidate_rows", []) if row.get("content_id") in expected["final_feed"]]
        assert_equal(len(authors), len(set(authors)), "expected max one item per author in first page; broken retriever repeated Lina")
    if clinic.startswith("04-"):
        assert_equal(result.get("all_reasons", {}).get("501"), ["social_proof", "similar_topic", "trending"], "expected Lina 501 to preserve reasons [social_proof, similar_topic, trending]; broken mixer lost why Ada sees it")
        assert_equal(len(result.get("final_feed", [])), len(set(result.get("final_feed", []))), "expected no duplicate content IDs; broken mixer repeated Lina 501")
    if clinic.startswith("05-"):
        features = result.get("feature_rows", {})
        assert_true("701" not in features, "expected Omar 701 removed from feature rows because safety and hides/reports are too high")
        assert_equal(features.get("101", {}).get("relationship_strength"), 10, "expected Ben 101 relationship_strength 10 in feature row")
        assert_equal(features.get("501", {}).get("completion_score"), 10, "expected Lina 501 completion_score 10 in feature row")
        assert_true(features.get("801", {}).get("network_suitability", 0) <= 2, "expected Theo 801 network_suitability penalty exposed in feature row")
        assert_true("901" in features, "expected New creator 901 preserved as exploration feature row")
    if clinic.startswith("06-"):
        assert_true(result.get("score_components", {}).get("701", {}).get("hide_penalty", 0) >= 0.8, "expected Omar 701 score components to expose hide risk penalty")
        assert_equal(result.get("final_feed"), [501, 101, 601, 901, 701], "expected multi-objective final order [501,101,601,901,701]; broken ranker used likes only")
    if clinic.startswith("07-"):
        assert_true(result.get("author_counts", {}).get("Ben", 0) <= 2, "expected Ben author cap max 2 in first page; broken feed repeated Ben too often")
        assert_true(result.get("topic_counts", {}).get("backend", 0) <= 2, "expected backend topic cap max 2 in first page; broken feed overfilled backend")
        assert_true(901 in result.get("final_feed", []), "expected exploration item 901 in final page; broken mixer omitted exploration")
    if clinic.startswith("08-"):
        assert_equal(rejected.get("102"), "expired_story", "expected Ben 102 rejected as expired_story")
        assert_equal(rejected.get("201"), "muted_author", "expected Cy 201 rejected as muted_author")
        assert_equal(rejected.get("301"), "blocked_author", "expected Noor 301 rejected as blocked_author")
        assert_equal(rejected.get("601"), "language_mismatch", "expected Omar 601 rejected as language_mismatch")
        assert_equal(rejected.get("801"), "reported_content", "expected Theo 801 rejected as reported_content")
    if clinic.startswith("09-"):
        assert_equal(rejected.get("noor_blocked"), "blocked_author", "expected Noor notification rejected as blocked_author")
        assert_equal(rejected.get("ben_posted_duplicate"), "duplicate_notification", "expected duplicate Ben event rejected as duplicate_notification")
    if clinic.startswith("10-"):
        assert_equal(result.get("offline_replay_result", result.get("offline_replay")), [101, 501, 601, 901], "expected offline replay to reproduce [101,501,601,901]; broken replay drifted")
        assert_equal(rejected.get("701"), "blocked_author", "expected Noor 701 rejected as blocked_author; broken trace did not explain blocked content")
        assert_true(901 in result.get("final_feed", []), "expected exploration 901 included in capstone final feed")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()

    clinic_dir = Path(__file__).parent
    data = json.loads((clinic_dir / "01-dataset.json").read_text())
    module = import_simulation(args.simulation)

    try:
        result = module.run(data)
        check(result, data)
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise

    if args.expect_failure:
        raise AssertionError(f"expected broken simulation to fail for {data['expected']['message']}; it passed")
    print(f"PASS feed clinic proof: {data['clinic']}")

if __name__ == "__main__":
    main()
