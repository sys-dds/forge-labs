#!/usr/bin/env bash
set -euo pipefail

root="01-sql-redone"
[[ -d "$root" ]] || { echo "FAIL missing $root" >&2; exit 1; }

find "$root" -mindepth 1 -maxdepth 1 -type d | sort

