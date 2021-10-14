// this is messy

// networking
net.Receive("NothingPlyConnected", function(len, ply)
    plysqltimeval = net.ReadInt(32)
end)

net.Receive("NothingPlyTime", function(len, ply)
    plytimeconnected = net.ReadInt(32)
end)

// creating fonts
surface.CreateFont("NSFont", {
    font = "Corbel",
    size = 16,
    weight = 500,
})

surface.CreateFont("CRFont", {
    font = "Consolas",
    size = 16,
    weight = 200,
    antialias = true,
})

surface.CreateFont("VFont14", {
    font = "Segoe UI",
    size = 14,
    weight = 700,
})

surface.CreateFont("VFont20", {
    font = "Segoe UI",
    size = 20,
    weight = 700,
})

surface.CreateFont("VFont18", {
    font = "Segoe UI",
    size = 18,
    weight = 700,
})

// defining vars
local scrw, scrh = ScrW(), ScrH()

local hidden = {}
hidden["CHudHealth"] = true
hidden["CHudBattery"] = true
hidden["CHudAmmo"] = true
hidden["CHudSecondaryAmmo"] = true
hidden["CHudCrosshair"] = true
hidden["CHudHistoryResource"] = true
hidden["CHudPoisonDamageIndicator"] = true
hidden["CHudSquadStatus"] = true
hidden["CHUDQuickInfo"] = true

// functions
function GM:HUDShouldDraw(el)
    if hidden[el] then
        return false
    end

    return true
end

function GM:HUDPaint()
    surface.SetDrawColor(0,0,0)
    surface.DrawRect(0, 0, scrw, scrh)
    selfPanel = self
    if refresh then // this if can be deleted, i used it for debugging
        draw.SimpleText("oh look, a code refresh", "CRFont", scrw / 2, scrh * .95, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    if plysqltimeval == nil then
        draw.SimpleText("The SQL table has been deleted or is broken, restart the server or contact the owner!", "VFont20", scrw / 2, scrh * .5, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        return
    end
    draw.SimpleText("You've been in the void for ".. timeToStr(plysqltimeval + plytimeconnected) .. ".", "VFont14", scrw / 2, scrh * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function GM:ScoreboardShow() // this can be simplified a lot more, just put the contents of this in a function
    local players = player.GetCount()
    noscore = vgui.Create("DFrame")
    noscore:SetSize(200,200)
    noscore:SetDraggable(false)
    noscore:ShowCloseButton(false)
    noscore:SetTitle("")
    noscore:Dock(RIGHT)
    gui.EnableScreenClicker(true)
    if noscore:IsHovered() then print("yes") end
    noscore.Paint = function(me, w, h)
        surface.SetDrawColor(76, 70, 70, 100)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText(players .. " player(s) enjoy a black screen", "NSFont", w / 2, h * .01, Color(189,189,189), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    local ypos = noscore:GetTall() * .15
    for _, ply in ipairs(player.GetAll()) do
        local playerscore = vgui.Create("DPanel", noscore)
        playerscore:SetPos(noscore:GetWide() / 4, ypos)
        playerscore:SetSize(noscore:GetWide() / 2, noscore:GetTall() * .1)
        
        local name = ply:Name()
        playerscore.Paint = function(me, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(0,0,0))
            if ply:IsDeveloper() then // only for recognition
                draw.SimpleText(name, "VFont14", w / 2, h / 2, Color(151,25,25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(name, "VFont14", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
        
        ypos = ypos + playerscore:GetTall() * 1.2
    end
    
    surface.PlaySound("hl1/fvox/blip.wav")
end

function GM:ScoreboardHide()
    noscore:Remove()
    gui.EnableScreenClicker(false)
end