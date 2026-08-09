# RS Prebuilt Weapon Store Attachment Read Patch

Changed files only:

- qb-inventory/client/main.lua
- qb-inventory/server/main.lua

Purpose:

- Reads attachments that are already saved on weapons purchased from weapon shops.
- Supports multiple common metadata formats:
  - info.attachments = { { component = 'COMPONENT_AT_PI_FLSH' } }
  - info.attachments = { { component = joaat('COMPONENT_AT_PI_FLSH') } }
  - info.attachments = { flashlight_attachment = { component = 'COMPONENT_AT_PI_FLSH' } }
  - info.components / info.mods / info.weaponAttachments style fields
  - attachment item key saved directly, such as flashlight_attachment
- Uses the server registered shop item info as the source of truth during purchase.
- Keeps the Rework-style Weapon Inspection panel able to display and remove the attachments.

Install with WinSCP:

Upload:

- qb-inventory/client/main.lua
- qb-inventory/server/main.lua

Then restart:

restart qb-inventory

No images, CSS, HTML, config, escrow, or assetpacks were changed.
