#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"/.. && pwd)"
package_name="openai-codex"
local_repo="$HOME/opt/pkgbuilds"

mkdir -p "$local_repo"
ln -sfn "$HOME/projects/pkgbuilds" "$local_repo/src"

shopt -s nullglob
packages=("$repo_root"/${package_name}-*.pkg.tar.zst)
if (( ${#packages[@]} == 0 )); then
  printf 'No built package found in %s\n' "$repo_root" >&2
  exit 1
fi

latest_package="$(printf '%s\n' "${packages[@]}" | sort -V | tail -n1)"
cp -f "$latest_package" "$local_repo/"

mapfile -t existing < <(find "$local_repo" -maxdepth 1 -type f -name "${package_name}-*.pkg.tar.zst" | sort)
if (( ${#existing[@]} > 1 )); then
  for pkg in "${existing[@]:0:${#existing[@]}-1}"; do
    rm -f "$pkg"
  done
fi

repo-add --remove "$local_repo/personal.db.tar.gz" "$local_repo"/${package_name}-*.pkg.tar.zst

printf 'Published %s into %s\n' "$(basename "$latest_package")" "$local_repo"
