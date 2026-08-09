Config = {
    -- RealitySucks cash-as-item mode.
    -- TRUE = shops remove the physical `cash` item from inventory, then sync QBCore cash/HUD to that item count.
    -- Requires qb-core/shared/items.lua to have a `cash` item.
    CashAsItem = true,

    -- Optional HUD hide/show hook for William's zombie HUD.
    -- Inventory will call exports['rs-hudlifev4']:SetHUDLifeVisible(false/true) when open/closed.
    CustomHUD = {
        Enabled = true,
        ResourceName = 'rs-lilhudlife',
        ExportName = 'SetHUDLifeVisible'
    },

    UseTarget = GetConvar('UseTarget', 'false') == 'true',

    -- Kept at 40 for the zombie 5-column menu design.
    MaxWeight = 120000,
    MaxSlots = 40,

    -- TRUE = non-unique items always stack by name, even when their freshness/expiry
    -- differs. Merged stacks keep the EARLIER expiry so stacking never extends item life.
    -- FALSE = old behavior: stacks only combine when expiry dates match exactly.
    StackWithDifferentExpiry = true,

    StashSize = {
        maxweight = 2000000,
        slots = 100
    },

    DropSize = {
        maxweight = 1000000,
        slots = 50
    },

    Keybinds = {
        Open = 'TAB',
        Hotbar = 'Z'
    },

    -- Drop/bag cleanup and object settings synced from qb-inventory-rework.
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
