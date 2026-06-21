Config = {
    -- RealitySucks cash-as-item mode.
    -- TRUE = shops remove the physical `cash` item from inventory, then sync QBCore cash/HUD to that item count.
    -- Requires qb-core/shared/items.lua to have a `cash` item.
    CashAsItem = true,

    -- Optional HUD integration.
    -- IMPORTANT: `rs-lilhudlife` is only an example from the RealitySucksRP server.
    -- Server owners should replace ResourceName / ExportName with their own HUD, or leave Enabled = false.
    -- This hide/show export is only used to hide the HUD while the inventory menu is open.
    CustomHUD = {
        Enabled = false,
        ResourceName = 'your-hud-resource', -- Example: 'rs-lilhudlife', 'qb-hud', 'ps-hud', etc.
        ExportName = 'SetHUDLifeVisible',  -- Replace with your HUD's show/hide export if it has one.

        -- Optional cash sync events.
        -- qb-inventory always triggers: qb-inventory:client:updateCash(cashAmount)
        -- Add your own HUD client event here if your HUD needs a custom event name.
        -- Example: MoneySyncEvents = { 'myhud:client:UpdateCash' }
        MoneySyncEvents = {}
    },

    UseTarget = GetConvar('UseTarget', 'false') == 'true',

    -- Kept at 40 for the zombie 5-column menu design.
    MaxWeight = 120000,
    MaxSlots = 40,

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

    VendingItem = {
        { name = 'water_bottle', price = 4 },
        { name = 'kurkakola', price = 4 },
    }
}
