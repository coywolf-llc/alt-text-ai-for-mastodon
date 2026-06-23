# AI Alt Text for the Fediverse — Firefox

The Firefox (AMO) build of the extension. This folder is a **Firefox-native
variant** of the source — it does not contain anything Chrome- or Safari-specific:

- **`browser.*` APIs** (Firefox's native promise-based namespace), not `chrome.*`.
- **Event-page background** (`background.scripts`) — Firefox MV3 doesn't use a
  `service_worker`.
- **`options_ui`** (Firefox has no standalone `options_page`).
- **`browser_specific_settings.gecko`** with the AMO add-on id and
  `data_collection_permissions` (`websiteContent` — the image is sent to Anthropic).
- The Safari-only branches (`navigator.vendor` checks, the declared-content-script
  cleanup, the content-script self-gate) are **removed** — Firefox uses the dynamic
  `scripting.registerContentScripts` + `permissions.request` model directly.

## Build

```bash
./build.sh   # -> ../dist/ai-alt-text-for-the-fediverse-firefox-<version>.zip  (+ web-ext lint)
```

## Test locally

Firefox → `about:debugging#/runtime/this-firefox` → **Load Temporary Add-on** →
pick `firefox/src/../manifest.json` (this folder's `manifest.json`). Open the
extension's options, add your Anthropic API key, add a Mastodon instance (Firefox
prompts for per-site access), then use **Generate with Claude** in the composer's
"Add alt text" dialog.

## Submit

addons.mozilla.org → Developer Hub → **Submit a New Add-on** → upload the zip.
Mozilla signs it. Reuse the listing copy from `../store-listing.md`; for the
reviewer, include a temporary Anthropic API key in the notes (same as the other
stores).

## Keeping it in sync

This is a maintained variant of `../src`. When the Chrome source changes, mirror
the change here, converting `chrome.*` → `browser.*` and leaving out the Safari
(`navigator.vendor`) branches. `web-ext lint` (run by `build.sh`) catches manifest
or API regressions.
