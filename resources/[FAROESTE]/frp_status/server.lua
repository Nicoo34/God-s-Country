

local PlayersStatus = {}

AddEventHandler("redemrp:playerLoaded", function(source, user)
    local _source = source
    local charid = Character:getId()
    MySQL.Async.fetchAll('SELECT * FROM status WHERE `charid`=@charid;', {
        charid = charid
    }, function(status)
        if status[1] then
            PlayersStatus[charid] = json.decode(status[1].status)
            PlayersStatus[charid].source = _source
            print("wwrp_status: Status Loaded!")
        else
            print("wwrp_status: Status Created!")

            local Created = {
                hunger = 100,
                thirst = 100,
                drunk = 0,
                drugs = 0,
                source = _source
            }
            local temp = {
                hunger = 100,
                thirst = 100,
                drunk = 0,
                drugs = 0
            }
            PlayersStatus[charid] = Created
            MySQL.Async.execute(
                'INSERT INTO status (`charid`, `status`) VALUES (@charid, @status);', {
                    charid = charid,
                    status = json.encode(temp)
                }, function(rowsChanged)
                end)
        end
        TriggerClientEvent('redemrp_status:UpdateStatus', tonumber(PlayersStatus[charid].source),
            PlayersStatus[charid].thirst, PlayersStatus[harid].hunger)
    end)

end)

AddEventHandler("redemrp:playerDropped", function(user)
    local charid = Character:getId()
    local temp = {}
    temp.hunger = PlayersStatus[charid].hunger
    temp.thirst = PlayersStatus[charid].thirst
    temp.drunk = PlayersStatus[ charid].drunk
    temp.drugs = PlayersStatus[charid].drugs
    MySQL.Async.execute("UPDATE status SET `status`='" .. json.encode(temp) ..
        "' WHERE `charid`=@cid", {
            cid = charid
        }, function(done)
            PlayersStatus[charid] = nil
        end)

end)

function UpdatePlayersStatus()
    SetTimeout(12000, function()
        Citizen.CreateThread(function()
            for id, status in pairs(PlayersStatus) do
                if PlayersStatus[id].hunger - 0.2 >= 0.0 then
                    PlayersStatus[id].hunger = PlayersStatus[id].hunger - 0.17
                end
                if PlayersStatus[id].thirst - 0.2 >= 0.0 then
                    PlayersStatus[id].thirst = PlayersStatus[id].thirst - 0.2
                end
                TriggerClientEvent('FRP:HUNGER:UpdateStatus', tonumber(PlayersStatus[id].source), PlayersStatus[id].thirst, PlayersStatus[id].hunger)
                Wait(10)
            end
            UpdatePlayersStatus()
        end)
    end)
end
UpdatePlayersStatus()

function UpdateDb()
    SetTimeout(300000, function()
        Citizen.CreateThread(function()
            for id, status in pairs(PlayersStatus) do
                local temp = {}
                temp.hunger = PlayersStatus[id].hunger
                temp.thirst = PlayersStatus[id].thirst
                temp.drunk = PlayersStatus[id].drunk
                temp.drugs = PlayersStatus[id].drugs
                local charid = Character:getId()
                MySQL.Async.execute("UPDATE status SET `status`='" .. json.encode(temp) ..
                    "' WHERE `charid`=@cid", {
                        cid = charid
                    }, function(done)
                    end)
                Wait(100)
            end
            UpdateDb()
        end)
    end)
end
UpdateDb()



RegisterServerEvent("redemrp_status:AddAmount")
AddEventHandler("redemrp_status:AddAmount", function(hunger , thirst)
    local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User.getCharacter()
    local charid = Character:getId()

        PlayersStatus[charid].hunger = PlayersStatus[charid].hunger + hunger
        PlayersStatus[charid].thirst = PlayersStatus[charid].thirst + thirst
        if PlayersStatus[charid].hunger > 100.0 then PlayersStatus[charid].hunger = 100 end
        if PlayersStatus[charid].thirst > 100.0 then PlayersStatus[charid].thirst = 100 end
        TriggerClientEvent('FRP:HUNGER:UpdateStatus', tonumber(PlayersStatus[charid].source), PlayersStatus[charid].thirst, PlayersStatus[charid].hunger)
end)

