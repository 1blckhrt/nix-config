#!/usr/bin/env bash
set -euo pipefail

REPO="/home/blckhrt/nix-config"

# Ensure the directory is a git repository
if [ ! -d "$REPO/.git" ]; then
  echo "Error: $REPO is not a git repository." >&2
  exit 1
fi

# Use a subshell to avoid changing the working directory
(
  cd "$REPO"
  git add -A

  convco commit
)
