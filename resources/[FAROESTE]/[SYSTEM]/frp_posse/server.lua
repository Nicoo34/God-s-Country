local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
API_DB = Proxy.getInterface("API_DB")
cAPI = Tunnel.getInterface("API")

RegisterCommand(
    "bando",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
        if User:isInAPosse() then
            local data = {}
            local Posse = API.getPosse(User:getPosseId())
            for memberCharId, rank in pairs(Posse:getMembers()) do
                local name = API.getNameById(memberCharId)
                local isOnline = false
                local UserMember = API.getUserFromCharId(memberCharId)
                -- local CharLevel = UserMember:getCharacter():getLevel()
                local CharLevel = 0

                if UserMember ~= nil and UserMember:getCharacter():getId() == tonumber(memberCharId) then
                    isOnline = true
                end

                data[memberCharId] = {
                    UserID = UserMember:getId(),
                    rank = rank,
                    name = name,
                    level = CharLevel,
                    isOnline = isOnline
                }
            end
            TriggerClientEvent("FRP:POSSE:OpenMenu", source, data, Posse:getName())
        else
            -- else
            --     User:notify('Você não tem permissao para criar um Bando')
            -- end
            -- if User:getCharacter():hasGroup('donator01') then
            TriggerClientEvent("FRP:POSSE:OpenCreationMenu", source)
        end
    end,
    false
)

RegisterCommand(
    "convidar",
    function(source, args)
        local arg = args[1]
        TriggerEvent("FRP:POSSE:Invite", source, arg)
    end
)

RegisterNetEvent("FRP:POSSE:checkBando")
AddEventHandler(
    "FRP:POSSE:checkBando",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local level = Character:getLevel()

        if not User:isInAPosse() then
            if level < 0 then
                User:notify("Pour créer une bande vous devez être niveau 10")
                return
            end
            TriggerEvent("FRP:POSSE:createBando", _source)
        else
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Vous êtes déjà dans une bande, pour en créer un nouveau vous devez quitter l'actuel.", 5000)
        end
    end
)

RegisterNetEvent("FRP:POSSE:createBando")
AddEventHandler(
    "FRP:POSSE:createBando",
    function(source)
        local _source = source
        local PosseName = cAPI.prompt(source, "Nome do seu Bando", "")

        local User = API.getUserFromSource(_source)

        if PosseName == "" then
            TriggerClientEvent("FRP:NOTIFY:Simple", _source, "Vous n'avez pas entré de nom valide", 5000)
            return
        end
        API.createPosse(User:getCharacter():getId(), PosseName)
        TriggerClientEvent("FRP:NOTIFY:Simple", _source, "L'enregistrement de la bande " .. PosseName .. " est fait avec succès.", 5000)
    end
)

RegisterNetEvent("FRP:POSSE:Invite")
AddEventHandler(
    "FRP:POSSE:Invite",
    function(source, targetUserId)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if not User:isInAPosse() then
            User:notify("tu n'es pas dans une bande")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Posse = API.getPosse(User:getPosseId())

        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local UserTarget = API.getUserFromSource(TargetSource)
        local userRank = Posse:getMemberRank(Character:getId())

        if userRank == 3 then
            User:notify("Seul un membre de rang supérieur peut inviter dans la bande.")
            return
        end

        if UserTarget == nil then
            User:notify("l'utilisateur " .. targetUserId .. " n'est pas en ligne")
            return
        end

        if UserTarget:isInAPosse() then
            User:notify("l'utilisateur " .. targetUserId .. " est déjà dans une bande")
            return
        end

        User:notify("Vous avez invité l'ID " .. targetUserId .. " à rejoindre la bande")

        UserTarget:notify("vous avez été invité à rejoindre une bande.")

        local yes = cAPI.request(TargetSource, "Invitation à rejoindre la bande " .. Posse:getName() .. " ?", 30)

        if yes then
            UserTarget:notify("tu as rejoint le gang " .. Posse:getName())
            Posse:addMember(UserTarget, 3)
        else
            User:notify("L'utilisateur " .. targetUserId .. " a décliné l'invitation")
        end
    end
)

RegisterNetEvent("FRP:POSSE:Promote")
AddEventHandler(
    "FRP:POSSE:Promote",
    function(targetUserId)
        local _source = source
        local User = API.getUserFromSource(_source)

        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local UserT = API.getUserFromSource(TargetSource)

        if not User:isInAPosse() then
            User:notify("tu n'es pas dans une bande")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local TCharacter = UserT:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        if not Posse:isAMember(TCharacter:getId()) then
            User:notify(TCharacter:getName() .. " ne fait pas partie de la bande")
            return
        end

        local targetRank = Posse:getMemberRank(TCharacter:getId())
        if targetRank <= 2 then
            User:notify(TCharacter:getName() .. " est déjà au plus haut rang")
            return
        end

        local userRank = Posse:getMemberRank(Character:getId())

        if userRank <= 2 then
            if userRank == targetRank then
                User:notify("Seul un HR peut promouvoir ce membre.")
                return
            end

            Posse:promoteMember(TCharacter:getId())
            Posse:notifyMembers(TCharacter:getName() .. " a été promu dans le gang!")
        end
    end
)

RegisterNetEvent("FRP:POSSE:Demote")
AddEventHandler(
    "FRP:POSSE:Demote",
    function(targetUserId)
        local _source = source
        local User = API.getUserFromSource(_source)

        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local UserT = API.getUserFromSource(TargetSource)

        if not User:isInAPosse() then
            User:notify("tu n'es pas dans une bande")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local TCharacter = UserT:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        if not Posse:isAMember(TCharacter:getId()) then
            User:notify(TCharacter:getName() .. " ne fait plus partie du groupe")
            return
        end

        local targetRank = Posse:getMemberRank(TCharacter:getId())
        if targetRank == 3 then
            User:notify(charName .. " est déjà dans le rang le plus bas!")
            return
        end

        local userRank = Posse:getMemberRank(Character:getId())

        if userRank <= 2 then
            if userRank == targetRank then
                User:notify("Seul un HR peut rétrograder ce membre.")
                return
            end

            Posse:demoteMember(TCharacter:getId())
            Posse:notifyMembers(TCharacter:getName() .. " a été rétrogradé dans le gang!")
        end
    end
)

RegisterNetEvent("FRP:POSSE:Leave")
AddEventHandler(
    "FRP:POSSE:Leave",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)

        if not User:isInAPosse() then
            User:notify("tu n'es pas dans une bande")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        Posse:removeMember(Character:getId())
        Posse:notifyMembers(Character:getName() .. " a quitté le gang!")

        User:notify("tu as quitté le gang!")
    end
)

RegisterNetEvent("FRP:POSSE:Kick")
AddEventHandler(
    "FRP:POSSE:Kick",
    function(targetUserId)
        local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
        local User = API.getUserFromSource(TargetSource)

        if not User:isInAPosse() then
            User:notify("tu n'es pas dans une bande")
            TriggerClientEvent("FRP:POSSE:CloseMenu", _source)
            return
        end

        local Character = User:getCharacter()
        local Posse = API.getPosse(User:getPosseId())

        Posse:removeMember(Character:getId())
        Posse:notifyMembers(Character:getName() .. " a été kick de la bande!")

        User:notify("vous avez été renvoyé de la bande!")
    end
)
