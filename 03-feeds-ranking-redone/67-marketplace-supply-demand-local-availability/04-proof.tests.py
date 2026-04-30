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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("marketplace_rankings"),["listing_101","listing_401","listing_301"],"exact supply demand rankings")
    assert_equal({r["market"]:r["decision"] for r in result.get("supply_rows",[])},{"Glasgow":"high_demand_low_supply","Edinburgh":"lower_demand_more_supply"},"exact supply_rows")
    assert_equal({r["service"]:r["decision"] for r in result.get("demand_rows",[])},{"sink_repair_today":"demand_pressure_high"},"exact demand_rows")
    assert_rejected(result,"listing_601","blocked_seller")
    assert_true({"content_id":"listing_201","reason":"seller_fully_loaded"} in result.get("downranked_items",[]),"fully loaded seller excluded")
    assert_true({"content_id":"listing_501","reason":"seller_risk"} in result.get("risk_suppressed_items",[]),"risky local seller suppressed")
    assert_trace_contains(result,"listing_301","supply demand balance")

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
