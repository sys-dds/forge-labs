import argparse
import importlib.util
import json
from pathlib import Path

def import_module(path):
    spec = importlib.util.spec_from_file_location("feed_simulation", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

def assert_equal(actual, expected, message):
    if actual != expected:
        raise AssertionError(f"{message}; got {actual}")

def assert_true(condition, message):
    if not condition:
        raise AssertionError(message)

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
    for item_id in expected.get("excluded_ids", []):
        assert_true(item_id not in result.get("final_feed", []) and item_id not in result.get("eligible_ids", []), f"expected {item_id} excluded; broken simulation allowed a muted, blocked, unsafe, duplicate, expired, or over-cap item")

    labels = result.get("reason_labels", {})
    for item_id in expected["final_feed"]:
        assert_true(str(item_id) in labels or item_id in labels, f"expected reason label for final item {item_id}; broken simulation returned an unexplained feed item")

    if clinic.startswith("01-"):
        impressions = [row.get("content_id") for row in result.get("feedback_log", [])]
        assert_equal(impressions, expected["final_feed"], "expected feedback log impressions for [101,501,401,701]; broken simulation did not log final impressions")
    if clinic.startswith("04-"):
        assert_equal(result.get("all_reasons", {}).get("501"), ["social_proof", "similar_topic", "trending"], "expected Lina 501 to preserve reasons [social_proof, similar_topic, trending]; broken mixer lost why Ada sees it")
        assert_equal(len(result.get("final_feed", [])), len(set(result.get("final_feed", []))), "expected no duplicate content IDs; broken mixer repeated Lina 501")
    if clinic.startswith("05-"):
        assert_true("701" not in result.get("feature_rows", {}), "expected Omar 701 removed from feature rows because safety and hides/reports are too high")
        assert_true("501" in result.get("feature_rows", {}), "expected Lina 501 feature row with video/completion signals")
    if clinic.startswith("06-"):
        assert_true(result.get("score_components", {}).get("701", {}).get("hide_penalty", 0) >= 0.8, "expected Omar 701 score components to expose hide risk penalty")
    if clinic.startswith("07-"):
        assert_true(result.get("author_counts", {}).get("Ben", 0) <= 2, "expected Ben author cap max 2 in first page; broken feed repeated Ben too often")
        assert_true(901 in result.get("final_feed", []), "expected exploration item 901 in final page; broken mixer omitted exploration")
    if clinic.startswith("10-"):
        assert_equal(result.get("offline_replay"), [101, 501, 601, 901], "expected offline replay to reproduce [101,501,601,901]; broken replay drifted")
        assert_equal(result.get("rejected_items", {}).get("701"), "blocked_author", "expected Noor 701 rejected as blocked_author; broken trace did not explain blocked content")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()

    clinic_dir = Path(__file__).parent
    dataset_path = clinic_dir / "01-dataset.json"
    data = json.loads(dataset_path.read_text())
    module = import_module(args.simulation)

    try:
        result = module.run(str(dataset_path))
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
