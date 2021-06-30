ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local cooldown = 0

-- check for active cooldown, return cooldown state to server
RegisterNetEvent("esx_dreamscratching:isActiveCooldown")
AddEventHandler("esx_dreamscratching:isActiveCooldown", function()
	local returnCooldown

    if cooldown > 0 then
		returnCooldown = true
	else
		returnCooldown = false
	end

	TriggerServerEvent("esx_dreamscratching:handler", returnCooldown, cooldown)
end)


-- cooldown handler
RegisterNetEvent("esx_dreamscratching:setCooldown")
AddEventHandler("esx_dreamscratching:setCooldown", function()
    cooldown = Config.ScratchCooldownInSeconds

	Citizen.CreateThread(function()
		while (cooldown ~= 0) do 
			Wait(1000) 
			cooldown = cooldown - 1
		end
	end)
end)

-- start emote
RegisterNetEvent("esx_dreamscratching:startScratchingEmote")
AddEventHandler("esx_dreamscratching:startScratchingEmote", function()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	end)

end)

-- force stop emote
RegisterNetEvent("esx_dreamscratching:stopScratchingEmote")
AddEventHandler("esx_dreamscratching:stopScratchingEmote", function()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
		ClearPedTasksImmediately(playerPed)
	end)

end)

-- NUI callback: deposit money
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('esx_dreamscratching:deposit', data.key, data.price, data.amount, data.type)
end)