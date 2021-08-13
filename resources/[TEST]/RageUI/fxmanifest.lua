---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

fx_version "adamant"


rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games { 'rdr3' };

client_scripts {
	"src/RageUI.lua",
	"src/Menu.lua",
	"src/MenuController.lua",
	"src/components/*.lua",
	"src/elements/*.lua",
	"src/items/*.lua",
	"src/panels/*.lua",
	"src/windows/*.lua",
	"example.lua"
}




