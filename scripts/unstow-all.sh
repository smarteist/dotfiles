#!/usr/bin/env bash
# Removes every symlink created by stow.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
# shellcheck disable=SC2046
stow -D $(find . -maxdepth 1 -type d -not -path '.' -not -name '.git' -not -name 'scripts' -printf '%P\n')
