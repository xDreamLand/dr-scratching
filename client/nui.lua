local inMenu = false

RegisterNetEvent("esx_dreamscratching:nuiOpenCard")
AddEventHandler("esx_dreamscratching:nuiOpenCard", function(key, price, amount, price_type)
    if inMenu == true then
        return
    else
        SetNuiFocus(true, true)
        SendNUIMessage({
            type            = 'openScratch',
            key             = key,
            price           = price,
            amount          = amount,
            price_type      = price_type,
            win_message     = _U('stract_won'),
            lose_message    = _U('scratch_lost'),
            currency        = _U('currency'),
            scratchAmount   = Config.ScratchAmount,
            resourceName    = GetCurrentResourceName(),
            debug           = Config.DebugMode
        })
        inMenu = true
    end
end)

RegisterNUICallback('nuiCloseCard', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
        type                = 'closeScratch'
    })
    TriggerEvent("esx_dreamscratching:stopScratchingEmote")
    inMenu = false
end)