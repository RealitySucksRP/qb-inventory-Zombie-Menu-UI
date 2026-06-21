# Tebex Ready Notes

Product type: File Download

This is an open-source resource. It does not use FiveM escrow, `/assetpacks`, or `escrow_ignore`.

Buyer install steps:

1. Download the ZIP from Tebex.
2. Extract it.
3. Place the `qb-inventory` folder in the server resources folder.
4. Add `ensure qb-inventory` after `qb-core`, `qb-weapons`, and `oxmysql`.
5. Configure HUD/cash sync in `config/config.lua`.
6. Restart the server.

HUD note:

The example HUD name is only a placeholder. Buyers must replace `your-hud-resource` / `rs-lilhudlife` examples with the HUD they actually use.
