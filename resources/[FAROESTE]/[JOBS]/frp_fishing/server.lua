RegisterServerEvent("kcrp:buydog")
AddEventHandler(
    "kcrp:buydog",
    function(dog)
        print(dog)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        if Inventory:getItemAmount("money") < 2 then
            User:notify("error", "Pas assez d'argent!")
            return
        end
        TriggerClientEvent("kcrp:spawndog", _source)
    end
)

RegisterServerEvent("clothes:buy")
AddEventHandler(
    "clothes:buy",
    function(price)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        if Inventory:getItemAmount("money") < price then
            User:notify("error", "Pas assez d'argent!")
            return
        end

        Inventory:removeItem(-1, "money", price)
        User:notify("item", "money", -price)
    end
)
