import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace

def check(result):
    validate_common_result_shape(result); assert_equal(result.get("final_feed"),[101,301,401,501],"expected freshness-correct feed")
    for item,reason in [(102,"already_seen"),(201,"stale_outside_window"),(601,"blocked_author"),(701,"duplicate_content")]: assert_rejected(result,item,reason)
    assert_true(201 not in result.get("final_feed",[]),"stale high-score content must not appear")
    for i in [101,102,201,301,401,501,601,701]: assert_debug_trace(result,i)
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected broken freshness filter to fail")
    print("PASS feed clinic proof: freshness")
if __name__=="__main__": main()
