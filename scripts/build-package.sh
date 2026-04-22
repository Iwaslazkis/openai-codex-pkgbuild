#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"/.. && pwd)"

export PACKAGER="${PACKAGER:-Diogo Iwasaki <67493856+Iwaslazkis@users.noreply.github.com>}"
export TMPDIR="${TMPDIR:-$repo_root/.tmp}"

mkdir -p "$TMPDIR"

cd "$repo_root"
makepkg -sCf "$@"
