local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('FRP:CREATOR:saveCreation')
AddEventHandler('FRP:CREATOR:saveCreation', function(characterName, Age, SkinMdf, isMale)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:createCharacter(characterName, Age, isMale)
    local pedModel 
    if Character ~= nil then
        
        Character:setSkinData(Character:getId(), SkinMdf) 

        Character:setData(Character:getId(), "metaData", "hunger", 100)
        Character:setData(Character:getId(), "metaData", "thirst", 100)
        Character:setData(Character:getId(), "metaData", "banco", 0)

        local encoded = json.encode({2547.787,-1179.890,53.311})
        Character:setData(Character:getId(), "metaData", "position", encoded)       
        User:setCharacter(Character:getId()) -- Will draw itself      
    end
    Wait(1000)
    TriggerClientEvent('FRP:CREATOR:FirstSpawn', _source)

    local Inventory = User:getCharacter():getInventory()

    Inventory:addItem('money', 5000)
    Inventory:addItem('Pain', 3)
    Inventory:addItem('eau', 3)


end)
