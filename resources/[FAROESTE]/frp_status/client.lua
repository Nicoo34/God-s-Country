
Citizen.CreateThread(function()
    while true do
        Wait(10)
        if GetCurrentTemperature() < 0 then
            TriggerEvent('FRP:NOTIFY:Simple', 'Vous avez froid.', 3000)
            Wait(300000)
        elseif GetCurrentTemperature() > 28 then
            TriggerEvent('FRP:NOTIFY:Simple', "Vous avez chaud", 3000)
            Wait(300000)
        else
        end
    end
end)

local active = false
Citizen.CreateThread(function()
    while true do
        Wait(150)
        if active == false then
            if IsPedRunning(PlayerPedId()) then
                active = true
                SendNUIMessage({
                    showhud = true
                })
            end
        end
        if active == false then
            if IsPedSprinting(PlayerPedId()) then
                active = true
                SendNUIMessage({
                    showhud = true
                })
            end
        end
        if active == true then
            if IsPedStopped(PlayerPedId()) then
                active = false
                SendNUIMessage({
                    showhud = false
                })
            end
        end
    end
end)

RegisterNetEvent('FRP:HUNGER:UpdateStatus')
AddEventHandler('FRP:HUNGER:UpdateStatus', function(thrist, hunger)
    Wait(1000)
    local shownotifiaction1 = false
    local shownotifiaction2 = false
    if hunger <= 10 and not shownotifiaction2 then
        shownotifiaction1 = true
        TriggerEvent('FRP:NOTIFY:Simple', "Vous êtes affamé", 3000)
    end

    if thrist <= 10 and not shownotifiaction1 then
        shownotifiaction2 = true
        TriggerEvent('FRP:NOTIFY:Simple', "Vous mourrez de soif", 3000)
    end
    shownotifiaction2 = not shownotifiaction2
    shownotifiaction1 = not shownotifiaction1
    if thrist <= 1 or hunger <= 1 then
        local health = GetEntityHealth(PlayerPedId())
        local remove = health - 25
        if remove < 0 then
            remove = 0
            Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
        end
        SetEntityHealth(PlayerPedId(), remove)
        Citizen.CreateThread(function()
            SendNUIMessage({
                showhud = true
            })
            Citizen.Wait(4000)
            SendNUIMessage({
                showhud = false
            })
        end)
    end
    SendNUIMessage({
        thrist = thrist,
        hunger = hunger,
        temp = GetCurrentTemperature()
    })
end)

function GetCurrentTemperature()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    ShouldUseMetricTemperature()
    return round(GetTemperatureAtCoords(coords.x, coords.y, coords.z), 1)
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end



