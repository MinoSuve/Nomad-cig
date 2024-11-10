local QBCore = exports['qb-core']:GetCoreObject()
-- Cigarette Pack Damage
RegisterNetEvent('Nomad-cig:server:RemoveCigarette', function()
    local playerId = source
    local itemName = 'sikharicepack'
    local inventory = exports.ox_inventory:Search(playerId, 1, itemName)
    if inventory[1] and inventory[1].metadata.durability then
        -- Get the current durability of the item
        local currentDurability = inventory[1].metadata.durability
        -- Simulate consumption by reducing durability (for example, reduce by 10%)
        local newDurability = currentDurability - 5
        if newDurability < 5 then
            newDurability = 0
            -- Optionally remove the item if its durability reaches zero
            exports.ox_inventory:RemoveItem(playerId, itemName, 1)
        else
            -- Update the item's metadata with the new durability
            local slot444 = inventory[1].slot
            exports.ox_inventory:SetDurability(playerId, slot444, newDurability)
        end
    end
end)

-- Cigarette Pack Opened
RegisterNetEvent('Nomad-cig:server:addCigarette', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("cigarette", 1)
end)

--Cigarette remove
RegisterNetEvent('Nomad-cig:server:removecig', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem("cigarette", 1)
end)

--check lighter
RegisterNetEvent('Nomad-cig:server:check_lighter', function()
    local playerId = source
    local item  = exports.ox_inventory:GetItem(playerId,'lighter',nil,true)
    if item > 0 then 
         TriggerClientEvent("Nomad-cig:client:UseCigarette",playerId)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'System',
            description ="You don't have a lighter",
            type = 'error', -- Types: 'success', 'error', 'info', 'warning'
            duration = 2000 -- Duration in milliseconds
        })
    end
end)
--just for testing 
QBCore.Commands.Add("addstress", "Add stress to a player (Admin Only)", {{name = "amount", help = "Amount of stress to add"}}, true, function(source, args)
    local src = source -- Get the player's server ID
    local stressAmount = tonumber(args[1]) -- Get the stress amount from command argument

    if stressAmount then
        local Player = QBCore.Functions.GetPlayer(src) -- Get the player object

        if Player then
            local currentStress = Player.PlayerData.metadata["stress"] or 0 -- Get current stress
            local newStress = currentStress + stressAmount -- Add the stress amount
            if newStress > 100 then newStress = 100 end -- Cap stress at 100

            -- Set the new stress level in the player's metadata
            TriggerClientEvent('hud:client:UpdateStress', src, newStress)

            -- Notify the player
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'System',
                description ="You feel more stressed!",
                type = 'error', -- Types: 'success', 'error', 'info', 'warning'
                duration = 2000 -- Duration in milliseconds
            })
            print("Added " .. stressAmount .. " stress to player " .. src)
        end
    else
        -- Notify player if command usage is incorrect
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'System',
            description ="Invalid stress amount",
            type = 'error', -- Types: 'success', 'error', 'info', 'warning'
            duration = 2000 -- Duration in milliseconds
        })
    end
end, "admin") -- Restrict the command to admins
