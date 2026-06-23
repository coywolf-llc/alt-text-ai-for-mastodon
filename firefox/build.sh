#!/usr/bin/env bash
#
# Package the Firefox (AMO) build from this firefox/ folder and lint it.
# This folder IS the Firefox-native source (browser.* APIs, event-page
# background, options_ui, no Safari/Chrome branches) — see README.md.
#
# Usage: ./build.sh   ->   ../dist/ai-alt-text-for-the-fediverse-firefox-<version>.zip
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
cd "$HERE"

NAME="ai-alt-text-for-the-fediverse"
VERSION="$(grep -m1 '"version"' manifest.json | sed -E 's/.*"version"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/')"

STAGING="$(mktemp -d)"
trap 'rm -rf "$STAGING"' EXIT
cp manifest.json "$STAGING/"
cp -R src "$STAGING/"
cp -R icons "$STAGING/"
find "$STAGING" -name '.DS_Store' -delete

mkdir -p "$ROOT/dist"
ZIP="$ROOT/dist/${NAME}-firefox-${VERSION}.zip"
rm -f "$ZIP"
( cd "$STAGING" && zip -r -X "$ZIP" manifest.json src icons >/dev/null )

echo "Built $ZIP"
unzip -l "$ZIP"

if command -v npx >/dev/null 2>&1; then
  echo "--- web-ext lint ---"
  npx --yes web-ext lint --source-dir "$STAGING" --self-hosted 2>&1 | grep -iE "error|warning|notice|valid" | tail -8 || true
fi
