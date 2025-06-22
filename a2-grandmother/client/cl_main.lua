local QBCore = exports['qb-core']:GetCoreObject()

-- Citizen.CreateThread(function()
--     while true do
--         Wait(500)
--         if IsEntityDead(ped) then
--             dead = true
--         else
--             dead = false
--         end
--     end
-- end)

-- local player = PlayerPedId(-1)
-- local dead = false

-- function CheckPlayerIfHeDead()
--     if IsEntityDead(player) then
--         dead = true
--     print("awdaw")
--     else
--     end
-- end

-- Citizen.CreateThread(function ()
--     while true do
--         CheckPlayerIfHeDead(player)
--         Wait(500)
--     end
-- end)



-- RegisterNetEvent("revivefull1", function()
--     local ped1 = PlayerPedId()
--     if dead then
--         print("pd")
--         QBCore.Functions.Progressbar('Revive', 'Reviveng...', 15000, false, true, {
--             disableMovement = true,
--             disableCarMovement = true,
--             disableMouse = false,
--             disableCombat = true
--             }, {}, {}, {}, function()
--                 CheckPlayerIfHeDead()
--                 if Config.emsscipt == "qbx" then
--                     dead = false
--                 TriggerEvent('qbx_medical:client:playerRevived')
--                 elseif Config.emsscipt == "qb" then
--                     dead = false
--                     TriggerEvent("hospital:client:RevivePlayer")
--                 else
--                     dead = false
--                     TriggerEvent("hospital:client:RevivePlayer")
--                 end
--                 ClearPedTasks(ped1)
--                 QBCore.Functions.Notify("Wake up my son!", "success")
--             end, function()
--         end)
--     else
--         QBCore.Functions.Notify("You are not dead!", "error")
--     end

-- end)



RegisterNetEvent("revivefull1", function()
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if not PlayerData.metadata.inlaststand and not PlayerData.metadata.isdead then
        QBCore.Functions.Notify("You're fine son.", "error")
        return
    end
    QBCore.Functions.Progressbar('Revive', 'Reviving...', 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function()

        if Config.emsscipt == "qbx" then
            TriggerEvent('qbx_medical:client:playerRevived')
        else
            TriggerEvent("hospital:client:RevivePlayer")
        end
        ClearPedTasks(ped)
        QBCore.Functions.Notify("Wake up my son!", "success")
    end)
end)














CreateThread(function ()
    local pedModel = GetHashKey(Config.Ped.Model)
    local coords = vec3(Config.Ped.coords)
    local heading = Config.Ped.heading
    local coordsmin = vec3(coords.x, coords.y, coords.z + 1)

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(10)
    end

    local ped = CreatePed(4, pedModel, coords.x, coords.y, coords.z, heading, true, true)
    FreezeEntityPosition(ped, true)

    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    
    SetModelAsNoLongerNeeded(pedModel)

    -- exports.interact:AddInteraction({
    --     coords = coordsmin,
    --     distance = 4.0,                  -- optional
    --     interactDst = 2.0,                 -- optional
    --     id = "revive", -- needed for removing interactions
    
    --     options = { {
    --         label = 'Talk To me',
    --         event = "revivefull1"
    --     } }
    -- })
    exports['qb-target']:AddBoxZone("revive", coordsmin, 1.5, 1.5, {
        name = "revive",
        heading = 160.0,
        debugPoly = false,
        minZ = 28.5,
        maxZ = 30.5
      }, {
        options = {
          {
            type = "client",
            event = "revivefull1",
            icon = "fa-solid fa-notes-medical",
            label = "Talk to me",
            targeticon = "fa-solid fa-notes-medical",
          }
        },
        distance = 3.0
      })
end)