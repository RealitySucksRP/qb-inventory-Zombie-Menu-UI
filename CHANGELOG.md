# qb-inventory zombieUI


## v2.6.0 - Crisp Text, Real Stacking, Shop-Build Attachments

### Blurry text fixed
- The menu was shrunk with `transform: scale(.75)`, which rasterizes text at full size and then shrinks it on the GPU - that is what made every label blurry. The menu now uses `zoom: 0.75` instead, so the UI lays out at the final size and glyphs render pixel-crisp at the exact same visual size and position.
- Removed a stray `filter: blur(.1px)` on the background grid and switched `text-rendering: geometricPrecision` (soft edges) to `optimizeLegibility`.
- Drag ghost now matches the zoomed slot size and tracks the cursor correctly.

### Items stack now
- New config option `Config.StackWithDifferentExpiry = true`: non-unique items always stack by name, even when freshness/expiry differs. Merged stacks keep the EARLIER expiry so stacking can never extend an item's life. Set it to `false` to restore the old exact-expiry-match behavior.
- Applies everywhere: server AddItem (shop buys, loot, gives), drag-merge in the same inventory, and drag-merge across inventories (stash/drop/player). The NUI mirrors the same rule so the client prediction matches the server.
- Cross-inventory stack merges now carry the moving item's metadata instead of duplicating the target's.

### Weapon attachments read "as they come" (rs-weaponshops prebuilt builds)
- Weapon Inspection now trusts shop metadata directly: if `info.attachments` entries name a real shared item (rs-weaponshops saves `item`/`attachment`/`label`/`component`), the attachment shows even when qb-weapons has no mapping for that weapon.
- Attachment slots use the item's real inventory image (server-provided), not a guessed `<key>.png`.
- Smarter slot detection (key + label): compensators/silencers land in Muzzle, thermal scopes in Optics, luxury finishes in Skin/Tint, etc.
- New "Other Attachments" overflow section: anything that does not fit the six standard slots (heavy barrels, exotic shop items) is still visible and removable - nothing installed is ever invisible.
- Weapon Inspection shows the installed weapon tint (uses the shop's tint label when present).
- Panel now scrolls instead of clipping on short screens.

### qb-weapons companion fixes (qb-weapons resource)
- `HasAttachment` now hash-normalizes components, so DETACHING attachments bought as part of a weapon-shop build works (shop metadata stores component name strings; qb-weapons config stores hash numbers - they never matched before).
- Equipping a weapon applies attachments saved as either name strings or hash numbers without erroring.
- Added the missing `qb-weapons:client:applyComponentNow` / `removeComponentNow` handlers, so using/toggling an attachment item shows on the held weapon instantly instead of after re-equip.


## v2.2.2 - Attachment Item Keys Fix

- Added `RS_ATTACHMENT_ITEMS_SNIPPET.lua` for missing QBCore item definitions.
- Fixes blocked attachment removal for:
  - `carbine_extendedclip`
  - `pistol_suppressor_only`
- Prevents ghost items while allowing removed attachments to return as real inventory items.
- No core swap/cash/UI redesign changes in this patch.
