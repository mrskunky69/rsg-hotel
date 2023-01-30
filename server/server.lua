local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-hotel:server:EnterRoom', function(data)
    print(data.enterhotel)
    local enterhotel = data.enterhotel
    local src = source
    local bucket = math.random(1,9999999999)
    RSGCore.Functions.SetPlayerBucket(src, tonumber(bucket))
    TriggerClientEvent('rsg-hotel:client:roomteleport', src, enterhotel)
    --RSGCore.Functions.SetPlayerBucket(src, 0)
end)

RegisterNetEvent('rsg-hotel:server:LeaveRoom', function(data)
    print(data.exithotel)
    local exithotel = data.exithotel
    local src = source
    RSGCore.Functions.SetPlayerBucket(src, 0)
    TriggerClientEvent('rsg-hotel:client:leaveroomteleport', src, exithotel)
end)
