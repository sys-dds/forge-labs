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
    assert_equal(result.get("final_feed"), [], "review queue clinic has no feed handoff")
    assert_equal([r["content_id"] for r in result.get("review_queue")], ["post_101", "post_301", "post_401"], "expected reliability-aware review queue")
    assert_rejected(result, "post_401", "auto_detected_spam")
    assert_true(any(r["content_id"]=="post_201" and r["reason"]=="unreliable_mass_report" for r in result.get("ignored_report_rows", [])), "troll mass report suppressed")
    assert_true(result.get("reporter_reliability_rows"), "reporter reliability rows exist")
    assert_safety_trace(result, "post_101", "Ada")


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
    print("PASS feed clinic proof: Reporter reliability review queues")

if __name__ == "__main__":
    main()
