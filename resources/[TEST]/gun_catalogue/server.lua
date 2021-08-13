local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")


local weapons = {
	[1] = { ['weapon'] = 'WEAPON_REVOLVER_CATTLEMAN', ["PRICE"] = 50, ['label'] = 'Cattleman Revolver', ['AMMOlabel'] = 'revolver_ammo', ["AMMOPRICE"] = 10},
	[2] = { ['weapon'] = 'WEAPON_REVOLVER_DOUBLEACTION', ["PRICE"] = 195, ['label'] = 'Double-Action Revolver', ['AMMOlabel'] = 'revolver_ammo', ["AMMOPRICE"] = 10},
	[3] = { ['weapon'] = 'WEAPON_REVOLVER_SCHOFIELD', ["PRICE"] = 296, ['label'] = 'Schofield Revolver', ['AMMOlabel'] = 'revolver_ammo', ["AMMOPRICE"] = 10},
	[4] = { ['weapon'] = 'WEAPON_REVOLVER_LEMAT', ["PRICE"] = 317, ['label'] = 'LeMat Revolver', ['AMMOlabel'] = 'revolver_ammo', ["AMMOPRICE"] = 10},
	[5] = { ['weapon'] = 'WEAPON_PISTOL_VOLCANIC', ["PRICE"] = 270, ['label'] = 'Volcanic Pistol', ['AMMOlabel'] = 'pistol_ammo', ["AMMOPRICE"] = 10},
	[6] = { ['weapon'] = 'WEAPON_PISTOL_SEMIAUTO', ["PRICE"] = 895, ['label'] = 'Semi-Automatic Pistol', ['AMMOlabel'] = 'pistol_ammo', ["AMMOPRICE"] = 10},
	[7] = { ['weapon'] = 'WEAPON_PISTOL_MAUSER', ["PRICE"] = 1000, ['label'] = 'Mauser Pistol', ['AMMOlabel'] = 'pistol_ammo', ["AMMOPRICE"] = 10},
	[8] = { ['weapon'] = 'WEAPON_REPEATER_CARBINE', ["PRICE"] = 90, ['label'] = 'Carbine Repeater', ['AMMOlabel'] = 'repeater_ammo', ["AMMOPRICE"] = 10},
	[9] = { ['weapon'] = 'WEAPON_REPEATER_WINCHESTER', ["PRICE"] = 405, ['label'] = 'Lancaster Repeater', ['AMMOlabel'] = 'repeater_ammo', ["AMMOPRICE"] = 10},
	[10] = { ['weapon'] = 'WEAPON_REPEATER_EVANS', ["PRICE"] = 300, ['label'] = 'Carbine Repeater', ['AMMOlabel'] = 'repeater_ammo', ["AMMOPRICE"] = 10},
	[11] = { ['weapon'] = 'WEAPON_REPEATER_HENRY', ["PRICE"] = 300, ['label'] = 'Litchfield Repeater', ['AMMOlabel'] = 'repeater_ammo', ["AMMOPRICE"] = 10},
	[12] = { ['weapon'] = 'WEAPON_RIFLE_VARMINT', ["PRICE"] = 192, ['label'] = 'Varmint Rifle', ['AMMOlabel'] = 'rifle_ammo', ["AMMOPRICE"] = 10},
	[13] = { ['weapon'] = 'WEAPON_RIFLE_SPRINGFIELD', ["PRICE"] = 240, ['label'] = 'Springfield Rifle', ['AMMOlabel'] = 'rifle_ammo', ["AMMOPRICE"] = 20},
	[14] = { ['weapon'] = 'WEAPON_RIFLE_BOLTACTION', ["PRICE"] = 360, ['label'] = 'Bolt-Action Rifle', ['AMMOlabel'] = 'rifle_ammo', ["AMMOPRICE"] = 20},
	[15] = { ['weapon'] = 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK', ["PRICE"] = 685, ['label'] = 'Rolling-Block Rifle', ['AMMOlabel'] = 'rifle_ammo', ["AMMOPRICE"] = 30},
	[16] = { ['weapon'] = 'WEAPON_SNIPERRIFLE_CARCANO', ["PRICE"] = 760, ['label'] = 'Carcano Rifle', ['AMMOlabel'] = 'rifle_ammo', ["AMMOPRICE"] = 20},
	[17] = { ['weapon'] = 'WEAPON_SHOTGUN_SAWEDOFF', ["PRICE"] = 170, ['label'] = 'Sawed-Off Shotgun', ['AMMOlabel'] = 'shotgun_ammo', ["AMMOPRICE"] = 10},
	[18] = { ['weapon'] = 'WEAPON_SHOTGUN_DOUBLEBARREL', ["PRICE"] = 285, ['label'] = 'Double-Barrel Shotgun', ['AMMOlabel'] = 'shotgun_ammo', ["AMMOPRICE"] = 10},
	[19] = { ['weapon'] = 'WEAPON_SHOTGUN_PUMP', ["PRICE"] = 200, ['label'] = 'Pump-Action Shotgun', ['AMMOlabel'] = 'shotgun_ammo', ["AMMOPRICE"] = 10},
	[20] = { ['weapon'] = 'WEAPON_SHOTGUN_REPEATING', ["PRICE"] = 724, ['label'] = 'Repeating Shotgun', ['AMMOlabel'] = 'shotgun_ammo', ["AMMOPRICE"] = 10},
	[21] = { ['weapon'] = 'WEAPON_SHOTGUN_SEMIAUTO', ["PRICE"] = 900, ['label'] = 'Semi-Automatic Shotgun', ['AMMOlabel'] = 'shotgun_ammo', ["AMMOPRICE"] = 10},
	[22] = { ['weapon'] = 'WEAPON_BOW', ["PRICE"] = 124, ['label'] = 'Hunting Bow', ['AMMOlabel'] = 'arrows', ["AMMOPRICE"] = 5},
	[23] = { ['weapon'] = 'WEAPON_LASSO', ["PRICE"] = 20, ['label'] = 'Lasso', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
	[24] = { ['weapon'] = 'WEAPON_MELEE_HATCHET', ["PRICE"] = 15, ['label'] = 'Hatchet', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
	[25] = { ['weapon'] = 'WEAPON_MELEE_KNIFE', ["PRICE"] = 10, ['label'] = 'Hunting Knife', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
	[26] = { ['weapon'] = 'WEAPON_THROWN_THROWING_KNIVES', ["PRICE"] = 10, ['label'] = 'Throwing Knives', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
	[27] = { ['weapon'] = 'WEAPON_MELEE_MACHETE', ["PRICE"] = 20, ['label'] = 'Machete', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
	[28] = { ['weapon'] = 'WEAPON_THROWN_TOMAHAWK', ["PRICE"] = 36, ['label'] = 'Tomahawk', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
	[29] = { ['weapon'] = 'WEAPON_THROWN_DYNAMITE', ["PRICE"] = 50, ['label'] = 'Dynamite Sticks', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
	[30] = { ['weapon'] = 'WEAPON_THROWN_MOLOTOV', ["PRICE"] = 30, ['label'] = 'Fire Bottles', ['AMMOlabel'] = '', ["AMMOPRICE"] = 0},
}

local code = math.random(111111,9999999)

RegisterNetEvent("gunCatalogue:getCode")
AddEventHandler("gunCatalogue:getCode", function()
	local _source = source
	TriggerClientEvent('gunCatalogue:SendCode', _source, code)
end)

function doesweaponexist(weapon)
	for i = 1,#weapons do
		if weapons[i]['weapon'] == weapon then
			return true
		end
	end
	return false
end

function weapon2(weapon)
	for i = 1,#weapons do
		if weapons[i]['weapon'] == weapon then
			return weapons[i]
		end
	end
	return false
end

local Inventory = Character:getInventory()


RegisterNetEvent("gunCatalogue:Purchase")
AddEventHandler("gunCatalogue:Purchase", function(data,code1)
	local _source = source
	if code == code1 then
		TriggerEvent('redem:getPlayerFromId', _source, function(user) 
			local cash = user.getMoney()
			if tonumber(data.isammo) ~= 1 then
				if doesweaponexist(data.weapon) then
					local weapon2 = weapon2(data.weapon)
					if weapon2 then
						if cash >= weapon2['PRICE'] then
							TriggerClientEvent('gunCatalogue:Give',_source, data, code)
							local itemData = verificationData[itemId]
							ItemData.AddItem(1)
							user.removeMoney(weapon2['PRICE'])
						end
					end
				end
			else
				if doesweaponexist(data.weapon) then
					local weapon2 = weapon2(data.weapon)
					if weapon2 then
						if cash >= weapon2['AMMOPRICE'] then
							TriggerClientEvent('gunCatalogue:Give',_source, data, code)
							local itemData = verificationData[itemId]
							ItemData2.AddItem(1)
							user.removeMoney(weapon2['AMMOPRICE'])
						end
					end
				end
			end
		end)
	end
end)

-------- Revolver (WEAPON_REVOLVER_CATTLEMAN)
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REVOLVER_CATTLEMAN")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Revolver (WEAPON_REVOLVER_DOUBLEACTION)
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REVOLVER_DOUBLEACTION")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Revolver (WEAPON_REVOLVER_SCHOFIELD)
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REVOLVER_SCHOFIELD")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Revolver (WEAPON_REVOLVER_LEMAT)
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REVOLVER_LEMAT")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Pistol (WEAPON_PISTOL_VOLCANIC)
RegisterServerEvent("RegisterUsableItem:pistol_ammo")
AddEventHandler("RegisterUsableItem:pistol_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_PISTOL_VOLCANIC")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Pistol (WEAPON_PISTOL_SEMIAUTO)
RegisterServerEvent("RegisterUsableItem:pistol_ammo")
AddEventHandler("RegisterUsableItem:pistol_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_PISTOL_SEMIAUTO")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Pistol (WEAPON_PISTOL_MAUSER)
RegisterServerEvent("RegisterUsableItem:pistol_ammo")
AddEventHandler("RegisterUsableItem:pistol_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_PISTOL_MAUSER")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Repeater (WEAPON_REPEATER_CARBINE)
RegisterServerEvent("RegisterUsableItem:repeater_ammo")
AddEventHandler("RegisterUsableItem:repeater_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REPEATER_CARBINE")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Repeater (WEAPON_REPEATER_WINCHESTER)
RegisterServerEvent("RegisterUsableItem:repeater_ammo")
AddEventHandler("RegisterUsableItem:repeater_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REPEATER_WINCHESTER")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Repeater (WEAPON_REPEATER_EVANS)
RegisterServerEvent("RegisterUsableItem:repeater_ammo")
AddEventHandler("RegisterUsableItem:repeater_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REPEATER_EVANS")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Repeater (WEAPON_REPEATER_HENRY)
RegisterServerEvent("RegisterUsableItem:repeater_ammo")
AddEventHandler("RegisterUsableItem:repeater_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_REPEATER_HENRY")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Rifle (WEAPON_RIFLE_VARMINT)
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_RIFLE_VARMINT")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Rifle (WEAPON_RIFLE_SPRINGFIELD)
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_RIFLE_SPRINGFIELD")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Rifle (WEAPON_RIFLE_BOLTACTION)
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_RIFLE_BOLTACTION")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Sniper Rifle (WEAPON_SNIPERRIFLE_ROLLINGBLOCK)
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_SNIPERRIFLE_ROLLINGBLOCK")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Sniper Rifle (WEAPON_SNIPERRIFLE_CARCANO)
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_SNIPERRIFLE_CARCANO")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Shotgun (WEAPON_SHOTGUN_SAWEDOFF)
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_SHOTGUN_SAWEDOFF")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Shotgun (WEAPON_SHOTGUN_DOUBLEBARREL)
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_SHOTGUN_DOUBLEBARREL")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Shotgun (WEAPON_SHOTGUN_PUMP)
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_SHOTGUN_PUMP")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Shotgun (WEAPON_SHOTGUN_REPEATING)
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_SHOTGUN_REPEATING")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Shotgun (WEAPON_SHOTGUN_SEMIAUTO)
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_SHOTGUN_SEMIAUTO")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
-------- Arrows
RegisterServerEvent("RegisterUsableItem:arrows")
AddEventHandler("RegisterUsableItem:arrows", function(source)
	TriggerClientEvent('gunCatalogue:giveammo', source, "WEAPON_BOW")
	local itemData = verificationData[itemId]
	ItemData.RemoveItem(1)
end)
