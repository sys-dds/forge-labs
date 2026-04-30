import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace
CAUSES=["eligibility_filter_missing","diversity_cap_disabled","freshness_filter_disabled","notification_dedupe_missing","exploration_slot_disabled"]
MIT=["enable hard block filter","restore author cap","restore freshness window","restore notification dedupe","restore exploration slot"]
def check(result):
    validate_common_result_shape(result); assert_equal(result.get("bad_feed"),[701,101,102,103,801],"expected reproduced bad feed")
    assert_equal(result.get("corrected_feed"),[101,501,601,901],"expected corrected feed")
    assert_equal(result.get("root_causes"),CAUSES,"expected exact incident root causes"); assert_equal(result.get("mitigations"),MIT,"expected exact mitigations")
    assert_true(all(result.get("regression_checks",{}).values()),"all regression checks should pass"); assert_equal(result.get("deduped_notifications"),["n1"],"expected deduped notifications")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,801,"unsafe_or_stale_content")
    for i in [701,101,102,103,801,501,601,901]: assert_debug_trace(result,i)
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected broken incident response to fail")
    print("PASS feed clinic proof: incident")
if __name__=="__main__": main()
