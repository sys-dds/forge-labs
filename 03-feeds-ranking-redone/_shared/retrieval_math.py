"""Small retrieval math helpers with no clinic-specific rules."""

import math


def safe_divide(numerator, denominator):
    if denominator == 0:
        return 0.0
    return numerator / denominator


def dot_product(vector_a, vector_b):
    return round(sum(a * b for a, b in zip(vector_a, vector_b)), 6)


def normalise_vector(vector):
    length = math.sqrt(sum(value * value for value in vector))
    if length == 0:
        return [0 for _ in vector]
    return [round(value / length, 6) for value in vector]


def cosine_similarity(vector_a, vector_b):
    norm_a = math.sqrt(sum(value * value for value in vector_a))
    norm_b = math.sqrt(sum(value * value for value in vector_b))
    if norm_a == 0 or norm_b == 0:
        return 0.0
    return round(sum(a * b for a, b in zip(vector_a, vector_b)) / (norm_a * norm_b), 3)


def euclidean_distance(vector_a, vector_b):
    return round(math.sqrt(sum((a - b) ** 2 for a, b in zip(vector_a, vector_b))), 3)


def stable_sort(rows, key):
    return sorted(rows, key=key)


def top_k(rows, key, k):
    return stable_sort(rows, key)[:k]
