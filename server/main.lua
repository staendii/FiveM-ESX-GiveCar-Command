ESX = nil

CreateThread(function ()
	if exports["es_extended"]:getSharedObject() then
		ESX = exports["es_extended"]:getSharedObject()
		if ESX ~= nil then
			CreateThread(function ()
				Wait(2000)
				print("[ESX] Optimized for ESX Legacy")
			end)
		else
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			if ESX ~= nil then
				CreateThread(function ()
					Wait(2000)
					print("[ESX] Optimized for ESX V1")
				end)
			else
				CreateThread(function ()
					Wait(2000)
					print("[ESX] Failed to fetch Framework")
				end)
			end
		end
	else
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		if ESX ~= nil then
			CreateThread(function ()
				Wait(2000)
				print("[ESX] Optimized for ESX V1")
			end)
			else
				CreateThread(function ()
				Wait(2000)
				print("[ESX] Failed to fetch Framework")
			end)
		end
	end
end)

function CheckPermission(id)
    if id == 0 then return true end
    local xPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    for _, group in pairs(Config.AllowedGroups) do
        if group == xGroup then return true end
    end
    xPlayer.showNotification("You do not have rights to give Cars to Players")
    return false
end

RegisterCommand(Config.Command, function (source, args)
    local id = source
    local target = args[1]
    local vehicle = args[2]
    local plate = args[3]
    local hasPerms = CheckPermission(id)
    if hasPerms then
        if GetPlayerName(target) ~= nil and vehicle ~= nil and plate ~= nil then
            TriggerClientEvent(GetCurrentResourceName()..":spawn", target, vehicle, plate)
        elseif GetPlayerName(id) ~= nil then
            TriggerClientEvent("esx:showNotification", id, "Usage: /givecar id vehicleModel plate")
        else
            print("Usage: /givecar id vehicleModel plate")
        end
    end
end)

RegisterNetEvent(GetCurrentResourceName()..":getToken", function ()
    TriggerClientEvent(GetCurrentResourceName()..":getToken", source, Config.SecurityToken)
end)

RegisterNetEvent(GetCurrentResourceName()..":set", function (props, token)
    if token ~= Config.SecurityToken then Config.CustomBanFunction(source, "Invalid Event Token specified") return end
	local id = source
	local xPlayer = ESX.GetPlayerFromId(id)

    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type) VALUES (?, ?, ?, ?, ?)', {
        xPlayer.getIdentifier(), props.plate, json.encode(props), 1, "car"
    }, function(id)
        print("Added Vehicle with ID " ..id.. " to the Database")
    end)
end)