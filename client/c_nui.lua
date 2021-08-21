local inMenu = false

RegisterNetEvent("dr-scratching:nuiOpenCard")
AddEventHandler("dr-scratching:nuiOpenCard", function(key, price, amount, price_type)
  if inMenu then return end
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = 'openScratch',
    key = key,
    price = price,
    amount = amount,
    price_type = price_type,
    win_message = _U('stract_won'),
    lose_message = _U('scratch_lost'),
    currency = _U('currency'),
    scratchAmount = Config.ScratchAmount,
    resourceName = GetCurrentResourceName(),
    debug = Config.DebugMode
  })
  inMenu = true
end)

RegisterNUICallback('nuiCloseCard', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeScratch'})
  TriggerEvent("dr-scratching:stopScratchingEmote")
  inMenu = false
end)