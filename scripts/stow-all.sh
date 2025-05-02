#!/usr/bin/env bash
# Restows *everything* (use after adding new files).
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
# shellcheck disable=SC2046
stow -R $(find . -maxdepth 1 -type d -not -path '.' -not -name '.git' -not -name 'scripts' -printf '%P\n')
