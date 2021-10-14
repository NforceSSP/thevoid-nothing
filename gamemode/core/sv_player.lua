
// credits to alex grist and `impulse
local playerMeta = FindMetaTable("Player")

// don't touch loaddata it has anomalous properties (unless you know what you're doing)
do
    function playerMeta:LoadData(callback)
        local steamID64 = self:SteamID64()
        local timestamp = math.floor(os.time())

        local query = mysql:Select("nothing_player")
            query:Select("play_time")
            query:Where("steamid", steamID64)
            query:Callback(function(result)
                if (IsValid(self) and istable(result) and #result > 0) then
                    local updateQuery = mysql:Update("nothing_player")
                        updateQuery:Update("last_join_time", timestamp)
                        updateQuery:Where("steamid", steamID64)
                    updateQuery:Execute()

                    self.PlayTime = tonumber(result[1].play_time) or 0

                    if (callback) then
                        callback(self.Data)
                    end
                else
                    local insertQuery = mysql:Insert("nothing_player")
                        insertQuery:Insert("steamid", steamID64)
                        insertQuery:Insert("play_time", 0)
                        insertQuery:Insert("last_join_time", timestamp)
                    insertQuery:Execute()

                    if (callback) then
                        callback({})
                    end
                end
            end)
        query:Execute()
    end
    // make sure savedata only runs once, it'll multiply the playtime if you run it more then once
    // there is a way to make it not do this but i am lazy
    function playerMeta:SaveData()
        local steamID64 = self:SteamID64()
        local time = self:TimeConnected()
        local oldtime = sql.QueryValue("SELECT play_time FROM nothing_player WHERE steamid = "..self:SteamID64())
        if !oldtime then oldtime = 0 end
        local query = mysql:Update("nothing_player")
            query:Update("play_time", math.floor(oldtime + time))
            query:Where("steamid", steamID64)
        query:Execute()
    end
end