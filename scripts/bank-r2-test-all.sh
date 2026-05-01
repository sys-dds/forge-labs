#!/usr/bin/env bash
set -euo pipefail
tmpfile="$(mktemp /tmp/bank-r2-list.XXXXXX)"
cleanup(){ rm -f "$tmpfile"; }
trap cleanup EXIT
./scripts/bank-r2-list.sh > "$tmpfile"
while IFS= read -r clinic; do
  [[ -n "$clinic" ]] || continue
  ./scripts/bank-r2-test-one.sh "$clinic" < /dev/null
done < "$tmpfile"
echo "PASS all BANK R2 clinics"
