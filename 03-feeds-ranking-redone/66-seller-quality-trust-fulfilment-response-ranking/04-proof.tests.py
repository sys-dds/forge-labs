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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("marketplace_rankings"),["listing_101","listing_201","listing_401"],"exact seller quality rankings")
    rows={r["seller_id"]:r["decision"] for r in result.get("seller_quality_rows",[])}
    assert_equal(rows,{"seller_ben":"high_trust_high_fulfilment","seller_diya":"good_quality","seller_omar":"high_cancellation_dispute_risk","seller_maya":"clean_cold_start_seller","seller_noor":"blocked_seller"},"exact seller_quality_rows")
    assert_rejected(result,"listing_501","blocked_seller")
    assert_true({"content_id":"listing_301","reason":"fulfilment_risk"} in result.get("risk_suppressed_items",[]),"Omar risk suppressed")
    assert_trace_contains(result,"listing_101","response cancellation dispute")

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
