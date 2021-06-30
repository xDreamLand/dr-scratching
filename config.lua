-- VERSION [1.2 RELEASED]

Config = {}

Config.Locale = 'en'

 -- You don't HAVE to sum to sum the chances of all the prices to a 100. Total will be decided based on the
 -- <chance of one price> divided by <chance total of all prices>. e.g. Common has a chance of '50' and the total of
 -- all chances is 100 -> 50/100 (50%) chance of packing common. You may add as many prices as you want. Follow the preset logic.

 -- Price can be an item or money, if you set 'price_is_item' to true, it'll ignore the price_money, if you set 'price_is_item' to false,
 -- it'll ignore the item_name & item_label.
 Config.Prices = {
    Nothing = {
        chance  = 50,
        message = '~c~Sadly, you didn\'t win anything, you win some, you lose some.~s~',
        price = {
            price_money = 0,
            --- MONEY OR ITEM? ---
            item = {
                price_is_item   = false,
                item_name       = '',
                item_label      = '',
                item_amount     = 1
            }
        }
    },
    Common = {
        chance  = 20,
        message = '~g~You won a new scratch ticket!~s~ Maybe this time you will win big?',
        price = {
            price_money = 0,
            --- MONEY OR ITEM? ---
            item = {
                price_is_item   = true,
                item_name       = 'water',
                item_label      = 'Water',
                item_amount     = 1
            }
        }
    },
    Rare = {
        chance  = 15,
        message = '~g~You won!~s~ Buy yourself something nice worth ~g~$250~s~!',
        price = {
            price_money = 250,
            --- MONEY OR ITEM? ---
            item = {
                price_is_item   = false,
                item_name       = '',
                item_label      = '',
                item_amount     = 1
            }
        }
    },
    Epic = {
        chance  = 9,
        message = '~g~You won big time! ~g~+ $750~s~!',
        price = {
           price_money          = 750,
           --- MONEY OR ITEM? ---
           item = {
               price_is_item    = false,
               item_name        = '',
               item_label       = '',
               item_amount     = 1
           }
        }
    },
    Legendary = {
        chance  =  1,
        message = '~r~L~b~E~g~G~y~E~p~N~q~D~o~A~r~R~b~Y~s~! You won ~g~$1000~s~!',
        price = {
            price_money         = 1000,
            --- MONEY OR ITEM? ---
            item = {
                price_is_item   = false,
                item_name       = '',
                item_label      = '',
                item_amount     = 1
            }
        }
    }
}

Config.ScratchCooldownInSeconds     = 10    -- Cooldown in SECONDS, when will client be able to scratch another ticket?

Config.ShowCooldownNotifications    = true  -- Show a notification to client with the remaining cooldown timer
Config.ShowUsedTicketNotification   = true  -- Show a notification to client whenever a ticket is used
Config.ShowResultTicketNotification = true  -- Show a notification with message of price ticket. See Config.Prices.n[3]

Config.ScratchAmount                = 80    -- Percentage of the ticket that needs to be scrapped away for the price to be 'seen'

Config.DebugMode                    = false -- Something not working? Locate the issue with the debug mode. default: false
