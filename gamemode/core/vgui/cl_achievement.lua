// the original achievement system in this gamemode is client-side, which means the client can run a malicious version of the game and manipulate achievements to get any one they want
// personally i don't see the merit, so i didn't fix it
// if you wish to fix it, network the achievement shit, if it's given by the server the client can't manipulate it

local PANEL = {}
// scrapped achievement stuff

/*function PANEL:Init()
	self:SetAlpha(0)
	self:SetSize(300, 120)
	self:CenterHorizontal(0.1)
	self:CenterVertical(0.85)
	self:MoveToFront() // don't delete movetofront
	surface.PlaySound("buttons/blip1.wav")
end

function PANEL:SetAchievement(thing)
	self.Achievement = nothing.config.ach[thing]

	local desc = vgui.Create("DLabel", self)
	desc:SetPos(20, 60)
	desc:SetSize(300, 60)
	desc:SetFont("VFont14")
	desc:SetContentAlignment(7)
	desc:SetWrap(true)
	desc:SetText(self.Achievement.Description)
end
// this probably looks like ass
local topCol = Color(30, 30, 30, 200)
function PANEL:Paint(w,h)
	draw.RoundedBox(0, 0, 0, w, h, topCol)

	draw.SimpleText("Achievement Unlocked", "VFont20", 20, 10, Color(255,255,255))
	draw.SimpleText(self.Achievement.Name, "VFont18", 20, 30)

end

vgui.Register("nothingAchievementGainedNotif", PANEL, "DPanel")
*/
