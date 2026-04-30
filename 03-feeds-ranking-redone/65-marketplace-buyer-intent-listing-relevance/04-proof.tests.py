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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("marketplace_rankings"),["listing_101","listing_201","listing_501"],"exact marketplace rankings")
    rows={r["listing_id"]:r["decision"] for r in result.get("buyer_intent_rows",[])}
    assert_equal(rows,{"listing_101":"exact_intent_match","listing_201":"partial_service_match","listing_301":"wrong_city","listing_401":"wrong_category","listing_501":"delayed_availability","listing_701":"over_budget"},"exact buyer_intent_rows")
    assert_rejected(result,"listing_601","blocked_seller")
    assert_true({"content_id":"listing_401","reason":"wrong_category"} in result.get("downranked_items",[]),"cheapest is not automatically best")
    assert_trace_contains(result,"listing_101","category 100 location 100 budget 100 availability 100")

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
