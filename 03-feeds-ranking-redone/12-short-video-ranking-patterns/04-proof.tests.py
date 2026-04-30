import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("short_video_feed"), [201,101,401,601,701], "expected short-video feed [201,101,401,601,701]")
    assert_rejected(result,301,"blocked_author"); assert_rejected(result,501,"high_negative_feedback")
    scores={r["content_id"]:r["score_components"] for r in result.get("score_rows",[])}
    assert_true(scores[201]["completion"] > scores[101]["completion"], "expected Cy 201 completion to beat Ben 101")
    assert_true(scores[701]["creator_fatigue"] > 0, "expected Theo 701 creator fatigue applied")
    assert_debug_trace(result,601); assert_trace_contains(result,201,"completion")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()
    dataset = load_json(Path(__file__).parent / "01-dataset.json")
    module = import_module(args.simulation)
    try:
        check(module.run(dataset))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise
    if args.expect_failure:
        raise AssertionError("expected broken simulation to fail the product-surface proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__":
    main()
