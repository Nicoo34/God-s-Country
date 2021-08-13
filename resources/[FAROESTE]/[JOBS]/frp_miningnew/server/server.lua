local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:RECOLTE:MINING')
AddEventHandler('FRP:RECOLTE:MINING', 
function()	
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    local Character = User:getCharacter()
    local count = math.random(1, 3)

            Inventory:addItem("raw_coal", count * 2)
            
            User:notify("item", "raw_coal", count * 2)
 
end
)


RegisterServerEvent('FRP:TRAITEMENT:MINING')
AddEventHandler('FRP:TRAITEMENT:MINING', 
function()	
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

    local iron = false
    local coal = false
    local copper = false
    local gold = false


    if Inventory:getItemAmount("raw_iron") >= 3 then
        iron = true
    end

    if Inventory:getItemAmount("raw_coal") >= 3 then
        coal = true
    end

    if Inventory:getItemAmount("raw_copper") >= 2 then
        copper = true
    end

    if not iron and not coal and not copper and not gold then
        User:notify("error", "Vous n'avez pas assez de minéraux à traiter!")
        return
    end

    TriggerClientEvent("FRP:MINING:StartProcessingAnimation", _source)

    User:notify("alert", "Traitement en cours...")

    Citizen.Wait(20000)

    if iron then
        if Inventory:getItemAmount("raw_iron") >= 3 then
            Inventory:removeItem(-1, "raw_iron", 3)
        end
    end

    if coal then
        if Inventory:getItemAmount("raw_coal") >= 3 then
            Inventory:removeItem(-1, "raw_coal", 3)
        end
    end

    if copper then
        if Inventory:getItemAmount("raw_copper") >= 2 then
            Inventory:removeItem(-1, "raw_copper", 2)
        end
    end
end
end
)