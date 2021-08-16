local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
local warmenu = module("_core", "lib/warmenu")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

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





  Citizen.CreateThread(function()
    WarMenu.CreateMenu("GarageMenu", "Ecuries")
    WarMenu.CreateSubMenu("vehicleg", "GarageMenu", "Interaction avec le cheval")

    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for _, v in pairs(Config.Garage) do
                if getDistance(coords, v) < 2 then
                    DrawTxt("Appuyer sur E Pour voir vos chevaux", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
                    if IsControlJustReleased(0, 0xCEFD9220) then
                       print("1")
                        WarMenu.OpenMenu("GarageMenu")

                    end
                end
         end
    end
end
)



Citizen.CreateThread(
  function()
    Citizen.Wait(0)
      if WarMenu.IsMenuOpened("GarageMenu") then
        WarMenu.Display()
          if WarMenu.Button(data.horseID) then
            TriggerServerEvent("FRP:HORSE:GARAGE")
          end
            WarMenu.Display()
        end

end)