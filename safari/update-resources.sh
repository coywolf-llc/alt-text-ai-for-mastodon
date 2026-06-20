#!/usr/bin/env bash
#
# Sync the latest runtime files into the Safari extension's Resources, then
# rebuild in Xcode. Run after changing the extension source so the Safari copy
# stays in step with the Chrome build.
#
set -euo pipefail
cd "$(dirname "$0")/.." # repo root

DEST="safari/AI Alt Text for the Fediverse/AI Alt Text for the Fediverse Extension/Resources"
rm -rf "$DEST"
mkdir -p "$DEST"
cp manifest.json "$DEST/"
cp -R src "$DEST/"
cp -R icons "$DEST/"
find "$DEST" -name '.DS_Store' -delete

echo "Synced manifest/src/icons -> $DEST"
echo "Now rebuild (or re-archive) the app in Xcode."
