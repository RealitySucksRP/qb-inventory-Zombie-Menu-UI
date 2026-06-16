# v2.5.2 - Tebex Open Source Packaging Cleanup

- Confirmed open-source delivery setup.
- Removed escrow/assetpack delivery assumptions.
- Cleaned `fxmanifest.lua` for normal server download/use.
- Added clear Tebex file-download instructions.
- Clarified that `rs-lilhudlife` is only an example HUD and not a dependency.
- Added buyer HUD/cash-sync instructions.
- Renamed SQL file to `qb-inventory.sql`.
- Removed dev/hidden file and non-image markdown file from `html/images`.


## 2.5.1-rs-zombie-open-source-hud-ready

- Cleaned HUD config so `rs-lilhudlife` is clearly marked as an example only.
- Disabled custom HUD hide/show by default so buyers are not forced into William's HUD.
- Added generic cash sync support through `qb-inventory:client:updateCash`.
- Added optional `Config.CustomHUD.MoneySyncEvents` for server owners with custom HUD event names.
- Added `README_HUD_CASH_SETUP.md` with buyer/server-owner setup instructions.
- Fixed README mismatch around `Config.CashAsItem`.

# qb-inventory zombieUI


## v2.2.2 - Attachment Item Keys Fix

- Added `RS_ATTACHMENT_ITEMS_SNIPPET.lua` for missing QBCore item definitions.
- Fixes blocked attachment removal for:
  - `carbine_extendedclip`
  - `pistol_suppressor_only`
- Prevents ghost items while allowing removed attachments to return as real inventory items.
- No core swap/cash/UI redesign changes in this patch.
