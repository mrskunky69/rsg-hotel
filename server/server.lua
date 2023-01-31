local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-hotel:server:EnterRoom', function(data)
    print(data.enterhotel)
    local enterhotel = data.enterhotel
    local src = source
    local bucket = math.random(1,9999999999)
    SetPlayerRoutingBucket(src, tonumber(bucket))
	local currentbucket = GetPlayerRoutingBucket(src)
	print(currentbucket)
    TriggerClientEvent('rsg-hotel:client:roomteleport', src, enterhotel)
end)

RegisterNetEvent('rsg-hotel:server:LeaveRoom', function(data)
    print(data.exithotel)
    local exithotel = data.exithotel
    local src = source
    SetPlayerRoutingBucket(src, 0)
	local currentbucket = GetPlayerRoutingBucket(src)
	print(currentbucket)
    TriggerClientEvent('rsg-hotel:client:leaveroomteleport', src, exithotel)
end)
