# RS Zombie Inventory Fixes v2.2.1

## Fixed
- Occupied-slot swaps now save immediately server-side.
- Player inventory saves on close so swapped slots persist after reopening.
- SaveInventory now writes each item using item.slot when available.
- Weapon attachment panel now accepts attachment item-name fallback data, not only component matching.
- Attachment panel icons now use attachment.image/item/attachment fallback names.
- Zombie UI text readability improved without changing the overall design.

## Test
1. Swap two occupied player inventory slots.
2. Close inventory.
3. Reopen inventory.
4. Confirm both items stayed swapped.
5. Right-click a weapon with attachments, choose Attachments, confirm icons/labels show.
