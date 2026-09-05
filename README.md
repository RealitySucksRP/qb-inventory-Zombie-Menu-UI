<p align="center">
  <img src="images/zombie.png" alt="RS Zombie Inventory Preview" width="100%">
</p>

<p align="center">
  <a href="https://ko-fi.com/R6R51XYJ6N">Support RealitySucksRP on Ko-fi</a> ·
  <a href="https://reality-sucks-rp-webstore.tebex.io/">RealitySucksRP Tebex Store</a>
</p>

# RealitySucksRP qb-inventory — Zombie Edition

## Upstream project and credit

This repository is a **modified derivative** of [Anya Project / AP Code — `qb-inventory-rework`](https://github.com/anya-project/qb-inventory-rework).

The Anya Project/AP Code contributors are credited for the upstream inventory rework and its original feature work. RealitySucksRP maintains this Zombie edition with its apocalypse UI/art direction, synchronization and security hardening, compatibility work, and edition-specific changes.

This modified edition remains licensed under **GPL-3.0**. The upstream project and license notices must be preserved when redistributing modified copies.

**RealitySucksRP modification notice updated:** September 4, 2026.

---

**IN SERVER.CFG MAKE SURE YOU NAME THIS RESOURCE `qb-inventory` AND REMOVE THE WORD ZOMBIE.**

A reworked, hardened inventory for the QBCore framework with the RealitySucksRP zombie UI. It supports cash as an item, weapon attachments, floor drops, player searching, and a server-authoritative backend.

## Features

- Open-source release
- Custom RealitySucksRP Zombie UI
- Dark survival / outbreak-style inventory design
- Right-click menu support
- Use, Give, Drop, Split, Copy Serial, and Attachments options
- Weapon attachment inspection panel
- Ground item drops
- Drop confirmation window
- Vehicle trunk and glovebox support
- Stash and shop support
- Weapon serial and durability support
- Hotbar support
- Cash-as-item support
- HUD money-sync configuration
- Marked / black-money item support
- Item freshness / expiration support
- Editable CSS and UI images
- Server-authoritative reconciliation
- Duplicate-request protection
- Floor-drop recovery
- Automatic cash-state correction
- No escrow protection

## Fully Customizable

Editable areas include:

```text
html/main.css
html/index.html
html/images/
```

You can replace zombie art, skeleton art, server logos, backgrounds, item images, branding, menu colors, positions, and sizes.

## Dependencies

Required:

- `qb-core`
- `qb-weapons`
- `oxmysql`
- `qb-target`

Optional integrations can be configured for your HUD and other QBCore-compatible resources.

## Installation

1. Back up your existing inventory and player data.
2. Place the resource inside your server resources folder.
3. Rename the active resource folder to `qb-inventory`.
4. Ensure required dependencies start first.
5. Configure cash, HUD sync, and inventory settings in `config/config.lua`.
6. Restart the server.

## Credits

- Original QB Inventory foundation: QBCore Framework project
- Upstream rework: [Anya Project / AP Code — qb-inventory-rework](https://github.com/anya-project/qb-inventory-rework)
- Zombie UI, RealitySucksRP styling, additional synchronization/security hardening, integrations, and release packaging: **RealitySucksRP**

## License

This repository remains under the **GNU General Public License v3.0 (GPL-3.0)** in accordance with the upstream project. See `LICENSE` and `UPSTREAM_ATTRIBUTION.md`.
