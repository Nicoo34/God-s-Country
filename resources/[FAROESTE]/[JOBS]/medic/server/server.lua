local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local ReviveEnable = false
local target = nil
local sort = nil
RegisterCommand(
    "poul",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medecin")
		local Inventory = User:getCharacter():getInventory()

		sort = math.random(1,2)
        if medic then
			TriggerClientEvent('FRP:MEDIC:checkdeath', _source)
			ReviveEnable = false
		end
    end
)

RegisterCommand(
    "soigner",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medecin")
		local Inventory = User:getCharacter():getInventory()

		sort = math.random(1,2)

		if medic then
			--if ReviveEnable then
				TriggerClientEvent('FRP:MEDIC:revivecheck', _source)
			--else
   			--	TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Esta pessoa já está morta.', 5000)
			--end
		end
    end
)

RegisterCommand(
    "traiter",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medecin")
		local Inventory = User:getCharacter():getInventory()

		if medic then
			TriggerClientEvent('FRP:MEDIC:TreatmentCheck', _source)
		end		
    end
)

RegisterServerEvent("FRP:MEDIC:checkjob")
AddEventHandler(
	"FRP:MEDIC:checkjob",
	function()
		local _source = source
		local User = API.getUserFromSource(_source)
		local Character = User:getCharacter()

		if Character == nil then
			return
		end

		local medecin = Character:hasGroupOrInheritance("medecin")
		local medic = Character:hasGroupOrInheritance("medic")

		if medecin then
			TriggerClientEvent("FRP:SHERIFF:medecinCheck", _source, medecin)
		end
		if medic then
			TriggerClientEvent("FRP:SHERIFF:MedicCheck", _source, medic)
		end
	end
)

RegisterServerEvent('FRP:MEDIC:checkcallback')
AddEventHandler('FRP:MEDIC:checkcallback', function(target)
	TriggerClientEvent('FRP:RESPAWN:CheckDeath', target)
end)

RegisterServerEvent('FRP:MEDIC:TreatmentCallback')
AddEventHandler('FRP:MEDIC:TreatmentCallback', function(target)
	TriggerClientEvent('FRP:RESPAWN:Treatment', target)
	ReviveEnable = false
end)

RegisterServerEvent('FRP:MEDIC:revivecallback')
AddEventHandler('FRP:MEDIC:revivecallback', function(target)
	TriggerEvent('FRP:MEDIC:revive', source, target)
	ReviveEnable = false
end)

RegisterServerEvent('FRP:MEDIC:StatusDeath')
AddEventHandler('FRP:MEDIC:StatusDeath', function(target, data)
	TriggerEvent('FRP:MEDIC:ReceiveStatus', target, data)
end)

RegisterServerEvent('FRP:MEDIC:ReceiveStatus')
AddEventHandler('FRP:MEDIC:ReceiveStatus', function(target, data)
	print(json.encode(data))
	if data[2] ~= nil then
		if data[2] then					
			TriggerClientEvent('FRP:NOTIFY:Simple', target, 'cette personne est décédée.', 5000)
			ReviveEnable = false
			return
		else
			TriggerClientEvent('FRP:NOTIFY:Simple', target, 'Cette personne a des battements de coeur.', 5000)
			ReviveEnable = true	
		end
	else
		TriggerClientEvent('FRP:NOTIFY:Simple', target, 'Cause de décès non identifiée.', 5000)
		ReviveEnable = false
	end	
	--TriggerClientEvent('FRP:MEDIC:ReceiveStatus', target, data)
end)


RegisterServerEvent('FRP:MEDIC:revive')
AddEventHandler('FRP:MEDIC:revive', function(source, target)	
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()
	local Inventory = User:getCharacter():getInventory()	

	if sort == 1 and ReviveEnable == false then
		ReviveEnable = true
		print('avec de la chance')
	end

	if ReviveEnable then
		TriggerClientEvent('FRP:MEDIC:revive', _source)
		Wait(2000)
		TriggerClientEvent('FRP:RESPAWN:PlayerUp', target)
		Character:varyExp(10)
		--Inventory:addItem('money', 500)	
		TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Réanimé avec succès.', 5000)
		print('Reanimado com sucesso.')
	else
		TriggerClientEvent('FRP:MEDIC:revive', _source)
		Wait(2000)
		TriggerClientEvent('FRP:RESPAWN:PlayerUp', target)
		Character:varyExp(10)
		--Inventory:addItem('money', 500)	
		TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Réanimé avec succès.', 5000)
		print('mort.')
	--	TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'malheureusement décédé.', 5000)
	end


end)



