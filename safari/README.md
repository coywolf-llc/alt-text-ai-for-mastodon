# AI Alt Text for the Fediverse — Safari extension

A macOS app that hosts the AI Alt Text for the Fediverse browser extension for
Safari, generated from the Chrome extension with Apple's
`safari-web-extension-converter`. The extension itself is the same code as the
Chrome build (`manifest.json`, `src/`, `icons/`), copied into
`AI Alt Text for the Fediverse/AI Alt Text for the Fediverse Extension/Resources`.

- **App:** `AI Alt Text for the Fediverse` — bundle id `com.coywolf.AIAltTextForTheFediverse`
- **Extension:** bundle id `com.coywolf.AIAltTextForTheFediverse.Extension`
- **Platform:** macOS only. Verified to build (Release configuration) with Xcode.

## Requirements

- Xcode on macOS.
- An Apple Developer Program membership ($99/yr) to sign and distribute. Local
  testing works without one using a free personal team.

## Open and run locally (for testing)

1. Open `AI Alt Text for the Fediverse/AI Alt Text for the Fediverse.xcodeproj`
   in Xcode.
2. Select the app target → **Signing & Capabilities** → choose your Team (a
   personal team is fine for local testing).
3. Press **Run** (⌘R); the container app launches.
4. In Safari: **Settings → Advanced → Show features for web developers**, then
   **Develop → Allow Unsigned Extensions** (resets each time Safari relaunches).
5. **Settings → Extensions** → enable the extension. Open its settings (the
   toolbar action) to add your Anthropic API key.
6. Visit your Mastodon instance and **allow the extension on that site** when
   prompted (the extension requests host access per-site). The Claude API call
   goes to `api.anthropic.com`, which is already in `host_permissions`.

> Note: Safari grants host access per-site on demand rather than up front, so the
> Mastodon site permission is requested the first time you use it there. Confirm
> the alt-text flow behaves as expected on a real instance.

## Distribute

Safari extensions ship as a signed app, not a zip:

- **Mac App Store:** set your Team on the app target, **Product → Archive**, then
  distribute via App Store Connect.
- **Direct download:** archive with a **Developer ID Application** certificate,
  notarize with `notarytool`, and ship the `.app`/`.dmg`. Users enable the
  extension in Safari Settings.

## Update after changing the extension

The files under `…Extension/Resources` are a copy of the runtime files. After
changing the extension source, re-sync and rebuild:

```bash
./safari/update-resources.sh   # copies manifest.json, src/, icons/ into Resources
```

Then rebuild / re-archive in Xcode.
