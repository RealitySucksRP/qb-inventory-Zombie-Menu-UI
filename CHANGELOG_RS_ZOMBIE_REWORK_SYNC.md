# Changelog - RS Zombie Rework Sync

## 2.5.0-rs-zombie-rework-sync

### Added
- Synced zombie inventory backend with the provided APCode `qb-inventory-rework-main(2)` source.
- Preserved zombie UI, images, fonts, CSS, and menu layout.
- Added AP decay/server-time tooltip support into zombie `html/app.js`.
- Added expiry-aware stacking checks so old/decayed items do not stack incorrectly with fresh items.
- Kept ghost item / partial-drop fixes from the previous RS patch.
- Kept weapon hotkey debounce and weapon-use fix.
- Added HUD hook config for `rs-hudlifev4`.

### Changed
- Cleaned `fxmanifest.lua` so it loads AP backend files and zombie UI assets only.
- `Config.CashAsItem` is left disabled by default for safety until qb-core player/items files are patched.
- Kept zombie slot layout at 40 slots for the custom 5-column design.

### Removed / avoided
- Did not load `For Damage & BC_Wounding.lua`.
- Did not overwrite zombie menu design/images with the stock AP UI.
