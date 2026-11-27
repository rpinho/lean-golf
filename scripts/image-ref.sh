#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_REPOSITORY:?Set GITHUB_REPOSITORY to owner/lean-golf}"
if command -v sha256sum >/dev/null 2>&1; then
  hash=(sha256sum)
else
  hash=(shasum -a 256)
fi
digest=$(cat lean-toolchain lakefile.toml lake-manifest.json docker/Dockerfile docker/Dockerfile.dockerignore |
  "${hash[@]}" | cut -d ' ' -f 1)
repo=$(printf '%s' "$GITHUB_REPOSITORY" | tr '[:upper:]' '[:lower:]')
printf 'ghcr.io/%s:deps-%s\n' "$repo" "$digest"
