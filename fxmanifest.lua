fx_version 'cerulean'
game 'gta5'

author 'xDreamLand' -- https://forum.cfx.re/u/xDreamLand/summary
description 'Start scratching! Odds Are Meant To Be Beaten'
version '1.1.0'

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',

    'server/server.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',

    'client/client.lua',
    'client/nui.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/js/*.js',
    'html/css/*.css',
    'html/img/*.png',
    'html/img/*.jpg'
}

dependencies {
    'es_extended' -- https://github.com/esx-framework/es_extended/tree/v1-final
}