local cooldown = 0

RegisterNetEvent("esx_dreamscratching:isActiveCooldown", function()
	TriggerServerEvent("esx_dreamscratching:handler", cooldown > 0 and true or false, cooldown)
end)

RegisterNetEvent("esx_dreamscratching:setCooldown", function()
  cooldown = Config.ScratchCooldownInSeconds
	CreateThread(function()
		while (cooldown ~= 0) do
			Wait(1000)
			cooldown = cooldown - 1
		end
	end)
end)

RegisterNetEvent("esx_dreamscratching:startScratchingEmote", function()
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
end)

RegisterNetEvent("esx_dreamscratching:stopScratchingEmote", function()
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('esx_dreamscratching:deposit', data.key, data.price, data.amount, data.type)
end)