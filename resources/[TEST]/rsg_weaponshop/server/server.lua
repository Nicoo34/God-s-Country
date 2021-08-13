-- created by RexshackGaming : Discord : https://discord.gg/8gNCwDpQPb
-- youtube channel : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA


-- buy weapon
RegisterServerEvent('rsg_weaponshop:buyweapon')
AddEventHandler("rsg_weaponshop:buyweapon", function(price, item1, lvl)
    TriggerEvent("redemrp:getPlayerFromId", source, function(user)
		local _source = source
		local level = user.getLevel()
        if user.getMoney() >= price then
            if level >= lvl then
                user.removeMoney(price)
				local ItemData = data.getItem(_source, item1)
				print(ItemData.ItemAmount)
				ItemData.AddItem(1)
				TriggerClientEvent('rsg_weaponshop:equipitem1', _source, item1)
				TriggerClientEvent('FRP:NOTIFY:Simple', 'You purchased a weapon!', 3)
            else 
                TriggerClientEvent('rsg_weaponshop:alert', _source, "You are not a high enough level!")
            end
        else
            TriggerClientEvent('rsg_weaponshop:alert', _source, "You dont have enough money!")
        end
	end)
end)

-- buy ammo
RegisterServerEvent('rsg_weaponshop:buyammo')
AddEventHandler("rsg_weaponshop:buyammo", function(price, item2, lvl)
    TriggerEvent("redemrp:getPlayerFromId", source, function(user)
		local _source = source
		local level = user.getLevel()
        if user.getMoney() >= price then
            if level >= lvl then
                user.removeMoney(price)
				local ItemData = data.getItem(_source, item2)
				print(ItemData.ItemAmount)
				ItemData.AddItem(1)
				TriggerClientEvent('FRP:NOTIFY:Simple', 'You purchased ammo!', 3)
            else 
                TriggerClientEvent('rsg_weaponshop:alert', _source, "You are not a high enough level!")
            end
        else
            TriggerClientEvent('rsg_weaponshop:alert', _source, "You dont have enough money!")
        end
	end)
end)

-- ammo

-------- revolver_ammo
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
	TriggerClientEvent('rsg_weaponshop:giveammo', source, "WEAPON_REVOLVER_CATTLEMAN")
	local ItemData = data.getItem(source, 'revolver_ammo')
	ItemData.RemoveItem(1)
end)

-------- pistol_ammo
RegisterServerEvent("RegisterUsableItem:pistol_ammo")
AddEventHandler("RegisterUsableItem:pistol_ammo", function(source)
	TriggerClientEvent('rsg_weaponshop:giveammo', source, "WEAPON_PISTOL_VOLCANIC")
	local ItemData = data.getItem(source, 'pistol_ammo')
	ItemData.RemoveItem(1)
end)

-------- rifle_ammo
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
	TriggerClientEvent('rsg_weaponshop:giveammo', source, "WEAPON_RIFLE_BOLTACTION")
	local ItemData = data.getItem(source, 'rifle_ammo')
	ItemData.RemoveItem(1)
end)

-------- repeater_ammo
RegisterServerEvent("RegisterUsableItem:repeater_ammo")
AddEventHandler("RegisterUsableItem:repeater_ammo", function(source)
	TriggerClientEvent('rsg_weaponshop:giveammo', source, "WEAPON_REPEATER_EVANS")
	local ItemData = data.getItem(source, 'repeater_ammo')
	ItemData.RemoveItem(1)
end)

-------- shotgun_ammo
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
	TriggerClientEvent('rsg_weaponshop:giveammo', source, "WEAPON_SHOTGUN_PUMP")
	local ItemData = data.getItem(source, 'shotgun_ammo')
	ItemData.RemoveItem(1)
end)