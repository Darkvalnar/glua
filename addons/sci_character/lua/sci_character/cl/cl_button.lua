local PANEL = {}
function PANEL:Init()

	self:SetContentAlignment( 5 )

end

local button_n = Material("sci_char/button/button_normal.png")
local button_h = Material("sci_char/button/button_hover.png")
local button_disable = Material("sci_char/button/button_disabled.png")

function PANEL:Paint()
	self.mat = button_n
	
	if self.Disabled == true then
		self.mat = button_disable 
	elseif self.hovered == true then
		self.mat = button_h
	else
		self.mat = button_n
	end
	
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(self.mat)
	surface.DrawTexturedRect(0,0,self:GetWide(), self:GetTall())
		
	local offset = self:GetWide()*.3
	local iw = offset*.4
	draw.SimpleText(self:getText(), "StarHUDFontWeapon2", offset + offset*.1, self:GetTall()/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function PANEL:OnCursorEntered()
	self.hovered = true
end

function PANEL:OnCursorExited()
	self.hovered = false
end

function PANEL:DisablePerm(bool)
	self.Disabled = bool
end


function PANEL:Text(strText)
	self.MainText = strText
end

function PANEL:getText()
	return self.MainText
end
vgui.Register("DButton_Char", PANEL, "DButton")
