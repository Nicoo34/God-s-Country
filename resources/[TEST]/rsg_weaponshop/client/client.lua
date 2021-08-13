-- created by RexshackGaming : Discord : https://discord.gg/8gNCwDpQPb
-- youtube channel : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA


-- add weaponshop locations
local weaponshop = {

	{ x = -282.28, y = 780.59, z = 118.53 }, --val
    { x = 2715.9, y = -1285.04, z = 49.63 },  --saint
    { x = -856.95, y = -1391.59, z = 43.49 }, --blackwater
    { x= 1323.09, y = -1321.63, z = 77.89 }, --rhodes
	
}

local active = false
local ShopPrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil

function SetupShopPrompt()
    Citizen.CreateThread(function()
        local str = 'Browse Weapon Shop'
        ShopPrompt = PromptRegisterBegin()
        PromptSetControlAction(ShopPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ShopPrompt, str)
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        PromptSetHoldMode(ShopPrompt, true)
        PromptRegisterEnd(ShopPrompt)

    end)
end

AddEventHandler('rsg_weaponshop:hasEnteredMarker', function(zone)
    currentZone     = zone
end)

AddEventHandler('rsg_weaponshop:hasExitedMarker', function(zone)
    if active == true then
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        active = false
    end
    WarMenu.CloseMenu()
	currentZone = nil
end)

Citizen.CreateThread(function()
    SetupShopPrompt()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZone = false

        for k,v in ipairs(weaponshop) do
            if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.5) then
                isInMarker  = true
                currentZone = 'weaponshop'
                lastZone    = 'weaponshop'
            end
        end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('rsg_weaponshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('rsg_weaponshop:hasExitedMarker', lastZone)
		end

    end
end)

-- menu start
Citizen.CreateThread(function()

    WarMenu.CreateMenu('weaponshop', "Weapon Shop")
    WarMenu.SetSubTitle('weaponshop', 'subtitle')
    WarMenu.CreateSubMenu('buy_revolver', 'weaponshop', '')
	WarMenu.CreateSubMenu('buy_pistol', 'weaponshop', '')
	WarMenu.CreateSubMenu('buy_rifle', 'weaponshop', '')
	WarMenu.CreateSubMenu('buy_shotgun', 'weaponshop', '')
	WarMenu.CreateSubMenu('buy_ammo', 'weaponshop', '')

    while true do

        if WarMenu.IsMenuOpened('weaponshop') then
			if WarMenu.MenuButton('Revolvers', 'buy_revolver') then
            end
			if WarMenu.MenuButton('Pistols', 'buy_pistol') then
            end
			if WarMenu.MenuButton('Rifles and Repeaters', 'buy_rifle') then
            end
			if WarMenu.MenuButton('Shotgun', 'buy_shotgun') then
            end
			if WarMenu.MenuButton('Ammo', 'buy_ammo') then
            end
            WarMenu.Display()
		
		
		-- buy revolvers
        elseif WarMenu.IsMenuOpened('buy_revolver') then
            
			if WarMenu.Button('Cattleman Revolver : ~pa~$50 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 50, "WEAPON_REVOLVER_CATTLEMAN", 1)
			
			elseif WarMenu.Button('LeMat Revolver : ~pa~$317 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 317, "WEAPON_REVOLVER_LEMAT", 1)
			
			elseif WarMenu.Button('Schofield Revolver : ~pa~$192 [9]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 192, "WEAPON_REVOLVER_LEMAT", 9)
			
			elseif WarMenu.Button('Double Action Revolver : ~pa~$127 [17]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 127, "WEAPON_REVOLVER_DOUBLEACTION", 17)
				
			elseif WarMenu.Button('High Roller Double-Action Revolver : ~pa~$190 [17]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 190, "WEAPON_REVOLVER_DOUBLEACTION_GAMBLER", 17)
			
			end
			WarMenu.Display()
		
		-- buy pistols
        elseif WarMenu.IsMenuOpened('buy_pistol') then
            
			if WarMenu.Button('Pistol Volcanic : ~pa~$270 [21]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 270, "WEAPON_PISTOL_VOLCANIC", 21)
				
			elseif WarMenu.Button('Pistol Semi-Automatic : ~pa~$537 [22]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 537, "WEAPON_PISTOL_SEMIAUTO", 22)
			
			elseif WarMenu.Button('Pistol Mauser : ~pa~$600 [34]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 600, "WEAPON_PISTOL_MAUSER", 34)
				
            end
            WarMenu.Display()
		
		-- buy rifles
        elseif WarMenu.IsMenuOpened('buy_rifle') then
            
			if WarMenu.Button('Evans Repeater : ~pa~$456 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 300, "WEAPON_REPEATER_EVANS", 1)
			
			elseif WarMenu.Button('Bolt Action Rifle : ~pa~$216 [7]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 216, "WEAPON_RIFLE_BOLTACTION", 7)
				
			elseif WarMenu.Button('Varmint Rifle : ~pa~$72 [8]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 72, "WEAPON_RIFLE_VARMINT", 8)
				
			elseif WarMenu.Button('Rolling Block Rifle : ~pa~$411 [13]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 411, "WEAPON_SNIPERRIFLE_ROLLINGBLOCK", 13)
				
			elseif WarMenu.Button('Springfield Rifle : ~pa~$156 [38]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 156, "WEAPON_RIFLE_SPRINGFIELD", 38)
				
			elseif WarMenu.Button('Carcano Rifel : ~pa~$456 [50]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 456, "WEAPON_SNIPERRIFLE_CARCANO", 50)
				
            end
            WarMenu.Display()
			
		-- buy shotgun
        elseif WarMenu.IsMenuOpened('buy_shotgun') then
            
			if WarMenu.Button('Pump-Action Shotgun : ~pa~$266 [5]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 266, "WEAPON_SHOTGUN_PUMP", 5)
			
			elseif WarMenu.Button('Repeating Shotgun : ~pa~$434 [11]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 434, "WEAPON_SHOTGUN_REPEATING", 11)
				
			elseif WarMenu.Button('Sawed-Off Shotgun : ~pa~$111 [19]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 111, "WEAPON_SHOTGUN_SAWEDOFF", 19)
				
			elseif WarMenu.Button('Double-Barreled Shotgun : ~pa~$185 [30]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 185, "WEAPON_SHOTGUN_DOUBLEBARREL", 30)
				
			elseif WarMenu.Button('Semi-Auto Shotgun : ~pa~$540 [42]') then
				TriggerServerEvent("rsg_weaponshop:buyweapon", 540, "WEAPON_SHOTGUN_SEMIAUTO", 42)
				
            end
            WarMenu.Display()
		
		-- buy ammo	
        elseif WarMenu.IsMenuOpened('buy_ammo') then
			
			if WarMenu.Button('Revolver Ammo : ~pa~$1 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyammo", 1, "revolver_ammo", 1)
				
			elseif WarMenu.Button('Pistol Ammo : ~pa~$1 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyammo", 1, "pistol_ammo", 1)
				
			elseif WarMenu.Button('Rifle Ammo : ~pa~$2 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyammo", 2, "rifle_ammo", 1)
				
			elseif WarMenu.Button('Repeater Ammo : ~pa~$2 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyammo", 2, "repeater_ammo", 1)
				
			elseif WarMenu.Button('Shotgun Ammo : ~pa~$2 [1]') then
				TriggerServerEvent("rsg_weaponshop:buyammo", 2, "shotgun_ammo", 1)
				
            end
            WarMenu.Display()
	
        end
		
        Citizen.Wait(0)
    end
end)
-- menu stop

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if currentZone then
            if active == false then
                PromptSetEnabled(ShopPrompt, true)
                PromptSetVisible(ShopPrompt, true)
                active = true
            end
            if PromptHasHoldModeCompleted(ShopPrompt) then
				WarMenu.OpenMenu('weaponshop')
                WarMenu.Display()
                PromptSetEnabled(ShopPrompt, false)
                PromptSetVisible(ShopPrompt, false)
                active = false

				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('rsg_weaponshop:alert')	
AddEventHandler('rsg_weaponshop:alert', function(txt)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", txt, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)

RegisterNetEvent('rsg_weaponshop:equipitem1')
AddEventHandler('rsg_weaponshop:equipitem1', function(item1)
    Citizen.CreateThread(function()
        local equipitem = GetHashKey(item1)
		local playerPed = PlayerPedId()
        Wait(1000)
		GiveDelayedWeaponToPed(playerPed, equipitem, 100, true)
	end, false)
end)

RegisterNetEvent('rsg_weaponshop:giveammo')
AddEventHandler('rsg_weaponshop:giveammo', function(type)
    local player = GetPlayerPed()
    local ammo = GetHashKey(type)
    SetPedAmmo(player, ammo, 100)
end)