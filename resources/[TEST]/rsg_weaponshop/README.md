# rsg_weaponshop
RedM Weaponshop made for redem_roleplay and redemrp_inventory v2.0

# Installation
1. Put rsg_weaponshop to your resource folder.
2. Add "rsg_weaponshop" in your "server.cfg".
3. In redemrp_inventory/config.lua under Config.Items ensure the items are added :

-- start of config

Config.Items = {

-- revolvers

["WEAPON_REVOLVER_CATTLEMAN"] =
	{
		label = "Cattleman Revolver",
		description = "A popular and classic sidearm, the Buck Cattleman is a great all-around revolver",
		weight = 0.4,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN"),
		  imgsrc = "items/WEAPON_REVOLVER_CATTLEMAN.png",
		type = "item_weapon"
	},
	
["WEAPON_REVOLVER_LEMAT"] =
	{
		label = "LeMat Revolver",
		description = "I think its french, it does go bang!",
		weight = 0.9,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REVOLVER_LEMAT"),
		  imgsrc = "items/WEAPON_REVOLVER_LEMAT.png",
		type = "item_weapon"
	},
	
["WEAPON_REVOLVER_SCHOFIELD"] =
	{
		label = "Revolver Schofield",
		description = "Great for prison breaks",
		weight = 0.7,
		canBeDropped = true,
		requireLvl = 9,
		weaponHash = GetHashKey("WEAPON_REVOLVER_SCHOFIELD"),
		  imgsrc = "items/WEAPON_REVOLVER_SCHOFIELD.png",
		type = "item_weapon"
	},
	
["WEAPON_REVOLVER_DOUBLEACTION"] =
	{
		label = "Double Action Revolver",
		description = "Double the action, same weight.",
		weight = 0.8,
		canBeDropped = true,
		requireLvl = 17,
		weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION"),
		  imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
		type = "item_weapon"
	},
	
["WEAPON_REVOLVER_DOUBLEACTION_GAMBLER"] =
	{
		label = "High Roller Double-Action Revolver",
		description = "Dont forget to lock...",
		weight = 0.8,
		canBeDropped = true,
		requireLvl = 17,
		weaponHash = GetHashKey("WEAPON_REVOLVER_DOUBLEACTION_GAMBLER"),
		  imgsrc = "items/WEAPON_REVOLVER_DOUBLEACTION.png",
		type = "item_weapon"
	},

-- pistols

["WEAPON_PISTOL_VOLCANIC"] =
	{
		label = "Pistol Volcanic",
		description = "WARNING: Does not shoot lava",
		weight = 0.7,
		canBeDropped = true,
		requireLvl = 21,
		weaponHash = GetHashKey("WEAPON_PISTOL_VOLCANIC"),
		  imgsrc = "items/WEAPON_PISTOL_VOLCANIC.png",
		type = "item_weapon"
	},
	
["WEAPON_PISTOL_SEMIAUTO"] =
	{
		label = "Pistol Semi-Automatic",
		description = "Goes bang more then once",
		weight = 0.6,
		canBeDropped = true,
		requireLvl = 22,
		weaponHash = GetHashKey("WEAPON_PISTOL_SEMIAUTO"),
		  imgsrc = "items/WEAPON_PISTOL_SEMIAUTO.png",
		type = "item_weapon"
	},
	
["WEAPON_PISTOL_MAUSER"] =
	{
		label = "Pistol Mauser",
		description = "A must for any advanced warfare",
		weight = 0.6,
		canBeDropped = true,
		requireLvl = 34,
		weaponHash = GetHashKey("WEAPON_PISTOL_MAUSER"),
		  imgsrc = "items/WEAPON_PISTOL_MAUSER.png",
		type = "item_weapon"
	},

-- rifles

["WEAPON_REPEATER_EVANS"] =
	{
		label = "Repeater Evans",
		description = "A feat in weapon mechanics",
		weight = 2.5,
		canBeDropped = true,
		requireLvl = 1,
		weaponHash = GetHashKey("WEAPON_REPEATER_EVANS"),
		  imgsrc = "items/WEAPON_REPEATER_EVANS.png",
		type = "item_weapon"
	},
	
["WEAPON_RIFLE_BOLTACTION"] =
	{
		label = "Bolt Action Rifle",
		description = "Jams a lot, but works well when it doesnt.",
		weight = 2.3,
		canBeDropped = true,
		requireLvl = 7,
		weaponHash = GetHashKey("WEAPON_RIFLE_BOLTACTION"),
		  imgsrc = "items/WEAPON_RIFLE_BOLTACTION.png",
		type = "item_weapon"
	},
	
["WEAPON_RIFLE_VARMINT"] =
	{
		label = "Varmint Rifle",
		description = "Ride & Shoot!",
		weight = 1.5,
		canBeDropped = true,
		requireLvl = 8,
		weaponHash = GetHashKey("WEAPON_RIFLE_VARMINT"),
		  imgsrc = "items/WEAPON_RIFLE_VARMINT.png",
		type = "item_weapon"
	},
	
["WEAPON_SNIPERRIFLE_ROLLINGBLOCK"] =
	{
		label = "Rolling Block Rifle",
		description = "Line em up 500 metres away!",
		weight = 4.0,
		canBeDropped = true,
		requireLvl = 13,
		weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK"),
		  imgsrc = "items/WEAPON_SNIPERRIFLE_ROLLINGBLOCK.png",
		type = "item_weapon"
	},
	
["WEAPON_RIFLE_SPRINGFIELD"] =
	{
		label = "Springfield Rifle",
		description = "Military standard",
		weight = 2.0,
		canBeDropped = true,
		requireLvl = 38,
		weaponHash = GetHashKey("WEAPON_RIFLE_SPRINGFIELD"),
		  imgsrc = "items/WEAPON_RIFLE_SPRINGFIELD.png",
		type = "item_weapon"
	},
	
["WEAPON_SNIPERRIFLE_CARCANO"] =
	{
		label = "Carcano Rifle",
		description = "Range is the key!",
		weight = 4.0,
		canBeDropped = true,
		requireLvl = 50,
		weaponHash = GetHashKey("WEAPON_SNIPERRIFLE_CARCANO"),
		  imgsrc = "items/WEAPON_SNIPERRIFLE_CARCANO.png",
		type = "item_weapon"
	},
	
-- shotguns

["WEAPON_SHOTGUN_PUMP"] =
	{
		label = "Pump-Action Shotgun",
		description = "Pump-Action Shotgun",
		weight = 2.5,
		canBeDropped = true,
		requireLvl = 5,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_PUMP"),
		  imgsrc = "items/WEAPON_SHOTGUN_PUMP.png",
		type = "item_weapon"
	},
	
["WEAPON_SHOTGUN_REPEATING"] =
	{
		label = "Repeating Shotgun",
		description = "Repeating Shotgun",
		weight = 2.0,
		canBeDropped = true,
		requireLvl = 11,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_REPEATING"),
		  imgsrc = "items/WEAPON_SHOTGUN_REPEATING.png",
		type = "item_weapon"
	},

["WEAPON_SHOTGUN_SAWEDOFF"] =
	{
		label = "Sawed-Off Shotgun",
		description = "Sawed-Off Shotgun",
		weight = 1.2,
		canBeDropped = true,
		requireLvl = 19,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_SAWEDOFF"),
		  imgsrc = "items/WEAPON_SHOTGUN_SAWEDOFF.png",
		type = "item_weapon"
	},
	
["WEAPON_SHOTGUN_DOUBLEBARREL"] =
	{
		label = "Double-Barreled Shotgun",
		description = "Double-Barreled Shotgun",
		weight = 3.0,
		canBeDropped = true,
		requireLvl = 30,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_DOUBLEBARREL"),
		  imgsrc = "items/WEAPON_SHOTGUN_DOUBLEBARREL.png",
		type = "item_weapon"
	},
	
["WEAPON_SHOTGUN_SEMIAUTO"] =
	{
		label = "Semi-Auto Shotgun",
		description = "Semi-Auto Shotgun",
		weight = 2.2,
		canBeDropped = true,
		requireLvl = 42,
		weaponHash = GetHashKey("WEAPON_SHOTGUN_SEMIAUTO"),
		  imgsrc = "items/WEAPON_SHOTGUN_SEMIAUTO.png",
		type = "item_weapon"
	},

-- ammo 

["revolver_ammo"] = {
		label = "Revolver Ammo",
		description = "Revlover Ammo",
		weight = 0.02,
		canBeDropped = true,
		canBeUsed = true,
		requireLvl = 1,
		limit = 10,
		imgsrc = "items/revolver_ammo.png",
		type = "item_standard"
	},

["pistol_ammo"] = {
		label = "Pistol Ammo",
		description = "Pistol Ammo",
		weight = 0.02,
		canBeDropped = true,
		canBeUsed = true,
		requireLvl = 1,
		limit = 10,
		imgsrc = "items/pistol_ammo.png",
		type = "item_standard"
	},

["rifle_ammo"] = {
		label = "Rifle Ammo",
		description = "Rifle Ammo",
		weight = 0.02,
		canBeDropped = true,
		canBeUsed = true,
		requireLvl = 1,
		limit = 10,
		imgsrc = "items/rifle_ammo.png",
		type = "item_standard"
	},
	
["repeater_ammo"] = {
		label = "Repeater Ammo",
		description = "Repeater Ammo",
		weight = 0.02,
		canBeDropped = true,
		canBeUsed = true,
		requireLvl = 1,
		limit = 10,
		imgsrc = "items/repeater_ammo.png",
		type = "item_standard"
	},
	
["shotgun_ammo"] = {
		label = "Shotgun Ammo",
		description = "Shotgun Ammo",
		weight = 0.02,
		canBeDropped = true,
		canBeUsed = true,
		requireLvl = 1,
		limit = 10,
		imgsrc = "items/shotgun_ammo.png",
		type = "item_standard"
	},
	
}

-- end of config

# Required resources
- redem_roleplay : https://github.com/RedEM-RP/redem_roleplay/
- redemrp_inventory v2.0 : https://github.com/RedEM-RP/redemrp_inventory
- redemrp_notification : https://github.com/Ktos93/redemrp_notification

# Made by
- RexshackGaming : Discord : https://discord.gg/8gNCwDpQPb
- demo on youtube channel : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA