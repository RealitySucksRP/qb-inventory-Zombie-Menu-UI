# RealitySucksRP QB Inventory Zombie UI v2.6.1 — Drop/Inventory Synchronization

## Fixed

- Floor drops now return the authoritative server-side player inventory and floor-drop inventory in one response.
- Removed the NUI's second local subtraction, which could make cash, black money, weapons, and normal items appear twice or temporarily disappear.
- Preserved the zombie UI's drop confirmation dialog while making its final result server-authoritative.
- Player inventory refresh events now carry the authoritative item table instead of rereading stale cached client data.
- Inventory moves, merges, splits, and swaps reconcile both inventory panels from a server snapshot after every operation.
- Rejected or stale ghost-item moves are corrected without requiring the inventory to be closed and reopened.
- Added one-operation-at-a-time NUI gating while a transaction is awaiting the server.
- Added unique drop operation IDs, per-player drop locks, and a short idempotency cache to stop repeated drop callbacks from removing or creating the same item twice.
- Failed bag creation or networking refunds the removed item to the authoritative player inventory.
- Drop entity waits are bounded and run outside the NUI callback so a missing network object cannot freeze the menu.
- Floor-drop locks are released when switching bags, closing inventory, or disconnecting.
- Fixed the zombie variant's give-item refresh using an undefined `TargetPlayer` variable; the recipient now receives the correct authoritative inventory table.
- Preserved the existing cash-as-item helpers, legacy give-item callback, APCode backend, zombie artwork, drop confirmation UI, HUD bridge, expiry stacking, and `rs-incidentlink` robbery reporting.

## Compatibility

- No SQL changes.
- No config changes.
- No CSS, image, item-definition, or inventory-layout changes.
- Resource folder name remains `qb-inventory`.

## Version

`2.6.1-rs-zombie-drop-sync`
