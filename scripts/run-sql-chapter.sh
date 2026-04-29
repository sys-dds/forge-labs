#!/usr/bin/env bash
set -euo pipefail
chapter_path="${1:-}"
if [[ -z "$chapter_path" ]]; then
  echo "usage: ./scripts/run-sql-chapter.sh 01-sql/01-tables-and-relationships" >&2
  exit 2
fi
./scripts/forge-test.sh "$chapter_path"
