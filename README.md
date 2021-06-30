
![Banner](https://i.iodine.gg/cjge3.png)
<p align="center">
  <a href="https://discord.gg/8UXzMwBEdX">
    <img alt="Dicord" height="20" src="https://img.shields.io/discord/855953501774807060?label=Discord&logo=Discord&logoColor=white">
  </a>
  <a href="https://forum.cfx.re/t/free-scratch-card-esx/3461621">
    <img alt="Website" src="https://img.shields.io/website?down_color=red&down_message=Offline&label=FiveM%20Forum&up_message=Check%20it&url=https%3A%2F%2Fforum.cfx.re%2Ft%2Ffree-scratch-card-esx%2F3461621">
  </a>
  <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/xDreamLand/esx_dreamscratching">
  <img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/xDreamLand/esx_dreamscratching">
</p>

## Features
* ESX, if you got a bit of resource experience you *could* probably change it to a different framework really easily though!
* NUI included. Not just a boring 'use item' and get money
* Language configuration (includes currency, notifications, ...)
* Really customizable! (Change e.g. win/lose changes, price money, notifications, scratch amount, ...)
* Included `.sql` file. Easily addable to existing items (so you could add it to your shop)
* Built-in debug mode
* Built-in cooldown system, gamble responsible kids :relieved:
* Lightweight resource!

## Config
* Language
* Cooldown timer (can be set to 0, so disabled)
* Show notification on active cooldown?
* Show notification when using a ticket?
* Show notification of your winnings?
* Required scratching surface which has to be removed in order for price to be detected
* Debug mode
* Win chances, prices & messages of prices

## Installation

### es_extended is required (for other frameworks, remove dependencies {  }   in fxmanifest.lua)
1. Download the latest version here
2. Extract into your `resources/` folder (choose wherever you like it to be)
3. run the `.sql` file, this will add `scratch_ticket` as an item
4. All set, check the console for errors, if none try it out in-game: `/giveitem [your_playerid] scratch_ticket 1` 

## Using esx_inventoryhud?
* Go to `esx_inventoryhud/config.lua` and add `scratch_ticket` to the `Config.CloseUiItems`
