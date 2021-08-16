local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')


local blip

local coefflouze = 0.1 --Coeficient multiplicateur qui en fonction de la distance definit la paie

--INIT--

local isInJobDelivery = false
local livr = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToPizzaria = false
local paie = 0

local pourboire = 0
local posibilidad = 0
local px = 0
local py = 0
local pz = 0


debut = { x = 1230.987, y = -1277.858, z = 76.022} --Configuration marker prise de service
fin = { x = 1240.262, y = -1283.042, z = 75.904} --Configuration marker fin de service
spawnwagon = { x = 1240.262, y = -1283.042, z = 75.904}  --Configuration du point de spawn du faggio

livpt = {
[1] = {name = "Point 1",  x= 803.006,    y= -849.135,   z= 55.15},
[2] = {name = "Point 2",  x= -72.550,    y= -397.537,   z= 71.516},
[3] = {name = "Point 3",  x= -334.294,    y= -355.809,  z= 88.081},
[4] = {name = "Point 4",  x= -191.132,    y=  639.085,  z= 113.281},
[5] = {name = "Point 5",  x= -268.124,    y= 847.434,  z= 120.925},
[6] = {name = "Point 6",  x=  784.862,    y= 849.297,  z= 118.603},
[7] = {name = "Point 7",  x= 1454.963,    y= 320.256,  z= 89.470},
[8] = {name = "Point 8",  x= 1375.910,    y= -865.689,  z= 69.315},
}


--THREADS--



Citizen.CreateThread(function() --Thread lancement + livraison depuis le marker vert
  while true do
    --Citizen.Wait(0)
    local sleep = 1000
    local playercoords = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(debut.x, debut.y, debut.z) - playercoords)
    if isInJobDelivery == false then
      MarkerFrp(debut.x,debut.y,debut.z,255, 0, 0, 20 )
      --Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, debut.x,debut.y,debut.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
      if distance < 1.5 then
        sleep = 4
        DrawText("Appuyez sur ALT pour commencer votre service" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
            cancelar()
            notif = true
            isInJobDelivery = true
            isToHouse = true
            livr = math.random(1, 30)

            px = livpt[livr].x
            py = livpt[livr].y
            pz = livpt[livr].z
            distance = round(#vector3(debut.x, debut.y, debut.z) - vector3(px,py,pz))
            paie = distance * coefflouze
            goliv(livpt,livr)
            nbDelivery = 5
        end
      end
    end

    if isToHouse == true then
      sleep = 4

      destinol = livpt[livr].name

      while notif == true do

        TriggerEvent('FRP:NOTIFY:Simple', 'Livrer les lettres aux destinations indiquées', 10000)
        notif = false

        i = 1
      end
      MarkerFrp(livpt[livr].x,livpt[livr].y,livpt[livr].z, 255, 0, 0, 20)
      --Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, livpt[livr].x,livpt[livr].y,livpt[livr].z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
      if #(vector3(px,py,pz) - GetEntityCoords(PlayerPedId())) < 3 then
        sleep = 4
        DrawText("Aperte ALT para entregar" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
          notif2 = true
          posibilidad = math.random(1, 100)
          afaitunepizzamin = true
          nbDelivery = nbDelivery - 1
          pourboire = math.random(25, 60)
          TriggerEvent('FRP:NOTIFY:Simple', 'Vous recevez $0.'.. pourboire, 10000)
          TriggerServerEvent("FRP:DELIVERY:pay", pourboire)
          RemoveBlip(blip) 
          ClearGpsMultiRoute()
          Wait(250)
          if nbDelivery == 0 then
            isToHouse = false
            isToPizzaria = true
          else
            isToHouse = true
            isToPizzaria = false
            livr = math.random(1, 30)

            px = livpt[livr].x
            py = livpt[livr].y
            pz = livpt[livr].z

            distance = round(GetDistanceBetweenCoords(debut.x, debut.y, debut.z, px,py,pz))
            paie = distance * coefflouze

            goliv(livpt,livr)
          end
        end
      end
    end
    if isToPizzaria == true then
      sleep = 4
      while notif2 == true do
        TriggerEvent('FRP:NOTIFY:Simple', 'Reviens pour prendre plus de lettre.', 10000)
        notif2 = false
      end
      MarkerFrp(debut.x,debut.y,debut.z, 255, 0, 0, 20)
      --Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, debut.x,debut.y,debut.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
      if #(vector3(debut.x,debut.y,debut.z) -  GetEntityCoords(PlayerPedId())) < 3 and afaitunepizzamin == true then
        sleep = 4
        DrawText("Aperte ALT para pegar as cartas" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
          if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
              afaitunepizzamin = false
              TriggerEvent('FRP:NOTIFY:Simple', 'Merci pour votre travail, voici votre argent $'.. paie, 10000)
              TriggerServerEvent("FRP:DELIVERY:pay", paie)
              isInJobDelivery = true
              isToHouse = true
              livr = math.random(1, 30)

              px = livpt[livr].x
              py = livpt[livr].y
              pz = livpt[livr].z

              distance = round(#vector3(debut.x, debut.y, debut.z) - vector3(px,py,pz))
              paie = distance * coefflouze

              goliv(livpt,livr)
              nbDelivery = 5
          end
      end
     
    end
    if IsEntityDead(PlayerPedId()) then
      isInJobDelivery = false
      livr = 0
      isToHouse = false
      isToPizzaria = false

      paie = 0
      px = 0
      py = 0
      pz = 0
      RemoveBlip(blip) 
      ClearGpsMultiRoute()
    end
    Citizen.Wait(sleep)
  end
end)



Citizen.CreateThread(function() -- Thread de "fim de serviço"
  while true do
    local sleep = 1000
    local pedcoord = GetEntityCoords(PlayerPedId())
    if isInJobDelivery == true then
      MarkerFrp(fin.x,fin.y,fin.z, 255, 0, 0, 20)
      if #(vector3(fin.x, fin.y, fin.z) - pedcoord) < 2.5 then
        sleep = 4
        DrawText("Appuyez sur ALT pour annuler les livraisons.", 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
          isInJobDelivery = false
          livr = 0
          isToHouse = false
          isToPizzaria = false
          paie = 0
          px = 0
          py = 0
          pz = 0
          if afaitunepizzamin == true then
            local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )
            TriggerEvent('FRP:NOTIFY:Simple', 'fin de service.', 10000)
            SetWaypointOff()
            afaitunepizzamin = false
          else
            local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )
            TriggerEvent('FRP:NOTIFY:Simple', 'fin de service.', 10000)
          end
        end
      end
    end
    Citizen.Wait(sleep)
  end
end)

--FONCTIONS--

function cancelar()
  CreateThread(function()
    while isInJobDelivery do
      Wait(5)
      if IsControlJustReleased(0, 0x3C0A40F2) then -- TECLA F6
        ClearGpsMultiRoute()
        SetWaypointOff()
        isInJobDelivery = false
        livr = 0
        isToHouse = false
        isToPizzaria = false
        paie = 0
        px = 0
        py = 0
        pz = 0
        if afaitunepizzamin == true then
          local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
          SetEntityAsMissionEntity( vehicleu, true, true )
          deleteCar( vehicleu )
          SetWaypointOff()
          afaitunepizzamin = false
        else
          local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)
          SetEntityAsMissionEntity( vehicleu, true, true )
          deleteCar( vehicleu )
        end
        TriggerEvent('FRP:NOTIFY:Simple', 'fin de service.', 10000)
      end
    end
  end)
end

function MarkerFrp(x,y,z,r,g,b,a)
  Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, x,y,z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, r, g, b, a, 0, 0, 2, 0, 0, 0, false)    
end


function goliv(livpt,livr)
  ClearGpsMultiRoute()
  Wait(500)	
  StartGpsMultiRoute(76603059, true, true)
  liv = AddPointToGpsMultiRoute(livpt[livr].x,livpt[livr].y, livpt[livr].z)
  SetGpsMultiRouteRender(true) 

  blip = N_0x554d9d53f696d002(408396114, livpt[livr].x,livpt[livr].y, livpt[livr].z)
  SetBlipSprite(blip, 408396114, 1)
  SetBlipScale(blip, 0.1)
  Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Livraison')
end

function spawn_faggio() -- Thread spawn faggio
  local veh = GetHashKey('UTILLIWAG')
  local ply = GetPlayerPed()
  local coords = GetEntityCoords(ply)
  Citizen.CreateThread(
    function()
      RequestModel(veh)
      while not HasModelLoaded(veh) do
                  Wait(1000)                    
      end
      if HasModelLoaded(veh) then
          car = CreateVehicle(veh, spawnwagon.x,spawnwagon.y,spawnwagon.z, 264.0, true, true, false, true)
      end
    end)
end

function round(num, numDecimaldebuts)
  local mult = 5^(numDecimaldebuts or 0)
  return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
  Citizen.InvokeNative( 0xE20A909D8C4A70F8, Citizen.PointerValueIntInitialized( entity ) ) --Native qui del le vehicule
end

function IsInVehicle() --Fonction de verification de la presence ou non en vehicule du joueur
  local ply = PlayerPedId()
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end


function playAnim(dict, anim, speed)
  if IsEntityPlayingAnim(PlayerPedId(), dict, anim) then
      RequestAnimDict(dict)
      -- while HasAnimDictLoaded(dict) && !noCrash do
      --     -- noCrash = setTimeout(function ()
      --     --     RequestAnimDict(dict)
      --     -- }, 1000);
      -- end
      TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
  end
end

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
  SetTextScale(w, h)
  SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
  SetTextCentre(centre)
  if enableShadow then
      SetTextDropshadow(1, 0, 0, 0, 255)
  end
  Citizen.InvokeNative(0xADA9255D, font)
  DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end