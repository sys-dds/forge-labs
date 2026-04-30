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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("marketplace_rankings"),["listing_101","listing_301","listing_401"],"exact risk-suppressed rankings")
    rows={r["listing_id"]:r["decision"] for r in result.get("risk_score_rows",[])}
    assert_equal(rows,{"listing_101":"trusted_low_risk","listing_201":"fraud_risk_high","listing_301":"trusted_low_risk","listing_401":"clean_cold_start","listing_501":"fraud_risk_medium","listing_601":"blocked_seller"},"exact risk score rows")
    assert_rejected(result,"listing_601","blocked_seller")
    assert_true({"content_id":"listing_201","reason":"high_fraud_dispute_refund_risk"} in result.get("risk_suppressed_items",[]),"high-risk cheap listing suppressed")
    assert_true({"content_id":"listing_501","reason":"suspiciously_cheap_fraud_risk"} in result.get("risk_suppressed_items",[]),"medium fraud listing suppressed")
    assert_trace_contains(result,"listing_201","fraud dispute refund risk")

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
