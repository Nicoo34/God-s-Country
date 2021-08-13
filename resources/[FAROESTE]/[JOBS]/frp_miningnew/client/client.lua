local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")



Citizen.CreateThread(
    function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for _, v in pairs(Config.Recolte) do
                DrawTxt("Appuyer sur E commencer à miner ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                if getDistance(coords, v) < 2 then
                    if IsControlJustReleased(0, 0xCEFD9220) then
                        local W = math.random(8000,15000)
                            MineAttach()
                            Citizen.Wait(10000)
                            TriggerServerEvent("FRP:RECOLTE:MINING")
                            Citizen.Wait(10000)
                            TriggerServerEvent("FRP:RECOLTE:MINING")
                            Citizen.Wait(10000)
                            TriggerServerEvent("FRP:RECOLTE:MINING")
                            FreezeEntityPosition(playerPed,true)
                            Citizen.Wait(W)
                            FreezeEntityPosition(playerPed,false)
                            DeleteObject(entity)
                            ClearPedTasks(playerPed)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
                    end
                end
         end
    end
end
)

Citizen.CreateThread(
    function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for _, v in pairs(Config.Traitement) do
                DrawTxt("Appuyer sur E commencer à traiter ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                if getDistance(coords, v) < 2 then
                    if IsControlJustReleased(0, 0xCEFD9220) then
                        local W = math.random(8000,15000)
                            Traitement()
                            Citizen.Wait(30000)
                            FreezeEntityPosition(playerPed,true)
                            Citizen.Wait(W)
                            FreezeEntityPosition(playerPed,false)
                            ClearPedTasks(playerPed)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
                            TriggerServerEvent("FRP:TRAITEMENT:MINING")
                    end
                end
         end
    end
end
)



function traitement()
    
end

function transformation()
end

function revente()
end



local square = math.sqrt
function getDistance(a, b) 
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return square(x*x+y*y+z*z)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
      SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

function MineAttach()
    local modelHash = GetHashKey("P_PICKAXE01X")
    local dict = "amb_work@world_human_pickaxe@wall@male_d@base"
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if IsPedMale(playerPed) then
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 40000, true, false, false, false)

    else
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 40000, true, false, false, false)

    end

end




