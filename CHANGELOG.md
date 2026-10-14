# Changelog

All notable changes to this project are documented here.
This project follows [Semantic Versioning](https://semver.org/).

---

## [3.0.4-qb-production-guard] - 2026-09-11 - QBCore production audit

### Security and authority

- Kept the resource deliberately QBCore/qb-inventory focused; no Qbox/ESX compatibility layer was introduced.
- Added the `/onesync` manifest constraint because vehicle/drop authority depends on server network ids, entity coordinates and routing buckets.
- Vehicle sessions now retain the verified network id, plate, type and routing bucket and revalidate the same vehicle on every move; vehicle capacity is resolved from the server model/QBCore shared category rather than client class/model claims.
- Player, drop, vehicle and shop interactions now reject cross-routing-bucket access.
- Generic stashes without configured coordinates are bound to their trusted server-open position so walking/teleporting away cannot preserve remote access.
- Vending requests are rate-limited and validate allowed model/proximity; networked props are verified server-side. Optional strict configured coordinates provide full server location authority for static map vending.
- Robbery tokens enforce the search duration on the server and re-check hands-up/dead state at completion.
- Robbery authorization now uses a real server-only target lock; replicated `inv_busy` remains compatibility/UI state and cannot be cleared by a victim to race a second robber.
- Active inventory sessions are revalidated by a lightweight server watchdog, so walking/teleporting away, changing routing buckets, losing the exact vehicle/drop/shop/stash, or a searched player leaving range force-closes the stale session even without another item move.
- Shop purchases share the same per-player mutation mutex as drag/drop and cash reconciliation, re-read stock after locking, and always release/refund safely on an integration exception.
- Tooltip HTML now escapes dynamic item labels, descriptions and metadata before rendering, closing a cross-resource/database NUI markup injection path.
- Item use now rejects dead/last-stand/handcuffed state and is server rate-limited.
- Client writes to the replicated `inv_busy` player state were removed; the server owns the lock, including player-load/resource-start reset.
- Raw `playerDropped` now clears mutation locks, drop-request caches and debounced-save generations independently of QBCore unload ordering, preventing recycled server IDs from inheriting stale inventory state.

### Drops and lifecycle

- Drops are bound to routing buckets and `updateDrop` uses the carrier's server coordinates rather than arbitrary client coordinates.
- A player can carry only one server-tracked bag; carried bags cannot be opened, and death/last stand releases the bag cleanly.
- Late-streaming drop entities stay in a lightweight client registry and gain their target when the net entity enters scope.
- Drop creation collisions/refailures clean up/refund instead of leaking entities; resource stop removes server-owned bag entities.
- Drop creation keeps the previous session intact until the replacement bag/session succeeds; failed session transitions delete the new entity and refund the item.
- Drop expiry skips bags currently being carried, stale dead/disconnected carriers recover server-side, and empty drops are removed from server state before entity cleanup so they cannot be re-opened during deletion.
- NUI focus, blur, HUD state, pending operations, drop carry state and the exact opened trunk door are cleaned up on forced close/unload/resource stop.

### Persistence and correctness

- Stash/trunk/glovebox mutations schedule debounced database writes and dirty caches are flushed on close/shutdown/resource stop, reducing restart duplication/loss windows.
- `RemoveInventory` now refuses to evict dirty cached data if its database save fails; txAdmin shutdown flushes only dirty inventories instead of synchronously rewriting the entire cache.
- Client cash-state resync requests are rate-limited and the missing `qb-inventory:client:updateCash` handler is restored for this CashAsItem build.
- Shop stock is decremented in qb-inventory's own registered shop after a successful purchase; malformed/negative prices are rejected instead of becoming free.
- Same-inventory rearrangements now report successful completion correctly, and `SetItemData` schedules player persistence.
- Vending shop registrations are ephemeral and removed on close/unload/disconnect.
- The manifest now packs the item-image formats actually present in this resource (`.png`, uppercase `.PNG`, and `.webp`), preventing valid bundled thumbnails from being omitted at runtime.

### Known boundary

- Base-map vending props targeted through `AddTargetModel` can be client-only static objects. With strict vending locations disabled, their physical existence cannot always be independently proven by the server; use `VendingStrictLocations = true` for executor-resistant location authority.
- GTA vehicle door-lock state is still enforced by the normal client vehicle-open path. Cfx exposes `GET_VEHICLE_DOOR_LOCK_STATUS` as a client native; this QBCore-only build deliberately does not add a vehicle-keys dependency. The server still proves the exact vehicle/net id/plate/bucket/distance on every session use.
- Floor drops are intentionally runtime-ephemeral and are cleaned on `qb-inventory` stop; this patch does not invent database persistence for world drops.

---

## [3.0.2] - 2026-09-02 - Player-only close hotfix

- Fixed player-only NUI closes (`name = ""`) being misclassified as `close-no-session`.
- Empty/nil close requests are now treated as idempotent player-inventory closes and still clear `inv_busy`.
- Named secondary inventory closes remain protected by the server session/mismatch checks.

## [3.0.1] - 2026-09-02 - Cfx candidate hardening

### Security

- Removed the unused client-callable snowball grant/removal event.
- Inventory snapshot refreshes now require the same live server session used by
  item transfers before another inventory is returned.
- Drop bootstrap data now exposes only each bag network entity id, not contents
  or internal server state.
- Item giving resolves item identity, quantity bounds and metadata from the
  player's real server-side slot; browser-supplied item metadata is ignored.
- Shop purchases require the player's active shop session, positive integer
  amount/slot values and registered server-side item metadata.
- Cross-inventory swaps now compensate every partial remove/add failure so
  originals are restored rather than silently lost.
- Public AddItem/RemoveItem paths reject malformed item names/slots and AddItem
  refuses to overwrite an occupied explicit slot.
- Player-search locks are acquired for both participants before the target
  inventory opens, closing the two-robber race window.
- Disconnect/resource-restart cleanup releases stale search locks and sessions.
- ID-card and driver-license displays resolve identity metadata from the real
  server inventory slot instead of trusting client-supplied item info.
- Shop, stash and floor-drop opens now acquire the server busy lock consistently,
  and forced closes release related session locks.

### Fixed

- Closing a player-only inventory now always closes the server session, so
  `inv_busy` cannot remain stuck simply because there was no secondary name.
- Resource-start player method registration now uses the actual server ids from
  `QBCore.Functions.GetPlayers()` rather than the array indexes.

### Release cleanup

- Public `CashAsItem` default changed to `false` so stock QBCore installs boot
  without a required core money patch.
- Removed internal development notes and obvious branded/digital-asset sample
  item art; added a generic missing-image fallback.
- Added third-party notices for vendored browser libraries and fonts.
- Removed the deprecated `lua54 'yes'` manifest directive; current Cfx runtimes
  use Lua 5.4 without it.
- Removed the unused Font Awesome Brands stylesheet/font after replacing the
  branded Dropbox UI glyph with a generic solid box icon.

---

## [3.0.0] - 2026-09-02 - Security hardening and public release

First public release. This version closes eight server-side exploits, so it is a
breaking change for any resource that relied on the old unguarded events.

### Security

- **Server-authoritative inventory sessions.** `server/sessions.lua` existed but
  was never loaded or called by anything. It is now wired into the manifest and
  enforced. `qb-inventory:server:SetInventoryData` previously trusted the
  `fromInventory` string, so a single client event drained any online player,
  any floor drop, or any cached stash from anywhere on the map. Every move is
  now checked against the inventory the server says that player has open, and
  distance is revalidated on every move.
- **`inventory:server:OpenInventory` is no longer open to clients.** This event
  could open any player's inventory, register an attacker-defined shop with
  attacker-defined prices, or open any stash with attacker-chosen slots and
  weight. Client-originated calls are now refused and logged, matching the guard
  already applied to the legacy item events. `otherplayer` is never honoured
  from a client.
- **Robbery now uses a server-issued token.** The hands-up check, the progress
  bar and the dead check all ran on the client, so triggering
  `qb-inventory:server:robPlayer` directly skipped all of them and opened the
  target's inventory instantly. The server now issues a single-use expiring
  token and refuses the event without one. `robbery:server:handsUpResult` only
  accepts an answer from the player actually being probed.
- **`qb-inventory:server:updateDrop` is validated.** It accepted any drop id and
  any coordinates from any client, letting a player teleport every bag on the
  map to their feet (and throwing a nil-index error on an unknown id). Bag
  pickup is now server-validated and records a carrier; only that carrier can
  move the bag, and only to their own real server-side position.
- **`AddItem` and `RemoveItem` bound their amounts.** Neither floored the value
  and `AddItem` accepted negatives, which was a direct money printer while
  `Config.CashAsItem` is enabled.
- **`closeInventory` is type-checked and scoped.** It called `:find()` before any
  type check, so a number or table crashed the handler, and any client could
  clear any other player's `inv_busy` lock. Closing a drop or stash now requires
  actually being the player who has it open.
- **Vending machines are server-positioned.** The shop was built from
  client-supplied coordinates and the purchase check then validated the player
  against those same coordinates, so the check compared the attacker's number
  against itself. Shop coordinates now come from the player's real server-side
  position, and each player gets their own shop key so two machines no longer
  race each other.
- **Trunk and glovebox identity is verified.** The client returned a bare
  `trunk-<plate>` string and the server opened whatever it was given, so a
  spoofed callback opened any vehicle on the map. The client now reports the
  vehicle's network id and the server resolves that entity itself, checking it
  is a real vehicle, that the plate matches, and that the player is at it.

### Fixed

- `GetFirstFreeSlot` was a file-local in `server/functions.lua` but called from
  `server/main.lua`, so it resolved to nil and errored every time a second drop
  landed on an existing netId.
- `SanitizeInventory` had the same cross-file scope bug in the other direction,
  breaking any stash loaded from the database after startup.
- `while not exports['qb-target'] do Wait(100) end` never waited, because the
  exports proxy is always truthy. It now waits on the resource state.
- Player search only worked on peds that existed when the resource started.
  Anyone who joined later could not be searched. Now uses `AddGlobalPlayer`.
- `qb-target` is a hard dependency and is now declared as one.

### Changed

- All eleven front-end CDN requests are vendored into `html/vendor/`. A CDN
  outage or a restricted client network no longer breaks the inventory UI.
- The bundled Font Awesome Kit script was removed. It billed a single private
  account for every server that installed this resource, and was redundant
  alongside the free Font Awesome CSS already loaded.
- `Config.CustomHUD` now defaults to disabled, since it pointed at a
  server-specific HUD resource nobody else has.
- The robbery Discord webhook and the `printerdocument` image URL moved into
  `config/config.lua`.
- Save logging and the `REMOVEITEM` diagnostics are behind `Config.Debug`.
- The drop-carry thread no longer runs every frame when no bag is held.

### Removed

- The unused second UI (`html/ui.html`, `html/css/`, `html/js/`) - roughly 3,700
  lines of dead Quasar front-end pointing at asset folders that do not exist.
- Unreferenced `html/dark/` artwork.
- Dead `qb-inventory:server:RobPlayer` client event that nothing ever fired.
- Dead `Config.UseTarget`, which nothing read.

---

## [2.6.3] - Cash authority / display hotfix

### Fixed

- Physical `cash` is written as one canonical stack instead of routing repairs
  back through generic `AddItem`/`RemoveItem`.
- Removed the 2.6.2 false "free an inventory slot" failure when a valid cash
  stack or free slot already existed.
- Supports both stock QBCore money functions and older builds that already route
  cash through qb-inventory.
- Cash item changes update `PlayerData.money.cash` directly, so vehicle shops
  and other framework scripts keep normal buying power.
- Added an authoritative server cash-state request on player and resource load.
- Added a 5-second drift reconciler for forks that mutate cash without emitting
  the normal money event.
- Added `/cashcheck` to compare physical cash against QBCore cash in game.
- Cash slots display as currency (`$34,601,900`) instead of `x34601900`.

## [2.6.2] - Cash synchronization hotfix

### Fixed

- `AddMoney`, `RemoveMoney` and `SetMoney` for `cash` now synchronize with the
  physical `cash` inventory item.
- Account-only cash is migrated into a physical item when none exists yet;
  existing physical cash stays authoritative on disagreement.
- Inventory-originated cash changes update buying power without recursion.
- A failed cash item write rolls QBCore cash back to the real item total.
- Clear startup warning when `Config.CashAsItem` is on but `qb-core` has no
  `cash` item.

## [2.6.1] - Drop and inventory synchronization

### Fixed

- Floor drops return the authoritative player and drop inventories in one
  response, removing the NUI's duplicate local subtraction that could make cash,
  weapons and items appear twice or briefly vanish.
- Moves, merges, splits and swaps reconcile both panels from a server snapshot.
- Stale ghost-item moves correct themselves without reopening the inventory.
- One-operation-at-a-time NUI gating while a transaction is in flight.
- Unique drop operation ids, per-player drop locks and a short idempotency cache
  stop repeated callbacks creating or removing the same item twice.
- Failed bag creation refunds the removed item.
- Drop entity waits are bounded and run outside the NUI callback.
- Fixed give-item refresh using an undefined `TargetPlayer` variable.

## [2.6.0] - Crisp text, real stacking, shop-build attachments

### Fixed

- Menu used `transform: scale(.75)`, which rasterizes text at full size and then
  shrinks it, making every label blurry. Now uses `zoom: 0.75`, so glyphs render
  pixel-crisp at the same visual size and position.
- Removed a stray `filter: blur(.1px)` and switched `text-rendering` from
  `geometricPrecision` to `optimizeLegibility`.
- Drag ghost matches the zoomed slot size and tracks the cursor correctly.

### Added

- `Config.StackWithDifferentExpiry`: non-unique items stack by name even when
  freshness differs. Merged stacks keep the earlier expiry, so stacking can
  never extend an item's life.
- Weapon Inspection trusts shop metadata directly, so attachments show even when
  qb-weapons has no mapping for that weapon.
- "Other Attachments" overflow section, so nothing installed is ever invisible.
- Attachment slots use the item's real inventory image.

## [2.5.0] - Rework sync

### Added

- Synced the backend with the APCode `qb-inventory-rework` source while
  preserving the zombie UI, images, fonts, CSS and menu layout.
- Decay/server-time tooltip support and expiry-aware stacking checks.

## [2.2.1] - Slot and attachment fixes

### Fixed

- Occupied-slot swaps save immediately server side and persist after reopening.
- `SaveInventory` writes each item using `item.slot` when available.
- Attachment panel accepts item-name fallback data, not only component matching.
