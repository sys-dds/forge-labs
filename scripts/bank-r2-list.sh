#!/usr/bin/env bash
set -euo pipefail
find 05-banking-systems-redone -maxdepth 1 -type d -name '[0-9][0-9][0-9]-*' | sort
