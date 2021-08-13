local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- Remove table KEYS !!!
-- Remove table KEYS !!!
-- Remove table KEYS !!!

local onGoingHunting = {}

local sellables = {
    {model = -2011226991, name = "Dinde sauvage orientale", value = 175}, --
    {model = -466054788, name = "Dinde sauvage du Rio Grande", value = 175}, --
    {model = 1458540991, name = "Raton laveur", value = 200}, --
    {model = 90267823, name = "Panthère", value = 300}, --
    {model = 1110710183, name = "Cerf de Virginie", value = 500}, --
    {model = -1963605336, name = "Cariacu", value = 500}, --
    {model = 480688259, name = "Coyote de la vallée de la Californie", value = 300}, --
    {model = -1414989025, name = "Virginie Opossum Saruê", value = 175}, --
    {model = -2063183075, name = "Poulet dominicain", value = 175}, --
    {model = -1170118274, name = "Blaireau d'Amérique", value = 175}, --
    {model = -1458540991, name = "raton laveur américain", value = 200}, --
    {model = 1755643085, name = "Antilope", value = 500}, --
    {model = -723190474, name = "Bernache du Canada", value = 175}, --
    {model = -1568716381, name = "Wapiti des montagnes Rocheuses", value = 500}, --
    {model = -885451903, name = "Loup", value = 175}, -- Raro
    {model = -1003616053, name = "canard", value = 200}, --
    {model = 40345436, name = "Mouton", value = 25}, --
    {model = -1568716381, name = "Wapiti des montagnes Rocheuses", value = 175}, --
    {model = -575340245, name = "Corbeau de l'Ouest", value = 200}, --
    {model = 1416324601, name = "Faisan à collier", value = 175}, --
    {model = -1211566332, name = "Mouffette rayée", value = 175}, --
    {model = -593056309, name = "iguane du désert", value = 175}, --
    {model = 457416415, name = "Monstre à rayures de Gila", value = 175}, --
    {model = -1134449699, name = "Rat musqué américain", value = 175}, --
    {model = -407730502, name = "Tortue carnivore", value = 175}, --
    {model = -1854059305, name = "Iguane vert", value = 200}, --
    {model = 2079703102, name = "Poulet-Legorne", value = 175}, --
    {model = 1459778951, name = "Aigle à tête blanche", value = 175}, --
    {model = 1104697660, name = "Vautour", value = 175}, --
    {model = -164963696, name = "Mouette rieuse", value = 175}, --
    {model = 386506078, name = "Plongeon à bec jaune", value = 175}, --
    {model = -1797625440, name = "Tatou à neuf bandes", value = 275}, --
    {model = 759906147, name = "Castor d'Amerique", value = 175}, --
    {model = -753902995, name = "Chèvre des montagnes", value = 175}, --
    {model = 1654513481, name = "Panthère légendaire", value = 375}, --
    {model = 1205982615, name = "Condor de Californie", value = 175} --
}

RegisterNetEvent("FRP:ANIMAL_HUNTING:TryToStartQuest")
AddEventHandler(
    "FRP:ANIMAL_HUNTING:TryToStartQuest",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if onGoingHunting[Character:getId()] then
            User:notify("error", "Terminez la chasse en cours pour pouvoir en commencer une autre!")
            return
        end

        local r = math.random(1, #sellables)

        local choosenAnimalModel = sellables[r]["model"]
        -- local choosenAnimalName = sellables[r]['name']

        -- Character:setData(Character:getId(), "metaData", "caca", choosenAnimalModel)

        -- TriggerClientEvent("FRP:ANIMAL_HUNTING:taskMission", _source, choosenAnimalModel)
        -- TriggerClientEvent('FRP:ANIMAL_HUNTING:AnimalHuntingPromptEnabled', _source, false, )
        TriggerClientEvent("FRP:ANIMAL_HUNTING:NotifyAnimalName", _source, 1, choosenAnimalModel)

        -- User:notify("alert", "Procure por " .. choosenAnimalName.. "!")

        onGoingHunting[Character:getId()] = choosenAnimalModel
    end
)

RegisterNetEvent("FRP:ANIMAL_HUNTING:TryToEndQuest")
AddEventHandler(
    "FRP:ANIMAL_HUNTING:TryToEndQuest",
    function(entType, entModel, entity, quality)
        local _source = source

        -- Character:getData(Character:getId(), "metaData", "caca")

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local characterId = Character:getId()

        if onGoingHunting[characterId] == nil or entModel ~= onGoingHunting[characterId] then
            TriggerClientEvent("FRP:BUTCHER:EntityNotAccepted", _source, entity)
            User:notify("error", "Le boucher ne veut pas de cet animal")
            return
        end

        local reward = sellables[onGoingHunting[characterId]]

        local Inventory = Character:getInventory()

        if Inventory:addItem("money", reward) then
            onGoingHunting[characterId] = nil

            User:notify("item", "money", reward)
            Character:varyExp(5)

            TriggerClientEvent("FRP:BUTCHER:EntityAccepted", _source, entity)
        else
            TriggerClientEvent("FRP:BUTCHER:EntityNotAccepted", _source, entity)
        end
    end
)

AddEventHandler(
    "API:OnUserCharacterInitialization",
    function(User, characterId)
        local _source = User:getSource()

        -- local quest_huntThisAnimal = Character:getData(Character:getId(), "metaData", "caca")
        -- for i = 1, #sellables, 1 do
        --     if sellables[i].model == quest_huntThisAnimal then
        --         Citizen.Wait(2500)
        --         TriggerClientEvent("FRP_notify", _source, "você ainda precisa procurar por um " .. sellables[i].name .. "!")
        --         break
        --     end
        -- end

        if onGoingHunting[characterId] then
            local animalHashBeingHunted = onGoingHunting[characterId]
            -- local animalName = sellables[animalHashBeingHunted]['name']
            -- TriggerClientEvent("FRP_notify", _source, "você ainda precisa procurar por um " ..  animalName .. "!")
            TriggerClientEvent("FRP:ANIMAL_HUNTING:NotifyAnimalName", _source, 2, animalHashBeingHunted)
        end
    end
)
