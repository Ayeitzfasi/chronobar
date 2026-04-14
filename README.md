# Chronobar

A native macOS menu bar app for comparing time zones and converting meeting times.

![macOS 13.5+](https://img.shields.io/badge/macOS-13.5%2B-blue) ![Swift](https://img.shields.io/badge/Swift-5.9-orange)

## Install

### Option A — One-line Terminal install (recommended)

Paste this into Terminal. It downloads, installs, and bypasses Gatekeeper automatically:

```bash
curl -L https://github.com/Ayeitzfasi/chronobar/releases/latest/download/Chronobar.dmg -o /tmp/Chronobar.dmg && hdiutil attach /tmp/Chronobar.dmg -mountpoint /tmp/ChronobarMount -quiet && cp -r "/tmp/ChronobarMount/Chronobar.app" /Applications/ && xattr -cr /Applications/Chronobar.app && hdiutil detach /tmp/ChronobarMount -quiet && rm /tmp/Chronobar.dmg && echo "Chronobar installed. Launch it from /Applications or Spotlight."
```

Then open Chronobar from Spotlight (`Cmd+Space` → type Chronobar) or `/Applications`.

---

### Option B — Manual install

1. Download **Chronobar.dmg** from the [latest release](https://github.com/Ayeitzfasi/chronobar/releases/latest)
2. Open the DMG → drag **Chronobar.app** to `/Applications`
3. Remove the quarantine flag in Terminal:
   ```bash
   xattr -cr /Applications/Chronobar.app
   ```
4. Open Chronobar normally

> **Why the xattr step?** macOS flags apps downloaded from the internet as quarantined. Since Chronobar is distributed internally (not via the App Store), you need to clear this flag once. The `xattr -cr` command is the standard way to do this — it does not modify the app itself.

---

## Features

- Live time display across multiple time zones in your menu bar
- Interactive time scrubber — drag to find the best meeting time for everyone
- Inline time editing — click any zone's time to type a new value, all zones update instantly
- Day rollover badges — see when a time lands on Yesterday, Today, or Tomorrow
- Add, remove, rename, and reorder time zones
- City name search (75+ cities)
- Launch at Login support
- Persists your zones across restarts

## Default time zones

Dubai · Hyderabad · London · Toronto

Change these any time via the gear icon → Manage Time Zones.

## Requirements

- macOS Ventura 13.5 or later
- Apple Silicon or Intel Mac

## Roadmap

- [x] Menu bar panel with live timezone rows
- [x] Interactive time scrubber
- [x] Inline time editing per zone
- [x] Day rollover badges (Yesterday / Today / Tomorrow)
- [x] Add / remove / rename / reorder zones
- [x] City name search (75+ cities)
- [x] Launch at Login
- [x] App icon
- [ ] Working hours shading (9am–6pm highlight)
- [ ] Best overlap indicator
- [ ] Copy formatted time string
- [ ] EventKit calendar integration
