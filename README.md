# Chronobar

A native macOS menu bar app for comparing time zones and converting meeting times.

![macOS 13.5+](https://img.shields.io/badge/macOS-13.5%2B-blue) ![Swift](https://img.shields.io/badge/Swift-5.9-orange)

## Features

- Live time display across multiple time zones in your menu bar
- Interactive time scrubber — drag to find the best meeting time for everyone
- Inline time editing — click any zone's time to type a new value, all zones update instantly
- Day rollover badges — see when a time lands on Yesterday, Today, or Tomorrow
- Add, remove, rename, and reorder time zones
- City name search (75+ cities)
- Launch at Login support
- Persists your zones across restarts

## Install

1. Go to the [latest release](https://github.com/Ayeitzfasi/chronobar/releases/latest)
2. Download **Chronobar.dmg**
3. Open the DMG → drag **Chronobar.app** to your `/Applications` folder
4. **First launch only:** right-click `Chronobar.app` → **Open** → click Open in the dialog
   - This is a one-time step to bypass Gatekeeper for apps distributed outside the App Store
5. Chronobar appears in your menu bar — click the clock icon to open it

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
- [x] Day rollover badges
- [x] Add / remove / rename / reorder zones
- [x] City name search (75+ cities)
- [x] Launch at Login
- [x] App icon
- [ ] Working hours shading (9am–6pm highlight)
- [ ] Best overlap indicator
- [ ] Copy formatted time string
- [ ] EventKit calendar integration
