fx_version "adamant"
games { "rdr3" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
ui_page 'h.html'
--ui_page 'd.html'
client_scripts {
    'client.lua'
}

files {
    'h.html',
	'd.html',
    'circle-progress.js'
}

export "startUI"