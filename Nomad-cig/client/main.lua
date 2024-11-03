local QBCore = exports['qb-core']:GetCoreObject()

-- Cigarette Pack
RegisterNetEvent('Nomad-cig:client:UseCigPack', function(ItemData) -- On Item Use (registered server side)
    LocalPlayer.state:set("inv_busy", true, true)
    local playerId = source
    QBCore.Functions.Progressbar("pickup_sla", "Opening Cigarette Pack...", Config.PackOpenTime * 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_clipboard@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(playerPed, "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("You got a cigarette from the pack", "success")
        TriggerServerEvent('Nomad-cig:server:addCigarette')
        TriggerServerEvent("Nomad-cig:server:RemoveCigarette")
        end, function()
        QBCore.Functions.Notify("Cancelled...", "error")
    end)
    LocalPlayer.state:set("inv_busy", false, true)
end)

-- Cigarette Use
RegisterNetEvent('Nomad-cig:client:UseCigarette')
AddEventHandler('Nomad-cig:client:UseCigarette', function()
    QBCore.Functions.Progressbar("smoke_joint", "Lighting cigarette...", Config.LightCigTime * 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
    else
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
    end
    TriggerServerEvent('Nomad-cig:server:removecig')--remove cig 
    for i = 1, 2, 1 do -- You can edit 5 for amount you want
            Wait(1500) -- Wait 1.5 seconds to exec event.
            TriggerServerEvent('hud:server:RelieveStress', math.random(Config.MinStress, Config.MaxStress)) -- Remove stress.
        end
        TriggerEvent("evidence:client:SetStatus", "tobaccosmell", 300)
    end)
end)

RegisterNetEvent('Nomad-cig:client:UseCig444', function()
    TriggerServerEvent('Nomad-cig:server:check_lighter')
end)