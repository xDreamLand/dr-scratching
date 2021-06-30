ESX = nil
local players = {}
local resourceName = GetCurrentResourceName()
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local totalSumChance = 0
for _,priceInfo in pairs(Config.Prices) do
    totalSumChance = totalSumChance + priceInfo['chance']
end

-- triggers client sided check for an active cooldown
ESX.RegisterUsableItem('scratch_ticket', function(source)
    TriggerClientEvent("esx_dreamscratching:isActiveCooldown", source)
end)

RegisterNetEvent("esx_dreamscratching:handler")
AddEventHandler("esx_dreamscratching:handler", function(returncooldown, cooldown)
    local _source       = source
    local xPlayer       = ESX.GetPlayerFromId(_source)
    local count         = xPlayer.getInventoryItem('scratch_ticket').count
    local tempsrc       = tonumber(_source)
    local randomNumber  = math.random(1, totalSumChance)
    local add           = 0

    -- Cooldown handler
    if returncooldown then
        if Config.ShowCooldownNotifications then
            xPlayer.showNotification(_U('active_cooldown', cooldown), false, false)
        end
        if Config.DebugMode then
            print(('[^6%s^7] [^3DEBUG^7] - Active cooldown. Cooldown: %s'):format(resourceName, cooldown))
        end
        return
    end

    -- Double check if ticket did not randomy dissapear
    if count >= 1 then
        xPlayer.removeInventoryItem('scratch_ticket', 1)
        if Config.ShowUsedTicketNotification then
            xPlayer.showNotification(_U('used_scratchticket'))
        end
    else
        print(('[^6%s^7] [^1IMPORTANT^7] - %s (%s) somehow used a scratching ticket without having one. Cancelled'):format(resourceName, GetPlayerName(_source), GetPlayerIdentifier(_source, 0)))
        return
    end

    -- Start emote
    TriggerClientEvent("esx_dreamscratching:startScratchingEmote", _source)

    -- Trigger The Opening NUI
    for key,priceInfo in pairs(Config.Prices) do
        local chance = priceInfo['chance']

        if randomNumber > add and randomNumber <= add + chance then
            local price_is_item     = priceInfo['price']['item']['price_is_item']
            local amount            = priceInfo['price']['item']['item_amount']
            local price_type, price = nil

            if not price_is_item then
                price           = priceInfo['price']['price_money']
                price_type      = 'money'
             else 
                price           = priceInfo['price']['item']['item_label']
                price_type      = 'item'
            end

            players[tempsrc] = tostring(price)
            TriggerClientEvent("esx_dreamscratching:nuiOpenCard", _source, key, price, amount, price_type)

            return price
        end
        add = add + chance
    end
end)

RegisterNetEvent("esx_dreamscratching:deposit")
AddEventHandler("esx_dreamscratching:deposit", function(key, price, amount, type)
    local _source       = source
    local xPlayer       = ESX.GetPlayerFromId(_source)
    local tempsrc       = tonumber(_source)
    local giveItem      = false
    local giveMoney     = false
    local passed        = false

    -- check if server variable matches value passed to it
    if players[tempsrc] ~= tostring(price) then
        print(('[^6%s^7] [^1IMPORTANT^7] - %s (%s) somehow managed to trigger the deposit event with a non-matching price matching to his/her name'):format(resourceName, GetPlayerName(_source), GetPlayerIdentifier(_source, 0)))
        return
    end

    -- check -if the type is money- if the provided price a valid number
    if type == 'money' then
        local winningAmount = tonumber(price)
        if winningAmount == nil or winningAmount < 0 then
            if Config.DebugMode then
                print(('[^6%s^7] [^3DEBUG^7] - Invalid Quantity. Provided price: %s'):format(resourceName, winningAmount))
            end
            return
        end

        giveMoney = true
    else
        giveItem = true -- will be given in loop below (performance)
    end

    for priceKey,priceInfo in pairs(Config.Prices) do
        if priceKey == key then
             local priceAmount = priceInfo["price"]["item"]["item_amount"]

            if Config.ShowResultTicketNotification then
                TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('lottery_name'), _U('lottery_subject'), priceInfo['message'] , 'CHAR_BANK_BOL', 9)
            end

            if type == 'item' and giveItem == true then
                if tonumber(amount) == priceAmount then
                    xPlayer.addInventoryItem(priceInfo["price"]["item"]["item_name"], priceAmount)  -- add item to player
                else
                    print(('[^6%s^7] [^1IMPORTANT^7] - %s (%s) somehow managed to trigger the deposit event with a non-matching amount'):format(resourceName, GetPlayerName(_source), GetPlayerIdentifier(_source, 0)))
                    return
                end
            elseif type == 'money' and giveMoney == true then
                if tonumber(amount) == priceAmount then
                    xPlayer.addMoney(price)
                else
                    print(('[^6%s^7] [^1IMPORTANT^7] - %s (%s) somehow managed to trigger the deposit event with a non-matching amount'):format(resourceName, GetPlayerName(_source), GetPlayerIdentifier(_source, 0)))
                    return
                end
            end
        end
    end

    if Config.DebugMode then
        print(('[^6%s^7] [^3DEBUG^7] - Succesfully added %s to %s'):format(resourceName, price, xPlayer.identifier))
    end

    TriggerClientEvent("esx_dreamscratching:setCooldown", _source) -- start scratch cooldown
    return
end)