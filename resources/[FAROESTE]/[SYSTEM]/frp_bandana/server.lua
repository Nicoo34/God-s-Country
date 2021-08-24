local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")


local InventoryTarget = CharacterTarget:getInventory()


RegisterCommand("bandana", function(source, args) 
    local _source = source
    local user = API.getUserFromSource(_source)
    local comps = user.comps
    TriggerClientEvent("syn_verst:bandana",_source, comps)
end)

RegisterCommand("sleeves", function(source, args) 
    local _source = source
    local user = API.getUserFromSource(_source)
    local comps = user.comps
    TriggerClientEvent("syn_verst:sleeves",_source, comps)
end)
RegisterCommand("sleeves2", function(source, args) 
    local _source = source
    local user = API.getUserFromSource(_source)
    local comps = user.comps
    TriggerClientEvent("syn_verst:sleeves2",_source, comps)
end)
