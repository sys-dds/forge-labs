#!/usr/bin/env bash
set -euo pipefail
tmpfile="$(mktemp /tmp/bip-pim-list.XXXXXX)"
cleanup(){ rm -f "$tmpfile"; }
trap cleanup EXIT
./scripts/bip-pim-list.sh > "$tmpfile"
while IFS= read -r clinic; do
  [[ -n "$clinic" ]] || continue
  ./scripts/bip-pim-test-one.sh "$clinic" < /dev/null
done < "$tmpfile"
echo "PASS all BIP PIM clinics"
