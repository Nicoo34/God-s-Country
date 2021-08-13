local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")


bankpos = {
    vector3(1282.596,-1308.520,77.040)--RHODES BANK

}

bankpos = {
    vector3(1282.596,-1308.520,77.040)--RHODES BANK

}

doors = {
    vector3(1282.536376953125,-1309.31591796875,76.03642272949219)
}

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




Citizen.CreateThread(
    function()
        local animDict = "script_story@nbd1@ig@ig_10_placingdynamite"
        local modelHash = GetHashKey("w_throw_dynamite03")
        local doorsentity = GetHashKey("p_door_val_bankvault")
        local entity2 = GetHashKey("p_door_val_bankvault")
        local moneybag = GetHashKey("p_moneybag01x")
        while true do
          Citizen.Wait(0)
          local playerPed = PlayerPedId()
          local coords = GetEntityCoords(playerPed)
          local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
         -- porte = CreateObject(doorsentity, 1282.536376953125,-1309.31591796875,76.03642272949219, true, false, false)
          for _, v in pairs(bankpos) do
            if getDistance(coords, v) < 2 then
                DrawTxt("Press E to attach dynamite ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                if IsControlJustReleased(0, 0xCEFD9220) then
                    LoadModel(modelHash)
                    entity = CreateObject(modelHash, 1282.897705078125, -1308.8197021484375, 77.0, true, false, false)
                    SetEntityVisible(entity, true)
                    SetEntityAlpha(entity, 255, false)
                    AttachEntityToEntity(entity, entity2, boneIndex,  1282.897705078125, -1308.8197021484375, 77.0, 0.0, 100.0, 68.0, false, false, false, true, 2, true)
                   RequestAnimDict(animDict)
                   while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(100)
                   end
                   TaskPlayAnim(PlayerPedId(), animDict, "left_nogun_2hands_look_01_arthur", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
                   Citizen.Wait(10000)
                    AddExplosion(1282.897705078125, -1308.8197021484375, 77.0, 31, 50.0, true, false, 10)
                    Citizen.Wait(1)
                    DeleteEntity(entity)
                    CreateModelHide(1282.536376953125,-1309.31591796875,76.03642272949219, 0, "p_door_val_bankvault", false )
                end
              --  for _, v in pairs(bankpos) do
--                  if getDistance(coords, v) < 2 then
               --         DrawTxt("Press E to attach dynamite ", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                  --      if IsControlJustReleased(0, 0xCEFD9220) then
             --           end
                    --end
        --        end


            end

        end
    end
end
)

