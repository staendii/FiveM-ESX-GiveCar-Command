fx_version "cerulean"
game "gta5"

author "@staendi (Nico)"
version "1.0"

client_scripts {
    "client/*.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    "config/sv_config.lua",
    "server/*.lua"
}