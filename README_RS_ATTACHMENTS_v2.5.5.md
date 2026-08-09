# RealitySucksRP qb-inventory v2.5.5 - Prebuilt Weapon Attachment Read Fix

Changed-files-only patch. No images touched.

## What changed
- Fixes attachment reading for weapons that were bought prebuilt from a weapon shop.
- Stops forcing weapon names to uppercase. QBCore/qb-weapons normally uses lowercase names like `weapon_pistol`.
- Reads common metadata formats: `info.attachments`, `info.components`, `info.mods`, `weaponAttachments`, array lists, item-key lists, component names, and component hashes.
- Reads metadata even if `info` came back as a JSON string.
- Adds a fallback check for components actually installed on the currently held weapon if a custom weapon shop applied components but did not save proper metadata.
- Keeps the rework-style Weapon Inspection panel.

## Files to upload
qb-inventory/client/main.lua
qb-inventory/server/main.lua
qb-inventory/html/app.js
qb-inventory/html/index.html
qb-inventory/html/main.css

## Restart
restart qb-inventory

## Testing
1. Buy the prebuilt weapon from the weapon store.
2. Equip/hold the weapon once if your weapon store only applies components to the ped and does not save metadata.
3. Open inventory.
4. Right-click the weapon.
5. Open Attachments / Weapon Inspection.
6. Installed attachments should appear in the panel.
