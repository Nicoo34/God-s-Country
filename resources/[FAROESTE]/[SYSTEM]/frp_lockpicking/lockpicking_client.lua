local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local gui = false
local currentlyInGame = false
local passed = false

RegisterCommand('lockpick', function()
  lockpick(100,50,10,5)
end)


function lockpick(pickhealth,pickdamage,pickPadding,distance)
  openGui()
  play(pickhealth,pickdamage,pickPadding,distance)
  currentlyInGame = true
  while currentlyInGame do
    Wait(400)
    if IsEntityDead(PlayerPedId()) then 
      closeGui()
    end

    if passed then
        return 100
    else
        return 0
    end
end

function openGui()
    gui = true
    SetNuiFocus(true, true)
    SendNUIMessage({openPhone = true})
end

function play(pickhealth, pickdamage, pickPadding, distance)
    SendNUIMessage({openSection = "playgame", health = pickhealth, damage = pickdamage, padding = pickPadding, solveDist = distance})
end

function CloseGui()
    currentlyInGame = false
    gui = false
    SetNuiFocus(false, false)
    SendNUIMessage({openPhone = false})
end

-- NUI Callback Methods
RegisterNUICallback(
    "close",
    function(data, cb)
        passed = false
        CloseGui()
        cb("ok")

        doorHashBeingLockpicked = nil
    end
)

RegisterNUICallback(
    "failure",
    function(data, cb)
        passed = false
        CloseGui()
        cb("ok")

        doorHashBeingLockpicked = nil

        TriggerServerEvent("FRP:LOCKPICKING:FailedLockpicking")
    end
)

RegisterNUICallback(
    "complete",
    function(data, cb)
        passed = true
        CloseGui()
        cb("ok")

        TriggerServerEvent("FRP:LOCKPICKING:SuccededLockpicking", doorHashBeingLockpicked)

        doorHashBeingLockpicked = nil
    end
)
end