import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_trace_contains

def check(result):
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("final_feed"),["post_201","post_101","post_501"],"exact long-tail final feed")
    rows={r["content_id"]:r["decision"] for r in result.get("long_tail_rows",[])}
    assert_equal(rows,{"post_201":"long_tail_high_quality_high_fit","post_301":"long_tail_low_audience_fit","post_501":"long_tail_secondary_interest_fit"},"exact long_tail_rows")
    assert_rejected(result,"post_701","blocked_author"); assert_rejected(result,"post_601","low_quality_spam")
    assert_true({"content_id":"post_401","reason":"popular_low_quality"} in result.get("downranked_items",[]),"popular low-quality post downranked")
    assert_trace_contains(result,"post_201","quality 92 fit")

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
        raise AssertionError("expected broken ecosystem simulation to fail")
    print("PASS feed clinic proof")

if __name__ == "__main__":
    main()
