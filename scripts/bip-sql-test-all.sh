#!/usr/bin/env bash
set -euo pipefail
for clinic in $(./scripts/bip-sql-list.sh); do
  ./scripts/bip-sql-test-one.sh "$clinic"
done
echo "PASS all BIP SQL clinics"
