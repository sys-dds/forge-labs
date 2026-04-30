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
    assert_equal(result.get("final_feed"), ["post_101", "post_501", "post_601", "post_901", "post_301", "post_401"], "expected senior safety-aware final feed")
    assert_rejected(result, "post_201", "spam_scam"); assert_rejected(result, "post_701", "blocked_author")
    assert_equal([r["content_id"] for r in result.get("review_queue")], ["post_801"], "expected review queue")
    assert_equal([r["content_id"] for r in result.get("informed_items")], ["post_301"], "expected informed item")
    assert_equal([r["content_id"] for r in result.get("downranked_items")], ["post_401"], "expected downranked item")
    assert_equal([r["content_id"] for r in result.get("restored_items")], ["post_601"], "expected restored appeal row")
    design=result.get("safety_system_design",{})
    assert_true(isinstance(design.get("policy_taxonomy"), dict), "policy taxonomy must be rich object")
    assert_true(isinstance(design.get("ranking_handoff_contract"), dict), "handoff contract must be nested")
    handoff=result.get("ranking_handoff_contract",[])
    assert_true(all("candidate_id" in r and "treatment" in r and "label" in r and "risk_score" in r and "trace" in r for r in handoff), "handoff must include treatments labels risks traces")
    for item,text in [("post_201","spam_scam"),("post_301","context_label"),("post_401","fake_engagement_penalty"),("post_601","appeal_reversal_applied"),("post_801","uncertain_claim")]: assert_safety_trace(result,item,text)


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
    print("PASS feed clinic proof: Senior safety-aware feed ranking system design capstone")

if __name__ == "__main__":
    main()
