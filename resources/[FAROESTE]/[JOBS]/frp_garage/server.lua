local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:HORSE:GARAGE')
AddEventHandler('FRP:HORSE:GARAGE', function()
    local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()

            
    local Horse = Character:getHorse()
        
    TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Cheval selectionné', 5000)

end)