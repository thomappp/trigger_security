local Table = {}

local BanPlayer = function(PlayerSource, Reason)
    local PlayerName = GetPlayerName(PlayerSource)
    print((Config.Messages.Console):format(PlayerName, PlayerSource, Reason))
    DropPlayer(PlayerSource, (Config.Messages.Client):format(Reason))
end

local RegisterSecureEvent = function(Trigger, Data)
    RegisterNetEvent(Trigger)
    AddEventHandler(Trigger, function(...)
        local PlayerSource = source
        
        Table[PlayerSource] = Table[PlayerSource] or {}
        Table[PlayerSource][Trigger] = Table[PlayerSource][Trigger] or { LastTime = 0, Calls = Data.MaxCalls and {} or nil }

        local TriggerData = Table[PlayerSource][Trigger]

        local Now = os.time() * 1000

        if Data.Cooldown then
            if (Now - TriggerData.LastTime < Data.Cooldown) then
                BanPlayer(PlayerSource, (Config.Messages.Cooldown):format(Trigger))
                return
            end

            TriggerData.LastTime = Now
        end

        if Data.MaxCalls then
            for i = #TriggerData.Calls, 1, -1 do
                if (Now - TriggerData.Calls[i]) > Data.MaxCalls.Interval then
                    table.remove(TriggerData.Calls, i)
                end
            end

            table.insert(TriggerData.Calls, Now)

            if #TriggerData.Calls > Data.MaxCalls.Count then
                BanPlayer(PlayerSource, (Config.Messages.MaxCalls):format(Trigger))
                return
            end
        end

        local Args = {...}

        if Data.Args and #Args ~= Data.Args then
            BanPlayer(PlayerSource, (Config.Messages.Args):format(Trigger))
            return
        end

        local PlayerPed = GetPlayerPed(PlayerSource)
        local PlayerCoords = GetEntityCoords(PlayerPed)

        if Data.Zone and #(PlayerCoords - Data.Zone.Coords) > Data.Zone.MaxDistance then
            BanPlayer(PlayerSource, (Config.Messages.Zone):format(Trigger))
            return
        end
        
        local PlayerIdentifier = GetPlayerIdentifier(PlayerSource, 0)

        if Data.Admin and not Config.Admins[PlayerIdentifier] then
            BanPlayer(PlayerSource, (Config.Messages.Admin):format(Trigger))
            return
        end
    end)
end

for Trigger, Data in pairs(Config.Triggers) do
    RegisterSecureEvent(Trigger, Data)
end