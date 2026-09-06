Config = {
    -- Cash-as-item mode.
    -- TRUE  = shops remove the physical `cash` item from the inventory, then sync
    --         QBCore cash/HUD to that item count.
    -- FALSE = normal QBCore money handling.
    -- Requires qb-core/shared/items.lua to have a `cash` item.
    --
    -- THIS SERVER: true, matching the RS Punk build. Both builds are the same
    -- brain and only differ in menu art, so this must not drift between them --
    -- with it false, server/cash_sync.lua is entirely dormant (every entry point
    -- early-returns on this flag) and any physical `cash` item a player already
    -- holds becomes inert: qb-core stops reading it, and the item is
    -- useable = false so they cannot convert it back themselves.
    --
    -- Verified present before enabling: the `cash` item in
    -- qb-core/shared/items.lua, and the cash-as-item branches in
    -- qb-core/server/player.lua (AddMoney / RemoveMoney / GetMoney).
    CashAsItem = true,

    -- Physical currency item used when CashAsItem is enabled. Keeping this in
    -- one place prevents death/respawn preservation and the cash sync layer
    -- from drifting onto different hard-coded names.
    CashItemName = 'cash',

    -- Optional hook to hide a custom HUD while the inventory is open. Inventory
    -- calls exports[ResourceName]:ExportName(false/true) on open/close.
    -- Disabled by default because the named resource is server specific: set
    -- Enabled = true and point ResourceName/ExportName at your own HUD.
    -- THIS SERVER: enabled, matching the RS Punk build. rs-lilhudlife is
    -- installed and ensured here, and does export SetHUDLifeVisible
    -- (client/main.lua:2322) -- verified, because pointing this at an export
    -- that does not exist is a "No such export" error every time the inventory
    -- opens. Ship it Enabled = false to anyone who does not run that HUD.
    CustomHUD = {
        Enabled = true,
        ResourceName = 'rs-lilhudlife',
        ExportName = 'SetHUDLifeVisible'
    },

    -- Discord webhook for player robbery logs. Leave empty to disable logging.
    RobberyWebhook = '',

    -- Image a /giveitem printerdocument starts with. Leave empty for none.
    DefaultPrinterDocumentUrl = '',

    MaxWeight = 120000,
    MaxSlots = 40,

    -- TRUE = non-unique items always stack by name, even when their freshness/expiry
    -- differs. Merged stacks keep the EARLIER expiry so stacking never extends item life.
    -- FALSE = stacks only combine when expiry dates match exactly.
    StackWithDifferentExpiry = true,

    StashSize = {
        maxweight = 2000000,
        slots = 100
    },

    DropSize = {
        maxweight = 1000000,
        slots = 50
    },

    -- How far a player may stray from an inventory they have open before the
    -- server stops honouring item moves. Distance is revalidated on every move,
    -- so opening legitimately and then walking away does not keep access.
    DropAccessDistance = 3.5,
    PlayerAccessDistance = 3.5,
    ShopAccessDistance = 6.0,

    Keybinds = {
        Open = 'TAB',
        Hotbar = 'Z'
    },

    -- Drop/bag cleanup and object settings.
    CleanupDropTime = 15,    -- minutes before a ground drop is cleaned
    CleanupDropInterval = 1, -- minutes between cleanup checks

    ItemDropObject = `bkr_prop_duffel_bag_01a`,
    ItemDropObjectBone = 28422,
    ItemDropObjectOffset = {
        vector3(0.260000, 0.040000, 0.000000),
        vector3(90.000000, 0.000000, -78.989998),
    },

    VendingObjects = {
        'prop_vend_soda_01',
        'prop_vend_soda_02',
        'prop_vend_water_01',
        'prop_vend_coffe_01',
    },

    VendingItems = {
        { name = 'kurkakola',    price = 4, amount = 50 },
        { name = 'water_bottle', price = 4, amount = 50 },
    }
}
