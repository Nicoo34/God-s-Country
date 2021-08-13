local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = nil
sex = nil
zoom = 4.0
offset = 0.2
DeleteeEntity = true
local InterP = true
local adding = true

local showroomHorse_entity
local showroomHorse_model

local MyHorse_entity
local IdMyHorse
cameraUsing = {
    {
        name = "Horse",
        x = 0.2,
        y = 0.0,
        z = 1.8
    },
    {
        name = "Olhos",
        x = 0.0,
        y = -0.4,
        z = 0.65
    }
}

local saddlecloths = {}
local acshorn = {}
local bags = {}
local horsetails = {}
local manes = {}
local saddles = {}
local stirrups = {}
local acsluggage = {}

Citizen.CreateThread(
    function()
        while adding do
            Citizen.Wait(0)
            for i, v in ipairs(HorseComp) do
                if v.category == "Saddlecloths" then
                    table.insert(saddlecloths, v.Hash)
                elseif v.category == "AcsHorn" then
                    table.insert(acshorn, v.Hash)
                elseif v.category == "Bags" then
                    table.insert(bags, v.Hash)
                elseif v.category == "HorseTails" then
                    table.insert(horsetails, v.Hash)
                elseif v.category == "Manes" then
                    table.insert(manes, v.Hash)
                elseif v.category == "Saddles" then
                    table.insert(saddles, v.Hash)
                elseif v.category == "Stirrups" then
                    table.insert(stirrups, v.Hash)
                elseif v.category == "AcsLuggage" then
                    table.insert(acsluggage, v.Hash)
                end
            end
            adding = false
        end
    end
)

RegisterCommand(
    "estabulo",
    function()
        OpenStable()
    end
)

function OpenStable()
    inCustomization = true
    horsesp = true

    local playerHorse = MyHorse_entity

    SetEntityHeading(playerHorse, 334)
    DeleteeEntity = true
    SetNuiFocus(true, true)
    InterP = true

    local hashm = GetEntityModel(playerHorse)

    if hashm ~= nil and IsPedOnMount(PlayerPedId()) then
        createCamera(PlayerPedId())
    else
        createCamera(PlayerPedId())
    end
    --  SetEntityVisible(PlayerPedId(), false)
    if not alreadySentShopData then
        SendNUIMessage(
            {
                action = "show",
                shopData = getShopData()
            }
        )
    else
        SendNUIMessage(
            {
                action = "show"
            }
        )
    end
    TriggerServerEvent("FRP:STABLE:AskForMyHorses")
end

local promptGroup
local varStringCasa = CreateVarString(10, "LITERAL_STRING", "Ecuries")
local blip
local prompts = {}
local SpawnPoint = {}
local StablePoint = {}
local HeadingPoint
local CamPos = {}


Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            local coords = GetEntityCoords(PlayerPedId())
            for _, prompt in pairs(prompts) do
                if PromptIsJustPressed(prompt) then
                    for k, v in pairs(Config.Stables) do
                        if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 7 then
                            HeadingPoint = v.Heading
                            StablePoint = {v.Pos.x, v.Pos.y, v.Pos.z}
                            CamPos = {v.SpawnPoint.CamPos.x, v.SpawnPoint.CamPos.y}
                            SpawnPoint = {x = v.SpawnPoint.Pos.x, y = v.SpawnPoint.Pos.y, z = v.SpawnPoint.Pos.z, h = v.SpawnPoint.Heading}
                            Wait(300)
                        end
                    end
                    OpenStable()
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        for _, v in pairs(Config.Stables) do
            -- blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, -145868367, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Ecuries")
            local prompt = PromptRegisterBegin()
            PromptSetActiveGroupThisFrame(promptGroup, varStringCasa)
            PromptSetControlAction(prompt, 0xE8342FF2)
            PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Acheter/vendre chevaux"))
            PromptSetStandardMode(prompt, true)
            PromptSetEnabled(prompt, 1)
            PromptSetVisible(prompt, 1)
            PromptSetHoldMode(prompt, 1)
            PromptSetPosition(prompt, v.Pos.x, v.Pos.y, v.Pos.z)
            N_0x0c718001b77ca468(prompt, 3.0)
            PromptSetGroup(prompt, promptGroup)
            PromptRegisterEnd(prompt)
            table.insert(prompts, prompt)
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
                RemoveBlip(blip)
            end
        end
    end
)

-- function deletePrompt()
--     if prompt ~= nil then
--         PromptSetVisible(prompt, false)
--         PromptSetEnabled(prompt, false)
--         PromptDelete(prompt)
--         prompt = nil
--         promptGroup = nil
--     end
-- end

function rotation(dir)
    local playerHorse = MyHorse_entity
    local pedRot = GetEntityHeading(playerHorse) + dir
    SetEntityHeading(playerHorse, pedRot % 360)
end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        if (data["key"] == "left") then
            rotation(20)
        else
            rotation(-20)
        end
        cb("ok")
    end
)

-- AddEventHandler(
--     'onResourceStop',
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, prompt in pairs(prompts) do
--                 PromptDelete(prompt)
-- 			end
--         end
--     end
-- )

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "hide"
            }
        )
    end
)

function createCam(creatorType)
    for k, v in pairs(cams) do
        if cams[k].type == creatorType then
            cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", cams[k].x, cams[k].y, cams[k].z, cams[k].rx, cams[k].ry, cams[k].rz, cams[k].fov, false, 0) -- CAMERA COORDS
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 3000, true, false)
            createPeds()
        end
    end
end

RegisterNUICallback(
    "Saddles",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            SaddlesUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xBAA7E618, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddles[num])
            setcloth(hash)
            SaddlesUsing = ("0x" .. saddles[num])
        end
    end
)

RegisterNUICallback(
    "Saddlecloths",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            SaddleclothsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x17CEB41A, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. saddlecloths[num])
            setcloth(hash)
            SaddleclothsUsing = ("0x" .. saddlecloths[num])
        end
    end
)

RegisterNUICallback(
    "Stirrups",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            StirrupsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xDA6DADCA, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. stirrups[num])
            setcloth(hash)
            StirrupsUsing = ("0x" .. stirrups[num])
        end
    end
)

RegisterNUICallback(
    "Bags",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            BagsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x80451C25, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. bags[num])
            setcloth(hash)
            BagsUsing = ("0x" .. bags[num])
        end
    end
)

RegisterNUICallback(
    "Manes",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            ManesUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xAA0217AB, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. manes[num])
            setcloth(hash)
            ManesUsing = ("0x" .. manes[num])
        end
    end
)

RegisterNUICallback(
    "HorseTails",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            HorseTailsUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x17CEB41A, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. horsetails[num])
            setcloth(hash)
            HorseTailsUsing = ("0x" .. horsetails[num])
        end
    end
)

RegisterNUICallback(
    "AcsHorn",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            AcsHornUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0x5447332, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acshorn[num])
            setcloth(hash)
            AcsHornUsing = ("0x" .. acshorn[num])
        end
    end
)

RegisterNUICallback(
    "AcsLuggage",
    function(data)
        zoom = 4.0
        offset = 0.2
        if tonumber(data.id) == 0 then
            num = 0
            AcsLuggageUsing = num
            local playerHorse = MyHorse_entity
            Citizen.InvokeNative(0xD710A5007C2AC539, playerHorse, 0xEFB31921, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, playerHorse, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            local num = tonumber(data.id)
            hash = ("0x" .. acsluggage[num])
            setcloth(hash)
            AcsLuggageUsing = ("0x" .. acsluggage[num])
        end
    end
)

myHorses = {}

function setcloth(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, MyHorse_entity, tonumber(hash), true, true, true)
end

RegisterNUICallback(
    "selectHorse",
    function(data)
        print(data.horseID)
        TriggerServerEvent("FRP:STABLE:SelectHorseWithId", tonumber(data.horseID))
    end
)

RegisterNUICallback(
    "sellHorse",
    function(data)
        print(data.horseID)
        DeleteEntity(showroomHorse_entity)
        TriggerServerEvent("FRP:STABLE:SellHorseWithId", tonumber(data.horseID))
        TriggerServerEvent("FRP:STABLE:AskForMyHorses")
    end
)

RegisterNetEvent("FRP:STABLE:ReceiveHorsesData")
AddEventHandler(
    "FRP:STABLE:ReceiveHorsesData",
    function(dataHorses)
        SendNUIMessage(
            {
                myHorsesData = dataHorses
            }
        )
    end
)


SaddlesUsing = nil
SaddleclothsUsing = nil
StirrupsUsing = nil
BagsUsing = nil
ManesUsing = nil
HorseTailsUsing = nil
AcsHornUsing = nil
AcsLuggageUsing = nil

--- /// ARRASTAR CAVALO

local alreadySentShopData = false



function getShopData()
    alreadySentShopData = true

    local ret = {
        {
            name = "Chevaux de labeur",
            ["A_C_Horse_AmericanPaint_SplashedWhite"] = {"American Paint à robe Balzane", 20, 50},
            ["A_C_Horse_AmericanPaint_Overo"] = {"American Paint à robe Overo", 21, 55},
            ["A_C_Horse_AmericanPaint_Greyovero"] = {"American Paint à robe Overo gris", 20, 50},
            ["A_C_Horse_AmericanPaint_Tobiano"] = {"American Paint à robe Tobiano", 21, 55},
            ["A_C_Horse_Appaloosa_BrownLeopard"] = {"Appaloosa à robe Léopard brun", 20, 50},
            ["A_C_Horse_Appaloosa_Blanket"] = {"Appaloosa à robe Capée", 21, 55},
            ["A_C_Horse_Appaloosa_LeopardBlanket"] = {"Appaloosa à robe Capé léopard", 20, 50},
            ["A_C_Horse_Appaloosa_Leopard"] = {"Appaloosa à robe Léopard", 21, 55},
            ["A_C_Horse_Appaloosa_FewSpotted_PC"] = {"Appaloosa tachés", 21, 55},
            ["A_C_Horse_DutchWarmblood_SootyBuckskin"] = {"Hollandais à sang chaud à robe Isabelle souty", 20, 50},
            ["A_C_Horse_DutchWarmblood_SealBrown"] = {"Hollandais à sang chaud à robe Noir pangaré", 21, 55},
            ["A_C_Horse_DutchWarmblood_ChocolateRoan"] = {"Hollandais à sang chaud à robe Rouan chocolat", 21, 55},
        },
        {
            name = "Chevaux de qualité supérieure",
            ["A_C_Horse_Arabian_Black"] = {"Pur-sang arabe à robe Noire", 5, 17},
            ["A_C_Horse_Arabian_Grey"] = {"Pur-sang arabe à robe Grise", 20, 50},
            ["A_C_Horse_Arabian_RedChestnut"] = {"Pur-sang arabe à robe Alezan Rouge", 21, 55},
            ["A_C_Horse_Arabian_RoseGreyBay"] = {"Pur-sang arabe à robe Alezan gris pommelé", 20, 50},
            ["A_C_Horse_Arabian_White"] = {"Pur-sang arabe à robe blanche", 21, 55},
            ["A_C_Horse_Arabian_WarpedBrindle_PC"] = {"Cheval arabe bringé déformé", 21, 55},
        },
        {
            name = "Chevaux de selle",
            ["A_C_HORSEMULE_01"] = {"Mula", 5, 17},
            ["A_C_Horse_KentuckySaddle_Black"] = {"Kentucky à robe Noire", 20, 50},
            ["A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC"] = {"Kentucky à robe blanche", 21, 55},
            ["A_C_Horse_KentuckySaddle_ChestnutPinto"] = {"Kentucky à robe Azelan pinto", 20, 50},
            ["A_C_Horse_KentuckySaddle_Grey"] = {"Kentucky à robe Grise", 21, 55},
            ["A_C_Horse_KentuckySaddle_SilverBay"] = {"Kentucky à robe Bai silver", 20, 50},
            ["A_C_Horse_Morgan_Bay"] = {"Morgan à robe Baie", 21, 55},
            ["A_C_Horse_Morgan_BayRoan"] = {"Tennessee Walker à robe Rouan crains lavés", 20, 50},
            ["A_C_Horse_Morgan_FlaxenChestnut"] = {"Morgan à robe Azelan crins lavés", 21, 55},
            ["A_C_Horse_Morgan_LiverChestnut_PC"] = {"Morgan à robe Azelan sombre", 20, 50},
            ["A_C_Horse_Morgan_Palomino"] = {"Tennessee Walker à robe Bai pommelé", 21, 55},
        },
        {
            name = "Chevaux polyvalents",
            ["A_C_Horse_Breton_MealyDappleBay"] = {"Breton à robe Bai pommelé pangaré", 5, 17},
            ["A_C_Horse_Breton_SteelGrey"] = {"Breton à robe Gris fer", 20, 50},
            ["A_C_Horse_Breton_GrulloDun"] = {"Breton à robe Grullo", 21, 55},
            ["A_C_Horse_Breton_SealBrown"] = {"Breton à robe Noir pangaré", 21, 55},
            ["A_C_Horse_Breton_Sorrel"] = {"Breton à robe Oseille", 21, 55},
            ["A_C_Horse_Breton_RedRoan"] = {"Breton à robe Rubican", 21, 55},
            ["A_C_Horse_GypsyCob_SplashedPiebald"] = {"Cob Gypsy à robe Pie balzan", 5, 17},
            ["A_C_Horse_GypsyCob_Skewbald"] = {"Cob Gypsy à robe Skewbald", 20, 50},
            ["A_C_Horse_GypsyCob_Piebald"] = {"Cob Gypsy à robe Pie", 21, 55},
            ["A_C_Horse_GypsyCob_PalominoBlagdon"] = {"Cob Gypsy à robe Blagdon palomino", 21, 55},
            ["A_C_Horse_GypsyCob_SplashedBay"] = {"Cob Gypsy à robe Bai balzan", 21, 55},
            ["A_C_Horse_GypsyCob_WhiteBlagdon"] = {"Cob Gypsy à robe Blagdon blanc", 21, 55},
            ["A_C_Horse_Criollo_BayBrindle"] = {"Criollo à robe Bai bringé", 5, 17},
            ["A_C_Horse_Criollo_BayFrameOvero"] = {"Criollo à robe Bai frame overo", 20, 50},
            ["A_C_Horse_Criollo_SorrelOvero"] = {"Criollo à robe Overo oseille", 21, 55},
            ["A_C_Horse_Criollo_Dun"] = {"Criollo à robe Dun", 21, 55},
            ["A_C_Horse_Criollo_BlueRoanOvero"] = {"Criollo à robe Overo noir rouanné", 21, 55},
            ["A_C_Horse_Criollo_MarbleSabino"] = {"Criollo à robe Sabino marmoré", 21, 55},
            ["A_C_Horse_Kladruber_Black"] = {"Kladruber à robe Noire", 5, 17},
            ["A_C_Horse_Kladruber_DappleRoseGrey"] = {"Kladruber à robe Alezan grisonnant pommelé", 20, 50},
            ["A_C_Horse_Kladruber_White"] = {"Kladruber à robe Blanche", 21, 55},
            ["A_C_Horse_Kladruber_Grey"] = {"Kladruber à robe Grise", 21, 55},
            ["A_C_Horse_Kladruber_Cremello"] = {"Kladruber à robe Cremello", 21, 55},
            ["A_C_Horse_Kladruber_Silver"] = {"Kladruber à robe Argentée", 21, 55},
            ["A_C_Horse_MissouriFoxtrotter_SilverDapplePinto"] = {"Missouri Fox Trotter à robe Pinto pommelé silver", 5, 17},
            ["A_C_Horse_MissouriFoxTrotter_AmberChampagne"] = {"Missouri Fox Trotter à robe Champagne ambre", 20, 50},
            ["A_C_Horse_Mustang_TigerStripedBay"] = {"Mustang à robe Bai tigré", 21, 55},
            ["A_C_Horse_Mustang_Buckskin"] = {"Mustang à robe Trullo", 21, 55},
            ["A_C_Horse_Mustang_Wildbay"] = {"Mustang à robe Bai sauvage", 21, 55},
            ["A_C_Horse_NorfolkRoadster_RoseGrey"] = {"Norfolk Roadster à robe Alezan grisonnant", 21, 55},
            ["A_C_Horse_NorfolkRoadster_SpeckledGrey"] = {"Norfolk Roadster à robe Grise tachetée", 5, 17},
            ["A_C_Horse_NorfolkRoadster_Black"] = {"Norfolk Roadster à robe Noire", 20, 50},
            ["A_C_Horse_NorfolkRoadster_SpottedTricolor"] = {"Norfolk Roadster à robe Capé tâché tricolore", 21, 55},
            ["A_C_Horse_NorfolkRoadster_PieBaldRoan"] = {"Norfolk Roadster à robe Pie rouanné", 21, 55},
            ["A_C_Horse_NorfolkRoadster_DappledBuckSkin"] = {"Norfolk Roadster à robe Isabelle pommelé", 21, 55},
            ["A_C_Horse_Turkoman_Gold"] = {"Turkoman à robe Dorée", 21, 55},
            ["A_C_Horse_Turkoman_DarkBai"] = {"Turkoman à robe Bai brun", 21, 55},
            ["A_C_Horse_Turkoman_Silver"] = {"Turkoman à robe Argentée", 21, 55},

        },
        {
            name = "Chevaux de course",
            ["A_C_Horse_Nokota_BlueRoan"] = {"Nokota à robe Noir rouanné", 47, 130},
            ["A_C_Horse_Nokota_ReverseDappleRoan"] = {"Nokota à robe Rouan pommelé inversé.", 135, 450},
            ["A_C_Horse_Nokota_WhiteRoan"] = {"Nokota à robe Rouan blanc", 47, 130},
            ["A_C_Horse_Thoroughbred_Brindle"] = {"Pur-sang à robe Bringée", 47, 130},
            ["A_C_Horse_Thoroughbred_DappleGrey"] = {"Pur-sang à robe Gris pommelé", 47, 130},
            ["A_C_Horse_Thoroughbred_BlackChestnut"] = {"Pur-sang Châtaignier Noir", 47, 130},
            ["A_C_Horse_Thoroughbred_BloodBay"] = {"Pur-sang à robe Bai acajou", 135, 450},
            ["A_C_Horse_Thoroughbred_ReverseDappleBlack"] = {"Pur-sang noir pommelé", 47, 130},
            ["A_C_Horse_AmericanStandardbred_PalominoDapple"] = {"Trotteur américain à robe Palomino pommelé", 47, 130},
            ["A_C_Horse_AmericanStandardbred_Black"] = {"Trotteur américain à robe Noire", 47, 130},
            ["A_C_Horse_AmericanStandardbred_Buckskin"] = {"Trotteur américain à robe Isabelle", 47, 130},
            ["A_C_Horse_AmericanStandardbred_SilverTailBuckskin"] = {"Trotteur américain à robe Isabelle queue argentée", 47, 130},


        },
        {
            name = "Chevaux de guerre",
            ["A_C_Horse_Andalusian_DarkBay"] = {"Andalou à robe Bai brun", 50, 140},
            ["A_C_Horse_Andalusian_Perlino"] = {"Andalou à robe Perlino", 50, 140},
            ["A_C_Horse_Andalusian_RoseGray"] = {"Andalou à robe Alezan grisonnant", 50, 140},
            ["A_C_Horse_Ardennes_BayRoan"] = {"Ardennais à robe Bai rouanné", 50, 140},
            ["A_C_Horse_Ardennes_IronGreyRoan"] = {"Ardennais à robe Grise", 50, 140},
            ["A_C_Horse_Ardennes_StrawberryRoan"] = {"Ardennais à robe Rouan fraise", 50, 140},
            ["A_C_Horse_HungarianHalfbred_DarkDappleGrey"] = {"Demi-sang hongrois à robe Gris pommelé foncé", 50, 140},
            ["A_C_Horse_HungarianHalfbred_FlaxenChestnut"] = {"Demi-sang hongrois Alezan à crins lavés", 50, 140},
            ["A_C_Horse_HungarianHalfbred_LiverChestnut"] = {"Demi-sang hongrois Alezan à crins clair", 50, 140},
            ["A_C_Horse_HungarianHalfbred_PiebaldTobiano"] = {"Demi-sang hongrois à robe Pie tobiano", 50, 140},
        },
        {
            name = "Chevaux de trait",
            ["A_C_Horse_Belgian_BlondChestnut"] = {"Belge à robe Alezan clair", 47, 130},
            ["A_C_Horse_Belgian_MealyChestnut"] = {"Belge à robe Alezan pangaré", 50, 140},
            ["A_C_Horse_Shire_DarkBay"] = {"Shire à robe Bai brun", 73, 200}, 
            ["A_C_Horse_Shire_LightGrey"] = {"Shire à robe Gris clair", 47, 130},
            ["A_C_Horse_Shire_RavenBlack"] = {"Shire à robe noir", 50, 140},
            ["A_C_Horse_SuffolkPunch_RedChestnut"] = {"Suffolk Punch à robe Oseille", 73, 200},     
            ["A_C_Horse_SuffolkPunch_Sorrel"] = {"Suffolk Punch à robe Alezan doré", 73, 200},       
        },
    }

    return ret
end


RegisterNUICallback(
    "loadHorse",
    function(data)
        local horseModel = data.horseModel

        if showroomHorse_model == horseModel then
            return
        end


        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
            showroomHorse_entity = nil
        end

        if MyHorse_entity ~= nil then
            DeleteEntity(MyHorse_entity)
            MyHorse_entity = nil
        end


        showroomHorse_model = horseModel

        local modelHash = GetHashKey(showroomHorse_model)

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(10)
            end
        end

        showroomHorse_entity = CreatePed(modelHash, SpawnPoint.x, SpawnPoint.y, SpawnPoint.z - 0.98, SpawnPoint.h, false, 0)
        Citizen.InvokeNative(0x283978A15512B2FE, showroomHorse_entity, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, showroomHorse_entity)
        NetworkSetEntityInvisibleToNetwork(showroomHorse_entity, true)
        SetVehicleHasBeenOwnedByPlayer(showroomHorse_entity, true)
        -- SetModelAsNoLongerNeeded(modelHash)

        interpCamera("Horse", showroomHorse_entity)
    end
)


RegisterNUICallback(
    "loadMyHorse",
    function(data)
        local horseModel = data.horseModel
        IdMyHorse = data.IdHorse
        if showroomHorse_model == horseModel then
            return
        end

        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
            showroomHorse_entity = nil
        end

        if MyHorse_entity ~= nil then
            DeleteEntity(MyHorse_entity)
            MyHorse_entity = nil
        end

        showroomHorse_model = horseModel

        local modelHash = GetHashKey(showroomHorse_model)

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(10)
            end
        end

        MyHorse_entity = CreatePed(modelHash, SpawnPoint.x, SpawnPoint.y, SpawnPoint.z - 0.98, SpawnPoint.h, false, 0)
        Citizen.InvokeNative(0x283978A15512B2FE, MyHorse_entity, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, MyHorse_entity)
        NetworkSetEntityInvisibleToNetwork(MyHorse_entity, true)
        SetVehicleHasBeenOwnedByPlayer(MyHorse_entity, true)

        local componentsHorse = json.decode(data.HorseComp)

        if componentsHorse ~= '[]' then
            for _, Key in pairs(componentsHorse) do
                local model2 = GetHashKey(tonumber(Key))
                if not HasModelLoaded(model2) then
                    Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
                end
                Citizen.InvokeNative(0xD3A7B003ED343FD9, MyHorse_entity, tonumber(Key), true, true, true)
            end
        end

        -- SetModelAsNoLongerNeeded(modelHash)

        interpCamera("Horse", MyHorse_entity)
    end
)


RegisterNUICallback(
    "BuyHorse",
    function(data)
        local HorseName = cAPI.prompt("nom de cheval:", "")
        
        if HorseName == "" then
            return
        end
        SetNuiFocus(true, true)

        TriggerServerEvent('FRP:STABLE:BuyHorse', data, HorseName)
    end
)



RegisterNUICallback(
    "CloseStable",
    function()
        SetNuiFocus(false, false)

        SendNUIMessage(
            {
                action = "hide"
            }
        )
        SetEntityVisible(PlayerPedId(), true)

        showroomHorse_model = nil

        if showroomHorse_entity ~= nil then
            DeleteEntity(showroomHorse_entity)
        end

        if MyHorse_entity ~= nil then
            DeleteEntity(MyHorse_entity)
        end

        DestroyAllCams(true)
        showroomHorse_entity = nil
        CloseStable()
    end
)


function CloseStable()
        local dados = {
            -- ['saddles'] = SaddlesUsing,
            -- ['saddlescloths'] = SaddleclothsUsing,
            -- ['stirrups'] = StirrupsUsing,
            -- ['bags'] = BagsUsing,
            -- ['manes'] = ManesUsing,
            -- ['horsetails'] = HorseTailsUsing,
            -- ['acshorn'] = AcsHornUsing,
            -- ['ascluggage'] = AcsLuggageUsing
            SaddlesUsing,
            SaddleclothsUsing,
            StirrupsUsing,
            BagsUsing,
            ManesUsing,
            HorseTailsUsing,
            AcsHornUsing,
            AcsLuggageUsing
        }
        local DadosEncoded = json.encode(dados)

        if DadosEncoded ~= "[]" then            
            TriggerServerEvent("FRP:STABLE:UpdateHorseComponents", dados, IdMyHorse ) 
        end

       
end


Citizen.CreateThread(
    function()
       while true do
        Citizen.Wait(100)
            if MyHorse_entity ~= nil then
                SendNUIMessage(
                    {
                        EnableCustom = "true"
                    }
                )
            else
                SendNUIMessage(
                    {
                        EnableCustom = "false"
                    }
                )
            end
       end
    end
)

function interpCamera(cameraName, entity)
    for k, v in pairs(cameraUsing) do
        if cameraUsing[k].name == cameraName then
            tempCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
            AttachCamToEntity(tempCam, entity, cameraUsing[k].x + CamPos[1], cameraUsing[k].y + CamPos[2], cameraUsing[k].z)
            SetCamActive(tempCam, true)
            SetCamRot(tempCam, -30.0, 0, HeadingPoint + 50.0)
            if InterP then
                SetCamActiveWithInterp(tempCam, fixedCam, 1200, true, true)
                InterP = false
            end
        end
    end
end

function createCamera(entity)
    groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(groundCam, StablePoint[1] + 0.5, StablePoint[2] - 3.6, StablePoint[3] )
    SetCamRot(groundCam, -20.0, 0.0, HeadingPoint + 20)
    SetCamActive(groundCam, true)
    RenderScriptCams(true, false, 1, true, true)
    --Wait(3000)
    -- last camera, create interpolate
    fixedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(fixedCam, StablePoint[1] + 0.5, StablePoint[2] - 3.6, StablePoint[3] +1.8)
    SetCamRot(fixedCam, -20.0, 0, HeadingPoint + 50.0)
    SetCamActive(fixedCam, true)
    SetCamActiveWithInterp(fixedCam, groundCam, 3900, true, true)
    Wait(3900)
    DestroyCam(groundCam)
end
