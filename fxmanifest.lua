fx_version 'cerulean'
game 'gta5'

description 'Cigarettes as stress relief'
author 'MinoSuve'
version '1.0.0'

server_scripts {
    "server/*.lua",
}

client_scripts {
	"client/*.lua",
}

shared_script {
	'config.lua',
	 '@ox_lib/init.lua'
}
lua54 'yes'
