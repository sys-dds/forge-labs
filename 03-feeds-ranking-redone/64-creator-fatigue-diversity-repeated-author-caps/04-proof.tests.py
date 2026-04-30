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
    validate_common_result_shape(result); assert_true(result.get("ecosystem_debug_trace"), "ecosystem_debug_trace must be present"); assert_equal(result.get("final_feed"),["post_101","post_102","post_201","post_301","post_401"],"exact diversity final feed")
    creators=[x.split("_")[1] for x in result.get("final_feed",[]) if x.startswith("post_")]
    assert_true(result.get("final_feed",[]).count("post_101") == 1, "Ben first post appears once")
    assert_true("post_103" not in result.get("final_feed",[]), "third Ben post excluded")
    assert_true(len({r.get("creator_id") for r in result.get("inventory",[]) if r.get("id") in result.get("final_feed",[])}) >= 3, "at least three unique creators appear")
    assert_rejected(result,"post_601","blocked_creator"); assert_rejected(result,"post_501","low_quality_viral")
    assert_true({"content_id":"post_103","reason":"repeated_author_cap"} in result.get("downranked_items",[]),"repeated post_103 downranked")
    assert_trace_contains(result,"post_103","repeated-author fatigue")

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
