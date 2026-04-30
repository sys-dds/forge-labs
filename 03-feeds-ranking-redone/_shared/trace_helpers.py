"""Trace helpers that validate explanations without knowing clinic data."""


def trace(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}


def trace_ids(result):
    return {str(row.get("content_id")) for row in result.get("debug_trace", [])}


def assert_debug_trace(result, item_id):
    if str(item_id) not in trace_ids(result):
        raise AssertionError(f"expected debug_trace explanation for {item_id}")


def assert_trace_contains(result, item_id, text):
    for row in result.get("debug_trace", []):
        if str(row.get("content_id")) == str(item_id) and text in row.get("why", ""):
            return
    raise AssertionError(f"expected debug_trace for {item_id} to mention {text}")
