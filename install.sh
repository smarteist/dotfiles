#!/usr/bin/env bash
#
# Bootstrap the whole dot-files suite with GNU Stow.
# Dependencies to install should be listed one-per-line in needs.txt
# Run from inside the repo root:   ./install.sh [pkg …]
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.dotfile_backups/$(date +%Y%m%d_%H%M%S)"
PKGS=("$@") # user-supplied package list

# ---- helpers ---------------------------------------------------------------
err()  { printf "\e[31m%s\e[0m\n" "$*" >&2; }
note() { printf "\e[32m%s\e[0m\n" "$*"; }

need() {
	command -v "$1" &>/dev/null && return
	err "Missing dependency '$1'. Trying to install…"
	if command -v apt-get &>/dev/null; then
		sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq
		sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$1"
	elif command -v apt &>/dev/null; then
		sudo DEBIAN_FRONTEND=noninteractive apt update -qq
		sudo DEBIAN_FRONTEND=noninteractive apt install -y "$1"
	elif command -v dnf &>/dev/null; then
		sudo dnf install -y "$1"
	elif command -v pacman &>/dev/null; then
		sudo pacman -Sy --noconfirm "$1"
	elif command -v brew &>/dev/null; then
		brew install "$1"
	else
		err "No supported package manager found; please install '$1' manually."
		exit 1
	fi
}

backup_if_conflict() {
  local file="$1"
  if [[ -e "${HOME}/${file}" || -L "${HOME}/${file}" ]]; then
    mkdir -p "${BACKUP_DIR}"
    mv -v "${HOME}/${file}" "${BACKUP_DIR}/"
  fi
}

# ---- install global deps from file ----------------------------------------
DEPS_FILE="${REPO_DIR}/needs.txt"
if [[ -f "${DEPS_FILE}" ]]; then
  note "Installing dependencies from ${DEPS_FILE}…"
  while IFS= read -r dep || [[ -n "$dep" ]]; do
    # strip comments and whitespace
    dep="${dep%%#*}"
    dep="${dep##*( )}"
    dep="${dep%%*( )}"
    [[ -z "$dep" ]] && continue
    need "$dep"
  done < "${DEPS_FILE}"
fi

# ---- main ------------------------------------------------------------------
need "stow"
cd "${REPO_DIR}"

# Default package list = every first-level dir that is not scripts/ or .git
if [[ ${#PKGS[@]} -eq 0 ]]; then
  mapfile -t PKGS < <(
    find . -maxdepth 1 -type d \
      -not -path '.' \
      -not -name '.git' \
      -not -name 'scripts' \
      -printf '%P\n'
  )
fi

note "Backing up any conflicting files to: ${BACKUP_DIR}"

for pkg in "${PKGS[@]}"; do
  while IFS= read -r -d '' file; do
    rel="${file#"${pkg}"/}"       # strip leading "pkg/"
    if [[ "${rel}" == .* ]]; then
      target="${rel}"
    else
      target=".${rel}"
    fi
    backup_if_conflict "${target}"
  done < <(find "${pkg}" -type f -print0)
done

note "Stowing packages: ${PKGS[*]}"
stow -v \
      -d "${REPO_DIR}" \
      -t "${HOME}" \
      "${PKGS[@]}"

note "All done 🎉"
