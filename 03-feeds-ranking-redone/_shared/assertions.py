"""Assertion helpers for deterministic feed simulation proofs."""


def assert_equal(actual, expected, message):
    if actual != expected:
        raise AssertionError(f"{message}; got {actual}")


def assert_true(condition, message):
    if not condition:
        raise AssertionError(message)


def rejection_map(result):
    rows = result.get("rejected_items", [])
    if isinstance(rows, dict):
        return {str(key): value for key, value in rows.items()}
    return {str(row.get("content_id")): row.get("reason") for row in rows}


def assert_rejected(result, item_id, reason):
    actual = rejection_map(result).get(str(item_id))
    if actual != reason:
        raise AssertionError(f"expected {item_id} rejected with reason {reason}; got {actual}")


def assert_not_rejected(result, item_id):
    if str(item_id) in rejection_map(result):
        raise AssertionError(f"expected {item_id} to survive rejection checks; got rejected")


def assert_no_duplicates(values, message):
    if len(values) != len(set(values)):
        raise AssertionError(f"{message}; got {values}")
