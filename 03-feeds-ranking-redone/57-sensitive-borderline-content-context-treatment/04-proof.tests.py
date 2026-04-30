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
    ada=result.get("viewer_results",{}).get("Ada",{}); ben=result.get("viewer_results",{}).get("Ben",{})
    assert_equal(result.get("final_feed"), ["post_101", "post_501", "post_201", "post_701"], "expected default Ada safety feed")
    assert_equal(ada.get("final_feed"), ["post_101", "post_501", "post_201", "post_701"], "expected Ada contextual feed")
    assert_equal(ben.get("final_feed"), ["post_101", "post_501", "post_701"], "expected Ben teen-safe feed")
    assert_true(ada.get("final_feed") != ben.get("final_feed"), "Ada and Ben feeds differ")
    assert_true(any(r["content_id"]=="post_401" for r in ben.get("rejected_items", [])), "Ben rejects age-sensitive content")
    assert_true(any(r["content_id"]=="post_201" for r in ada.get("informed_items", [])), "Ada gets informed medical content")
    assert_true(any(r["content_id"]=="post_601" for r in ada.get("rejected_items", [])) and any(r["content_id"]=="post_601" for r in ben.get("rejected_items", [])), "unsafe misinformation rejected for all")
    assert_safety_trace(result, "post_201", "Ada")


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
    print("PASS feed clinic proof: Sensitive borderline content context treatment")

if __name__ == "__main__":
    main()
