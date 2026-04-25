#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"/.. && pwd)"
package_name="openai-codex"
repoctl="$HOME/projects/pkgbuilds/personal-pkgbuilds/repoctl"

[[ -x "$repoctl" ]] || {
  printf 'repoctl is missing or not executable: %s\n' "$repoctl" >&2
  exit 1
}

shopt -s nullglob
packages=("$repo_root"/${package_name}-*.pkg.tar.zst)
if (( ${#packages[@]} == 0 )); then
  printf 'No built package found in %s\n' "$repo_root" >&2
  exit 1
fi

latest_package="$(printf '%s\n' "${packages[@]}" | sort -V | tail -n1)"
"$repoctl" add "$latest_package"
