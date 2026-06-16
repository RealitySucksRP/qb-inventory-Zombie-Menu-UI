# HUD + Cash Setup for Server Owners

This inventory is open source and is not locked to the RealitySucksRP HUD.

The example HUD name `rs-lilhudlife` is only William's test/server HUD. Buyers should replace it with their own HUD resource name or leave the custom HUD option disabled.

## 1. Inventory hide/show while menu is open

In `config/config.lua`:

```lua
CustomHUD = {
    Enabled = false,
    ResourceName = 'your-hud-resource',
    ExportName = 'SetHUDVisible',
    MoneySyncEvents = {}
}
```

Set `Enabled = true` only if your HUD has an export that can hide/show the HUD.

Example only:

```lua
CustomHUD = {
    Enabled = true,
    ResourceName = 'my-hud',
    ExportName = 'SetHUDVisible',
    MoneySyncEvents = {}
}
```

Your HUD export must accept a boolean:

```lua
exports('SetHUDVisible', function(show)
    -- show = true when inventory closes
    -- show = false when inventory opens
end)
```

## 2. Cash display matching inventory money

This inventory sends the current cash amount on the client with:

```lua
TriggerEvent('qb-inventory:client:updateCash', cashAmount)
```

Add this to your HUD client file if your HUD needs to display cash from the inventory item:

```lua
RegisterNetEvent('qb-inventory:client:updateCash', function(cashAmount)
    cashAmount = tonumber(cashAmount) or 0

    -- Replace this with your HUD's own state/NUI update
    SendNUIMessage({
        action = 'updateCash',
        cash = cashAmount
    })
end)
```

If your HUD already listens to a different event, add that event name to `MoneySyncEvents`:

```lua
CustomHUD = {
    Enabled = false,
    ResourceName = 'your-hud-resource',
    ExportName = 'SetHUDVisible',
    MoneySyncEvents = {
        'yourhud:client:updateCash'
    }
}
```

Then inside your HUD:

```lua
RegisterNetEvent('yourhud:client:updateCash', function(cashAmount)
    -- update your HUD cash display
end)
```

## 3. Cash-as-item mode

If `Config.CashAsItem = true`, the physical `cash` item amount is the real cash balance.

Server owners must make sure:

- `qb-core/shared/items.lua` has a `cash` item.
- `qb-core/server/player.lua` uses the included cash-as-item/AP money functions.
- Their HUD displays the cash item count from `qb-inventory:client:updateCash`.

If the server wants normal QBCore cash instead, set:

```lua
Config.CashAsItem = false
```

## 4. Important note

`rs-lilhudlife` is not required.

It is only included as an example name so server owners know where to put their own HUD resource/export.

## HUD Money Sync

This inventory includes cash-as-item support. That means the cash item inside the inventory can match the money shown on the player's HUD.

The HUD config included with this resource is only an example. This inventory does **not** require `rs-lilhudlife`.

Server owners must replace the example HUD resource name and event with the HUD they actually use on their server.


I WILL REPEAT THESE STEPS AGAIN BELOW. PLEASE READ CAREFULLY. 

Open:

```text
config/config.lua
```

Find:

```lua
CustomHUD = {
    Enabled = false,
    ResourceName = 'your-hud-resource',
    ExportName = 'SetHUDLifeVisible',
    MoneySyncEvents = {}
}
```

Leave `Enabled = false` if you do not want this inventory to send money updates to a custom HUD.

Set `Enabled = true` only if you want this inventory to notify your HUD when the player's cash amount changes.

Example:

```lua
CustomHUD = {
    Enabled = true,
    ResourceName = 'my-hud',
    ExportName = nil,
    MoneySyncEvents = {
        'my-hud:client:updateCash'
    }
}
```

Your HUD must have an event that accepts the new cash amount.

Example HUD-side code:

```lua
RegisterNetEvent('my-hud:client:updateCash', function(cashAmount)
    -- Update your HUD cash display here.
    -- cashAmount is the player's current cash amount.
end)
```

If your HUD already has its own money update event, add that event name inside `MoneySyncEvents`.

Example:

```lua
MoneySyncEvents = {
    'hud:client:UpdateMoney',
    'myhud:client:setCash'
}
```

Do not leave the example HUD name in place unless that is the HUD you actually use.

`rs-lilhudlife` is only an example from the RealitySucksRP test server. Replace it with your own HUD resource name, export, or event.

### Quick Setup

1. Open `config/config.lua`.
2. Find `CustomHUD`.
3. Change `ResourceName` to your HUD resource name.
4. Add your HUD cash update event inside `MoneySyncEvents`.
5. Set `Enabled = true`.
6. Restart `qb-inventory`.
7. Buy, drop, deposit, or receive cash and confirm the HUD amount matches the inventory cash item.

### Important

If your HUD does not update after setup, check your HUD documentation for the correct client event or export used to update cash/money display.

This resource cannot automatically know every custom HUD event name. The server owner must enter the correct HUD event or export for their own HUD.

