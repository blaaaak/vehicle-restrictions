fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'Vehicle Restrictions'
description 'Simple vehicle restrictions for FiveM'
version '1.0.0'

shared_script { '@ox_lib/init.lua' }

client_script { 'client/client.lua' }

server_script { 'server/server.lua' }

files { 'config/config.lua', 'config/vehicles.lua' }
