-- VERSION [1.1 RELEASED]

Config = {}

Config.Locale = 'en'

 -- You don't HAVE to sum to sum the chances of all the prices to a 100. Total will be decided based on the
 -- <chance of one price>/<total of all prices>. e.g. Common has a chance of '50' and the total of all chances is 100 -> 50/100 (50%)
 -- chance of packing common. You may add as many prices as you want. Follow the preset logic.
 Config.Prices = {
    Nothing = {
        50, -- chance
        0, -- price
        '~c~Sadly, you didn\'t win anything, you win some, you lose some.~s~'
        },
    Common = {
        25, -- chance
        100, -- price
        '~g~You won $100!~s~ Not too bad!'
        },
    Rare = {
        15, -- chance
        250, -- price
        '~g~You won!~s~ Buy yourself something nice worth ~g~$250~s~!'
        },
    Epic = {
        9, -- chance
        750, -- price
        '~g~You won big time! ~g~+ $750~s~!'
        },
    Legendary = {
        1, -- chance
        1000, -- price
        '~r~L~b~E~g~G~y~E~p~N~q~D~o~A~r~R~b~Y~s~! You won ~g~$1000~s~!'
        }
}

Config.ScratchCooldownInSeconds     = 10    -- Cooldown in SECONDS, when will client be able to scratch another ticket?

Config.ShowCooldownNotifications    = true  -- Show a notification to client with the remaining cooldown timer
Config.ShowUsedTicketNotification   = true  -- Show a notification to client whenever a ticket is used
Config.ShowResultTicketNotification = true  -- Show a notification with message of price ticket. See Config.Prices.n[3]

Config.ScratchAmount                = 80    -- Percentage of the ticket that needs to be scrapped away for the price to be 'seen'

Config.DebugMode                    = false -- Something not working? Locate the issue with the debug mode. default: false