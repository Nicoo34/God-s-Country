-- created by RexshackGaming : Discord : https://discord.gg/8gNCwDpQPb
-- youtube channel : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_script {
	'server/server.lua',
	'@mysql-async/lib/MySQL.lua',
}

client_script {
	'client/client.lua',
	'client/warmenu.lua',
	'client/blips.lua',
}