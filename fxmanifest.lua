fx_version 'cerulean'
game 'gta5'
author 'Reality Sucks RP / APCode'
description 'Server-authoritative QBCore inventory with the RealitySucksRP zombie UI.'
version '3.0.3-cash-death-guard'

dependencies {
'qb-core',
'qb-weapons',
'oxmysql',
'qb-target'
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
'server/sessions.lua',
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

-- Vendored front-end libraries. These used to be eleven CDN requests, which
-- meant a CDN outage or a restricted client network broke the inventory UI.
'html/vendor/*.js',
'html/vendor/*.css',
'html/vendor/fonts/*.woff2',
'html/vendor/fontawesome/css/*.css',
'html/vendor/fontawesome/webfonts/*.woff2',

-- Zombie UI artwork / top-level UI images.
'html/*.png',

-- Item / inventory images. Kept explicit so FiveM does not pack non-image junk.
'html/images/*.png'

}

exports {
'HasItem'
}
