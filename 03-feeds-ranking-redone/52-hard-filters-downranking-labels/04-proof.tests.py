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
    assert_equal([r["content_id"] for r in result.get("rejected_items")], ["post_201", "post_301"], "expected hard filters before ranking")
    assert_true("post_301" not in result.get("final_feed", []), "malware post_301 must never reach final feed")
    assert_equal([r["content_id"] for r in result.get("downranked_items")], ["post_401", "post_601"], "expected downranked not removed")
    assert_equal([r["content_id"] for r in result.get("informed_items")], ["post_501"], "expected context-labelled item")
    assert_equal(result.get("final_feed"), ["post_101", "post_701", "post_801", "post_501", "post_401", "post_601"], "expected final order after safety treatments")
    assert_safety_trace(result, "post_301", "hard filter before ranking"); assert_safety_trace(result, "post_501", "label fact_check_context")


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
    print("PASS feed clinic proof: Hard filters vs downranking vs labels")

if __name__ == "__main__":
    main()
