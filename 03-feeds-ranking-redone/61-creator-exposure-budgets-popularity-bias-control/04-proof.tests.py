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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present")
    assert_equal(result.get("final_feed"), ["post_101","post_301","post_401","post_601"], "exact creator exposure final feed")
    rows={r["creator_id"]:r["decision"] for r in result.get("exposure_rows",[])}
    assert_equal(rows,{"creator_ben":"overexposed_but_high_quality","creator_diya":"balanced_exposure","creator_maya":"underexposed_quality_creator","creator_omar":"low_quality_viral_suppressed","creator_lina":"long_tail_quality_creator","creator_noor":"blocked_creator"},"exact exposure rows")
    assert_rejected(result,"post_701","blocked_creator")
    assert_true({"content_id":"post_201","reason":"repeated_overexposed_creator"} in result.get("downranked_items",[]), "repeated overexposed Ben post must be downranked")
    assert_true({"content_id":"post_501","reason":"low_quality_viral_creator"} in result.get("downranked_items",[]), "viral low quality Omar must be downranked")
    assert_true("post_401" in result.get("final_feed",[]), "underexposed quality creator Maya must appear")
    assert_trace_contains(result,"post_401","creator_maya exposure decision")

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
