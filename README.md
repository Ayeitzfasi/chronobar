# Chronobar

A native macOS menu bar app for comparing time zones, converting meeting times, and scheduling across regions.

![macOS](https://img.shields.io/badge/macOS-13.5%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![License](https://img.shields.io/badge/license-MIT-green)

## What it does

- View multiple time zones at a glance from the menu bar
- Scrub through time with an interactive slider to see converted times live
- See clear day rollover indicators (Yesterday / Today / Tomorrow)
- Add, remove, rename, and reorder time zones
- Set a base zone for offset calculations
- Launch at login support

## Screenshot

> Coming soon

## Tech stack

- Swift + SwiftUI
- macOS 13.5+
- `MenuBarExtra` for menu bar integration
- `ServiceManagement` for launch at login
- `UserDefaults` for persistence
- No third-party dependencies

## Run locally

1. Clone the repo
2. Open `Chronobar.xcodeproj` in Xcode
3. Set your development team in Signing & Capabilities
4. Press Cmd+R to build and run
5. Look for the clock icon in your menu bar

## Roadmap

- [x] Menu bar app shell
- [x] Multi-timezone time conversion with day rollover
- [x] Interactive time scrubber (worldtimebuddy-style)
- [x] User-managed saved time zones with persistence
- [x] Settings window with add/remove/reorder/rename
- [x] Launch at login
- [ ] Working hours shading
- [ ] Best overlap suggestions
- [ ] Copy formatted time string
- [ ] EventKit calendar integration
- [ ] App icon
- [ ] Signed + notarized releases

## Contributing

Contributions welcome. Please open an issue before making large changes.

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT — see [LICENSE](LICENSE)
