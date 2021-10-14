// made by nforce
// some of this gamemode is bandaid fixed and like half-broken
// the final version was originally going to be much more grand and not monotonous like the way it currently is
// this project is scrapped and will probably not be picked up by me again unless i gain some sudden interest

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

nothing = nothing or {}

util.AddNetworkString("NothingPlyConnected")
util.AddNetworkString("NothingPlyTime")
util.AddNetworkString("AchMenu")

function GM:PlayerSpawn(ply)
    
end

function GM:OnReloaded()
    MsgC(Color(189, 51, 164), "The void took ".. math.Truncate(FrameTime(), 4).." seconds to refresh.\n")
end

function GM:PlayerInitialSpawn(ply)
    if not ply:IsConnected() then return end
    self.JoinTime = RealTime()
    PrintMessage(HUD_PRINTTALK, ply:Nick() .. " spawned.")
    ply:LoadData()
    net.Start("NothingPlyConnected")
        net.WriteInt(sql.QueryValue("SELECT play_time FROM `nothing_player` WHERE steamid = "..ply:SteamID64()), 32)
    net.Send(ply)
end

function GM:PlayerDisconnected(ply) // possibly unreliable
    ply:SaveData()
end

function GM:Think()
    for k, ply in ipairs(player.GetAll()) do // getall in a think hook is a bad thing to do, don't learn off me
        if not ply:IsConnected() then return end
        net.Start("NothingPlyTime")
            net.WriteInt(ply:TimeConnected(), 32)
        net.Send(ply)
    end
end

concommand.Add("nt_wipedb", function(ply)
    if !IsValid(ply) then
        if not sql.TableExists("nothing_player") then return print("The void SQL table doesn't exist") end
        sql.Query("DROP TABLE nothing_player")
        MsgC(Color(255, 0, 0), "Void SQL table deleted, a server restart is required to produce a new one")
    end
end)