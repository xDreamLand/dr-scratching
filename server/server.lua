ESX = nil
local players = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local totalSumChance = 0
for k,v in pairs(Config.Prices) do
    totalSumChance = totalSumChance + v[1]
end

-- triggers client sided check for an active cooldown
ESX.RegisterUsableItem('scratch_ticket', function(source)
    TriggerClientEvent("esx_dreamscratching:isActiveCooldown", source)
end)

RegisterNetEvent("esx_dreamscratching:handler")
AddEventHandler("esx_dreamscratching:handler", function(returncooldown, cooldown)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- checking cooldown
    if returncooldown then
        if Config.ShowCooldownNotifications then
            xPlayer.showNotification(_U('active_cooldown', cooldown), false, false)
        end
        if Config.DebugMode then
            print(('DEBUG: Active cooldown. Cooldown: %s'):format(cooldown))
        end
        return
    end
    
    -- removing ticket
    xPlayer.removeInventoryItem('scratch_ticket', 1)
    if Config.ShowUsedTicketNotification then
	    xPlayer.showNotification(_U('used_scratchticket'))
    end

    -- trigger client sided emote
    TriggerClientEvent("esx_dreamscratching:startScratchingEmote", _source)
	local tempsrc = tonumber(_source)
    -- price money
     local randomNumber = math.random(1, totalSumChance)
     local add = 0
     for item,values in pairs(Config.Prices) do
        local chance = values[1]
        local price = values[2]

        if randomNumber > add and randomNumber <= add + chance then
            TriggerClientEvent("esx_dreamscratching:nuiOpenCard", _source, price) -- open the scratch ticket with the random price
		players[tempsrc] = price
            return price
        end
        add = add + chance
    end
end)

-- add winning money to player
RegisterNetEvent("esx_dreamscratching:deposit")
AddEventHandler("esx_dreamscratching:deposit", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    amount = tonumber(amount)

    if amount == nil or amount < 0 then
        if Config.DebugMode then
            print(('DEBUG: Invalid Quantity. Provided amount: %s'):format(amount))
        end
        return
    else 
	local tempsrc = tonumber(_source)
	if players[tempsrc] == amount then
		xPlayer.addMoney(amount) -- add the price money to the player
		TriggerClientEvent("esx_dreamscratching:setCooldown", _source) -- start scratch cooldown
		if Config.ShowResultTicketNotification then
		    for item,values in pairs(Config.Prices) do
			local price = values[2]
			if price == amount then
			    TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('lottery_name'), _U('lottery_subject'), values[3] , 'CHAR_BANK_BOL', 9)
			    return
			end
		    end
		end
		if Config.DebugMode then
		    print(('DEBUG: Succesfully added %s to %s'):format(amount, xPlayer.identifier))
		end
		return
	end
	return
    end
end)
