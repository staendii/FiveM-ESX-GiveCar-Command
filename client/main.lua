ESX = nil
TOKEN = nil

CreateThread(function ()
	if exports["es_extended"]:getSharedObject() then
		ESX = exports["es_extended"]:getSharedObject()
		if ESX ~= nil then
			CreateThread(function ()
				Wait(2000)
				print("[ESX] Optimized for ESX Legacy")
				Wait(100)
				TerminateThisThread()
			end)
		else
			while ESX == nil do
				TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
				Wait(0)
			end
			if ESX ~= nil then
			  CreateThread(function ()
				  Wait(2000)
				  print("[ESX] Optimized for ESX V1")
				  Wait(100)
				  TerminateThisThread()
			  end)
			else
				CreateThread(function ()
					Wait(2000)
					print("[ESX] Failed to fetch Framework")
					Wait(100)
					TerminateThisThread()
				end)
			end
		end
	else
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Wait(0)
		end
		if ESX ~= nil then
			CreateThread(function ()
				Wait(2000)
				print("[ESX] Optimized for ESX V1")
				Wait(100)
				TerminateThisThread()
			end)
		else
			CreateThread(function ()
				Wait(2000)
				print("[ESX] Failed to fetch Framework")
				Wait(100)
				TerminateThisThread()
			end)
		end
	end
end)

CreateThread(function ()
    Wait(1000)
    TriggerServerEvent(GetCurrentResourceName()..":getToken")
end)

RegisterNetEvent(GetCurrentResourceName()..":getToken", function (tkn)
    TOKEN = tkn
end)

RegisterNetEvent(GetCurrentResourceName()..":spawn", function (model, plate)
	local playerPed = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)
	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle)
		if DoesEntityExist(vehicle) then
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = plate
			TriggerServerEvent(GetCurrentResourceName()..":set", vehicleProps, TOKEN)
			ESX.Game.DeleteVehicle(vehicle)
			ESX.ShowNotification("You received a Vehicle with the Model " ..model)		
		end		
	end)
end)