fx_version "cerulean"
game "gta5"
lua54 "yes"


client_script "client/*.lua"
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "server/*.lua"
}
shared_scripts {
    "config.lua",
    '@ox_lib/init.lua'
}

files {
    'locales/*.json'
}

dependencies {
    "ox_lib"
}
