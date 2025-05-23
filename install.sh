#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.dotfile_backups/$(date +%Y%m%d_%H%M%S)"

# ANSI colours (POSIX-portable)
RED=$'\e[31m'
GREEN=$'\e[32m'
RESET=$'\e[0m'

log() { printf '%s%s%s\n' "$GREEN" "$*" "$RESET"; }
err() { printf '%s%s%s\n' "$RED" "$*" "$RESET" >&2; }

need() {
    local bin=$1
    command -v "$bin" &>/dev/null && return

    err "Missing dependency: $bin — attempting install…"

    for mgr in apt-get apt dnf pacman brew; do
        command -v "$mgr" &>/dev/null || continue
        case $mgr in
        apt-get | apt)
            sudo DEBIAN_FRONTEND=noninteractive "$mgr" update -qq
            sudo DEBIAN_FRONTEND=noninteractive "$mgr" install -y "$bin"
            ;;
        dnf) sudo dnf install -y "$bin" ;;
        pacman) sudo pacman -Sy --noconfirm "$bin" ;;
        brew) brew install "$bin" ;;
        esac
        return
    done

    err "No supported package manager found. Please install ‘$bin’ manually."
    exit 1
}

install_deps_file() {
    local file=$1
    [[ -f $file ]] || return
    log "Installing dependencies listed in ${file}"
    grep -Ev '^\s*(#|$)' "$file" | while read -r dep; do need "$dep"; done
}

backup_if_conflict() {
    local path="${1%/}"

    # Skip if it doesn’t exist or is itself a symlink
    if [ ! -e "$path" ] || [ -h "$path" ]; then
        [ -h "$path" ] && log "Skipping symlink: $path"
        return 0
    fi

    # Skip if any parent directory of $path is a symlink
    local dir="$path"
    while [ "$dir" != "$HOME" ] && [ "$dir" != "/" ]; do
        dir=$(dirname "$dir")
        if [ -h "$dir" ]; then
            log "Skipping (parent is symlink): $path ← $dir"
            return 0
        fi
    done

    # Compute relative path under $HOME and move it into $BACKUP_DIR
    local rel="${path#$HOME/}"
    local dest_dir="$BACKUP_DIR/$(dirname "$rel")"
    mkdir -p -- "$dest_dir"
    mv -v -- "$path" "$dest_dir/"
}

discover_pkgs() {
    if [[ $# -gt 0 ]]; then
        printf '%s\n' "$@"
    else
        find . -maxdepth 1 -type d ! -name '.' ! -name '.git' ! -name 'scripts' -printf '%P\n'
    fi
}

main() {
    install_deps_file "${REPO_DIR}/needs.txt"
    need stow

    cd -- "$REPO_DIR"
    mapfile -t PKGS < <(discover_pkgs "$@")

    log "Backing up conflicts to: $BACKUP_DIR"
    for pkg in "${PKGS[@]}"; do
        while IFS= read -r -d '' file; do
            rel="${file#"$pkg"/}"
            target="${HOME}/.${rel#.}" # always dot-prefixed
            backup_if_conflict "$target"
        done < <(find "$pkg" -type f -print0)
    done

    log "Stowing packages: ${PKGS[*]}"
    stow -v -d "$REPO_DIR" -t "$HOME" "${PKGS[@]}"

    log "All done 🎉"
}

main "$@"
