// made by nforce

GM.Name = "The Void"
GM.Author = "nforce"

DeriveGamemode("base")

nothing = nothing or {}

function GM:Initialize()
    MsgC(Color(189, 51, 164), "Void (the gamemode) initialized.\n")
	if SERVER then
		ntCreateSQLTable()
	end
end

function GM:OnReloaded()
    refresh = true
    timer.Simple(3, function()
        refresh = false 
    end)
end

function nothing.IncludeFile(fileName)
	if (!fileName) then
		error("[Void] No file name for including.")
	end

	if fileName:find("sv_") then
		if (SERVER) then
			return include(fileName)
		end
	elseif fileName:find("sh_") then
		if (SERVER) then
			AddCSLuaFile(fileName)
		end

		return include(fileName)
	elseif fileName:find("cl_") then
		if (SERVER) then
			AddCSLuaFile(fileName)
		else
			return include(fileName)
		end
	end
end

function nothing.IncludeDir(directory)
	for k, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
    	nothing.IncludeFile(directory.."/"..v)
	end
end

nothing.IncludeDir("nothing/gamemode/core")
nothing.IncludeDir("nothing/gamemode/core/vgui")

local meta = FindMetaTable("Player")
function meta:IsDeveloper()
	return self:SteamID64() == "76561198015525483" and self:SteamID() == "STEAM_0:1:27629877"
end
