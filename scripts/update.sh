#!/usr/bin/env bash
# Pull latest commits then re-stow.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
git pull --ff-only
"$(dirname "$0")/stow-all.sh"
