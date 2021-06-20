local inMenu = false

RegisterNetEvent("esx_dreamscratching:nuiOpenCard")
AddEventHandler("esx_dreamscratching:nuiOpenCard", function(price)
    if inMenu == true then
        return
    else
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'openScratch',
            price = price,
            win_message = _U('stract_won'),
            lose_message = _U('scratch_lost'),
            currency = _U('currency'),
            scratchAmount = Config.ScratchAmount,
            resourceName = GetCurrentResourceName(),
            debug = Config.DebugMode
        })
        inMenu = true
    end
end)

RegisterNUICallback('nuiCloseCard', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
        type = 'closeScratch'
    })
    TriggerEvent("esx_dreamscratching:stopScratchingEmote")
    inMenu = false
end)