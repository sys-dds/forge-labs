import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape

def assert_retrieval_trace(result,item_id,text):
    if not any(row.get("content_id")==item_id and text in row.get("why","") for row in result.get("retrieval_debug_trace",[])):
        raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")
def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("recall_report"), {"Strategy A":1.0,"Strategy B":0.6}, "expected recall report")
    assert_equal(result.get("precision_report"), {"Strategy A":0.5,"Strategy B":1.0}, "expected precision report")
    assert_equal(result.get("false_negatives",{}).get("Strategy B"), [401,501], "expected Strategy B false negatives")
    assert_equal(result.get("winner_for_first_stage_retrieval"), "Strategy A", "expected recall-first strategy A")
    assert_retrieval_trace(result,"Strategy A","recall 1.0")
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected precision-only strategy choice to fail")
    print("PASS feed clinic proof: retrieval recall precision")
if __name__=="__main__": main()
