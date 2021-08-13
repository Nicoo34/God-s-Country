-- created by RexshackGaming : Discord : https://discord.gg/8gNCwDpQPb
-- youtube channel : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA

local blips = {

	-- add weapon shop blips to map
	{ name = 'Weapon Shop', sprite = 4149098929, x= -282.28, y = 780.59, z = 118.53 }, -- val
	{ name = 'Weapon Shop', sprite = 4149098929, x= 2715.9, y = -1285.04, z = 49.63 }, -- sait
	{ name = 'Weapon Shop', sprite = 4149098929, x= -856.95, y = -1391.59, z = 43.49 }, -- blackwater
	{ name = 'Weapon Shop', sprite = 4149098929, x= 1323.09, y = -1321.63, z = 77.89 }, -- rhodes

}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)