local RSGCore = exports['rsg-core']:GetCoreObject()

--------------------------------------------------------------------------------------------------

-- hotel prompts
Citizen.CreateThread(function()
    for hotel, v in pairs(Config.HotelLocations) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg-hotel:client:menu',
            args = { v.location, v.name },
        })
        if v.showblip == true then
            local HotelBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(HotelBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(HotelBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, HotelBlip, Config.Blip.blipName)
        end
    end
end)

-- hotel menu
RegisterNetEvent('rsg-hotel:client:menu', function(location, name)
    exports['rsg-menu']:openMenu({
        {
            header = name,
            isMenuHeader = true,
        },
        {
            header = 'Rent a Room',
            txt = '',
            icon = "fas fa-shopping-basket",
            params = {
                event = 'rsg-hotel:server:EnterRoom',
                isServer = true,
                args = { enterhotel = location }
            }
        },
        {
            header = 'Close Menu',
            txt = '',
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
	
end)

--------------------------------------------------------------------------------------------------

-- room menu prompt
Citizen.CreateThread(function()
    for hotelexit, v in pairs(Config.HotelRoom) do
        exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds['J'], 'Room Menu', {
            type = 'client',
            event = 'rsg-hotel:client:roommenu',
            args = { v.location },
        })
    end
end)

-- room menu
RegisterNetEvent('rsg-hotel:client:roommenu', function(location)
    exports['rsg-menu']:openMenu({
        {
            header = 'Room Menu',
            isMenuHeader = true,
        },
        {
            header = 'Leave Room',
            txt = '',
            icon = "fas fa-shopping-basket",
            params = {
                event = 'rsg-hotel:server:LeaveRoom',
                isServer = true,
                args = { exithotel = location }
            }
        },
        {
            header = 'Close Menu',
            txt = '',
            params = {
                event = 'rsg-menu:closeMenu',
            }
        },
    })
	
end)

--------------------------------------------------------------------------------------------------

-- teleport to room
RegisterNetEvent('rsg-hotel:client:roomteleport')
AddEventHandler('rsg-hotel:client:roomteleport', function(enterhotel)
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1000)
    if enterhotel == 'valentine' then
        Citizen.InvokeNative(0x203BEFFDBE12E96A, ped, vector4(-323.935, 767.02294, 121.6327, 102.64147))
    end
    Wait(1500)
    DoScreenFadeIn(1800)
end)

-- leave room
RegisterNetEvent('rsg-hotel:client:leaveroomteleport')
AddEventHandler('rsg-hotel:client:leaveroomteleport', function(exithotel)
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1000)
    if exithotel == 'valentine' then
        Citizen.InvokeNative(0x203BEFFDBE12E96A, ped, vector4(-322.2785, 770.36541, 121.63187, 103.80873))
    end
    Wait(1500)
    DoScreenFadeIn(1800)
end)

--------------------------------------------------------------------------------------------------

-- lock motel doors
Citizen.CreateThread(function()
    for k,v in pairs(Config.MotelDoors) do
        Citizen.InvokeNative(0xD99229FE93B46286, v, 1,1,0,0,0,0)
        DoorSystemSetDoorState(v, 1) 
    end
end)

--[[
    DOORSTATE_INVALID = -1,
    0 = DOORSTATE_UNLOCKED,
    1 = DOORSTATE_LOCKED_UNBREAKABLE,
    2 = DOORSTATE_LOCKED_BREAKABLE,
    3 = DOORSTATE_HOLD_OPEN_POSITIVE,
    4 = DOORSTATE_HOLD_OPEN_NEGATIVE
--]]

-- val inside room : vector4(-323.7338, 767.19439, 121.63269, 110.0977)
