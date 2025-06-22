
fx_version "cerulean"
game { "gta5" }
lua54 'yes'

description 'grandmother script by a2'
version '1.0.0'

shared_scripts {
    "shared/config.lua",
     "@ox_lib/init.lua"
}

client_scripts {
    "client/cl_main.lua",
}

server_scripts {
    "server/sv_main.lua",
}

