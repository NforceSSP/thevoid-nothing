local meta = FindMetaTable( "Player" )
if not meta then return end

// one of these functions errors and its because the player entity doesn't exist when one of these is called, was too lazy to fix
function meta:GetPlayTime()
	return self:TimeConnected()
end

function meta:GetTotalPlayTime()
    return plysqltimeval + plytimeconnected
end

function meta:SetSQLPlayTime(val) -- sets sql play time
	plysqltimeval = val
	plytimeconnected = 0
end

function timeToStr( time )
	local tmp = time
	local s = tmp % 60
	tmp = math.floor( tmp / 60 )
	local m = tmp % 60
	tmp = math.floor( tmp / 60 )
	local h = tmp % 24
	tmp = math.floor( tmp / 24 )
	local d = tmp % 7
	local w = math.floor( tmp / 7 )

	return string.format( "%02iw %id %02ih %02im %02is", w, d, h, m, s )
end