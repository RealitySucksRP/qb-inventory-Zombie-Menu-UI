fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Reality Sucks RP / APCode'
description 'Open-source QB Inventory Rework by APCode with Reality Sucks RP Zombie UI preserved.'
version '2.6.3-rs-zombie-cash-authority'

dependencies {
'qb-core',
'qb-weapons',
'oxmysql'
}

shared_scripts {
'@qb-core/shared/locale.lua',
'locales/en.lua',
'locales/*.lua',
'config/config.lua',
'config/vehicles.lua'
}

client_scripts {
'client/main.lua',
'client/drops.lua',
'client/vehicles.lua'
}

server_scripts {
'@oxmysql/lib/MySQL.lua',
'server/main.lua',
'server/functions.lua',
'server/cash_sync.lua',
'server/commands.lua',
'server/compat.lua'
}

ui_page 'html/index.html'

files {
'html/index.html',
'html/main.css',
'html/app.js',


-- Zombie UI artwork / top-level UI images.
'html/*.png',

-- Item / inventory images. Keep these explicit so FiveM does not pack non-image junk from html/images/.
'html/images/*.png',
'html/images/*.PNG',
'html/images/*.jpg',
'html/images/*.jpeg',
'html/images/*.webp',
'html/images/*.gif',
'html/images/*.svg',

-- Zombie dark theme art.
'html/dark/*.png',
'html/dark/*.svg'

}

exports {
'HasItem'
}
