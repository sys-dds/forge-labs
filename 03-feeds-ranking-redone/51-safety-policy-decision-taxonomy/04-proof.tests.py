import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape


def assert_safety_trace(result, item_id, text):
    if not any(row.get("content_id") == item_id and text in row.get("why", "") for row in result.get("safety_debug_trace", [])):
        raise AssertionError(f"expected safety_debug_trace for {item_id} to mention {text}")

def check(result):
    validate_common_result_shape(result)
    expected = [{"content_id":"post_101","policy_label":"safe","treatment":"allow"},{"content_id":"post_201","policy_label":"spam_scam","treatment":"remove"},{"content_id":"post_301","policy_label":"harassment_violation","treatment":"remove"},{"content_id":"post_401","policy_label":"borderline_clickbait","treatment":"reduce"},{"content_id":"post_501","policy_label":"medical_context_needed","treatment":"inform"},{"content_id":"post_601","policy_label":"uncertain_report","treatment":"review"},{"content_id":"post_701","policy_label":"safe_low_quality","treatment":"allow"},{"content_id":"post_801","policy_label":"election_review","treatment":"review"}]
    assert_equal(result.get("policy_decisions"), expected, "expected exact policy decisions")
    assert_equal(result.get("safe_feed"), ["post_101", "post_501", "post_701", "post_401"], "expected taxonomy safe feed")
    assert_rejected(result, "post_201", "spam_scam"); assert_rejected(result, "post_301", "harassment_violation")
    assert_equal([r["content_id"] for r in result.get("review_queue")], ["post_601", "post_801"], "expected review queue")
    assert_equal([r["content_id"] for r in result.get("informed_items")], ["post_501"], "expected informed item")
    assert_equal([r["content_id"] for r in result.get("downranked_items")], ["post_401"], "expected downranked item")
    assert_safety_trace(result, "post_401", "reduce"); assert_safety_trace(result, "post_601", "review")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()
    module = import_module(args.simulation)
    data = load_json(Path(__file__).parent / "01-dataset.json")
    try:
        check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise
    if args.expect_failure:
        raise AssertionError("expected broken safety simulation to fail")
    print("PASS feed clinic proof: Safety policy decision taxonomy")

if __name__ == "__main__":
    main()
