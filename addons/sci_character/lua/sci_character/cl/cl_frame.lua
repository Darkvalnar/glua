--[[ Nykez 2017. Do not edit ]]--

if !CLIENT then return end
--------------
local PANEL = {}
PANEL.BaseMat = Material(SChar.Config.MainBackground, "noclamp smooth")
PANEL.TitleMat = Material("sci_char/border/top_border_effect.png")
PANEL.extraX = 0


local skinselect = Material("sci_char/next_stage_box.png")
local skinselect_h = Material("sci_char/current_stage.png")

local aboutmat = Material("sci_char/description_head.png")
local aboutmat_desc = Material("sci_char/description_body.png")
local textbox = Material("sci_char/namebox.png")
local approved = Material("sci_char/approved.png")
local deny = Material("sci_char/denied.png")
local bg_2 = Material("sci_char/seg_bg.png")

local scroll_right = Material("sci_char/slider/right_n.png")
local scroll_left = Material("sci_char/slider/left_n.png")



function PANEL:Init()
	self.Title = "Window"
	self.lblTitle:Remove()
	self.btnMaxim:Remove()
	self.btnMinim:Remove()
	
	self.Models = {}
	
	
	self.inuse = false
	
	self.Vehicles = vgui.Create("DPanel", self)
	self.Vehicles:SetPos(self:GetWide()/2 + 500, self:GetTall()/2 + 330)
	self.Vehicles:SetSize(500, 416)
	self.Vehicles.Paint = function(me) 
		//draw.RoundedBox(4, 0, 0, me:GetWide(), me:GetTall(), Color(255, 255, 255, 255))
	end
	self.Selected = 1
	
end

function PANEL:SetPanelColor(col)
	self.PanelColor = col
end

function PANEL:GetPanelColor()
	return self.PanelColor
end

local bg_mat = Material("sci_char/shadow_drop.png")
function PANEL:Paint(w, h)
	local offset = self:GetTall()*.1
	local th = offset*.85
	local labelw = self:GetWide()*.25
	local labelh = offset*.95
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial(self.BaseMat)
	surface.DrawTexturedRect( 0, 0, self:GetWide(), self:GetTall())
	
	local space = offset*.99
	if SChar.Config.BorderEffects == true then
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(self.TitleMat)
		surface.DrawTexturedRect(0, offset - space, self:GetWide(), 76)
	end
	
	if (SChar.Config.EnabledShadow == true and self.inuse == false) then
		surface.SetMaterial(bg_mat)
		surface.DrawTexturedRect(self:GetWide()/2 - 300, self:GetTall()/2 - 300, 589, 750)
	end
	
	self.extraX = Lerp(RealFrameTime() * 2, self.extraX, self.Selected)

	for k, v in pairs(self.Models) do
		if (ValidPanel(v)) then
			v:SetPos((k - self.extraX) * (512 - 64), -80)
		end
	end
end

function PANEL:StartModels(strGender, strFaction)
	for k,v in pairs(self.Models) do
		if (ValidPanel(v)) then
			v:Remove()
		end
	end
	self.Selected = 1
	self.extraX = 0
	self.Models = nil
	self.Models = {}
	
	self.extraX = Lerp(RealFrameTime() * 2, self.extraX, self.Selected)

	for k, v in pairs(self.Models) do
		if (ValidPanel(v)) then
			v:SetPos((k - self.extraX) * (512 - 64), -80)
			v:SetPos((k - self.extraX) * (512 - 64), -80)
		end
	end
	
	self:DoModelFill(strGender, strFaction)
end

function PANEL:ReturnModel()
	return self.Models[self.Selected].Model
end

local space = 0
local ang = 0
function PANEL:DoModelFill(strGender, strFaction)
	local strGender = tostring(strGender)
	local strFaction = tostring(strFaction)
	
	self.started = true
	
	self.ang = 0

	local data;
	if strGender == "Male" then
		data = SChar.Database.Faction[strFaction].Models.Male
	else
		data = SChar.Database.Faction[strFaction].Models.Female
	end


	for k,v in pairs(data) do
	
		local icon = vgui.Create( "DModelPanel", self.Vehicles )
		icon:SetSize(512 - 64, 600)
		icon:SetPos((space - 1) * (512+40) + 60, 20)
		icon:SetModel(v)
		icon.Angles = Angle(0, 0, 0)
		icon.Model = v
		
		space = space + 1
	
		function icon:DragMousePress()
			self.PressX, self.PressY = gui.MousePos()
			self.Pressed = true
		end

		//icon:SetModelScale( icon.Entity:GetModelScale() * 1.25, 1 )
		icon.Entity:SetModelScale( icon.Entity:GetModelScale() * 2, 1 )

		function icon:DragMouseRelease() self.Pressed = false end

		function icon:LayoutEntity( ent )
			if ( self.bAnimated ) then self:RunAnimation() end

			if ( self.Pressed ) then
				local mx, my = gui.MousePos()
				self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )

				self.PressX, self.PressY = gui.MousePos()
			end

			ent:SetAngles( self.Angles )
		end
		
		table.insert(self.Models, icon)
	end 
	
	self.Back = vgui.Create("DButton_Char", self)
	self.Back:SetSize(150, 30)
	self.Back:SetPos(ScrW()/2 -180, self:GetTall()*0.83)
	self.Back.DoClick = function()
		if (#self.Models > 0 and self.Selected > 1) then
			self.Selected = self.Selected - 1
		else
			self.Selected = table.maxn(self.Models)
		end
	end
	self.Back:SetText("")
	self.Back:Text("Back")
	
	self.Forward = vgui.Create("DButton_Char", self)
	self.Forward:SetSize(150, 30)
	self.Forward:SetPos(ScrW()/2 - 25, self:GetTall()*0.83)
	self.Forward.DoClick = function()
		if (#self.Models > 0 and self.Selected < #self.Models) then
			self.Selected = self.Selected + 1
		else
			self.Selected = 1
		end
	end
	self.Forward:SetText("")
	self.Forward:Text("Next")


	-- self.skin = vgui.Create( "DButton", self )
	-- self.skin:SetSize( 64, 64 )
	-- self.skin:SetPos(self:GetWide()*0.57, self:GetTall()*0.7)
	-- self.skin.selected = false
	-- self.skin.mat = skinselect
	-- self.skin:SetText( "" )
	-- self.skin.DoClick = function( me)
	-- 	if me.mat == skinselect then
	-- 		me.mat = skinselect_h
	-- 		self:CreateSkins()
	-- 	else
	-- 		me.mat = skinselect
	-- 		self:RemoveSkins()
	-- 	end
	-- 	surface.PlaySound("UI/buttonclick.wav")
	-- end
	-- self.skin.Paint = function(me)
	-- 	surface.SetDrawColor(255, 255, 255, 255)
	-- 	surface.SetMaterial(me.mat)
	-- 	surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
	-- end
	-- self.skin.OnCursorEntered = function()
	-- 	surface.PlaySound("UI/buttonrollover.wav")
	-- end

end

function PANEL:RemoveSkins()
	if self.SkinPanel then
		self.SkinPanel:Remove()
	end
end

function PANEL:CreateSkins()
	if self.SkinPanel then self.SkinPanel:Remove() end
	
	self.SkinPanel = vgui.Create( "DPanel", self )
	self.SkinPanel:SetPos(self:GetWide()*0.6, self:GetTall()*0.3)
	self.SkinPanel:SetSize(self:GetWide()*0.15, self:GetTall()*0.05)
	self.SkinPanel.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(aboutmat_desc)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
	end
end

function PANEL:SetBGDone()
	self.inuse = true
end


function PANEL:GetTitle()
	return self.Title
end

function PANEL:SetTitle(str)
	self.Title = str
end

function PANEL:PerformLayout()
	local titlePush = 0

	if ( IsValid( self.imgIcon ) ) then

		self.imgIcon:SetPos( 5, 5 )
		self.imgIcon:SetSize( 16, 16 )
		titlePush = 16

	end
end

vgui.Register("DFrame_Char", PANEL, "DFrame")


net.Receive("SChar.OpenMenu", function()

	local icon_mat = approved
	
	local tbl = {}
	
	local dframe = vgui.Create("DFrame_Char")
	dframe:SetSize(ScrW(), ScrH())
	dframe:MakePopup()
	if SChar.Config.Create_ShowCloseButton == true then
		dframe:ShowCloseButton(true)
	else
		dframe:ShowCloseButton(false)
	end
	dframe.text = ""
	dframe.faction = {}
	dframe.textentry = nil
	dframe.faction_ = nil
	//
	local finishbut = vgui.Create("DButton_Char", dframe)
	finishbut:SetSize(150, 35)
	finishbut:Dock(RIGHT)
	finishbut:Dock(BOTTOM)
	finishbut:DockMargin(dframe:GetWide()-180, 5, 50, 25 ) 
	finishbut:SetText("")
	finishbut:DisablePerm(true)
	finishbut:Text("FINISH")
	finishbut.Think = function()
		if dframe.beenuse == true and dframe.gendersel == true and icon_mat == approved then
			finishbut:DisablePerm(false)
		else
			finishbut:DisablePerm(true)
		end
	end
	function finishbut:DoClick()
		//if textentry == nil then return end
		net.Start("SChar.ProcessCharacter")
			net.WriteString(dframe.faction_)
			net.WriteString(dframe.textentry)
			net.WriteString(dframe:ReturnModel())
		net.SendToServer()
		dframe:Remove()
	end
	
	
	local AboutPanel = vgui.Create( "DPanel", dframe )
	AboutPanel:SetPos( dframe:GetWide()*0.77, dframe:GetTall()*0.190)
	AboutPanel:SetSize( 250, 53 )
	AboutPanel.Paint = function(me)
		surface.SetMaterial(aboutmat)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
		
		draw.SimpleText('About Server', "StarHUDFontWeapon2", me:GetWide()/2-65, me:GetTall()/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	
	local AboutPanelDesc = vgui.Create( "DScrollPanel", dframe )
	AboutPanelDesc:SetPos( dframe:GetWide()*0.77, dframe:GetTall()*0.27)
	AboutPanelDesc:SetSize( 250, dframe:GetTall()*0.3 )
	AboutPanelDesc.Paint = function(me)
		surface.SetMaterial(aboutmat_desc)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
		
		//draw.DrawText(SChar.Config.AboutInfo, "StarHUDFontWeapon2", me:GetWide()/2 - 115, me:GetTall()/2 - 100, Color(255, 255, 255, 255),TEXT_ALIGN_LEFT)
	end

	local DLabel2 = AboutPanelDesc:Add( "DLabel" )
	DLabel2:SetTall(dframe:GetTall()*0.3)
	DLabel2:SetWrap(true)
	DLabel2:SetFont("StarHUDFontWeapon2")
	DLabel2:SetColor(color_white)
	DLabel2:SetText(SChar.Config.AboutInfo)
	DLabel2:Dock( TOP )
	DLabel2:DockMargin( 5, -15, 0, 5 )
	DLabel2:SetWrap(true)
	

	local gender = "";
	local FactionPanel = vgui.Create( "DPanel", dframe )
	FactionPanel:SetPos( dframe:GetWide()*0.77, dframe:GetTall()*0.60)
	FactionPanel:SetSize( 250, 53 )
	FactionPanel.Paint = function(me)
		surface.SetMaterial(aboutmat)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
		
		draw.SimpleText('About Faction', "StarHUDFontWeapon2", me:GetWide()/2-65, me:GetTall()/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	
	local FactionPanelDesc = vgui.Create( "DScrollPanel", dframe )
	FactionPanelDesc:SetPos( dframe:GetWide()*0.77, dframe:GetTall()*0.68)
	FactionPanelDesc:SetSize( 250, dframe:GetTall()*0.2)
	FactionPanelDesc.Paint = function(me)
		surface.SetMaterial(aboutmat_desc)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
		
	//	draw.DrawText(dframe.text, "StarHUDFontWeapon2", me:GetWide()/2 - 115, me:GetTall()/2 - 110, Color(255, 255, 255, 255),TEXT_ALIGN_LEFT)
	end

	local DLabel = FactionPanelDesc:Add( "DLabel" )
	DLabel:SetTall(dframe:GetTall()*0.2)
	DLabel:SetWrap(true)
	DLabel:SetFont("StarHUDFontWeapon2")
	DLabel:SetColor(color_white)
	DLabel:SetText(dframe.text)
	DLabel:Dock( TOP )
	DLabel:DockMargin( 0, -25, 0, 5 )
	
	
	local faction_name = "";
	FactionList = vgui.Create( "DScrollPanel", dframe )
	FactionList:SetPos(dframe:GetWide()*0.1 - 150 + 50,100)
	FactionList:SetSize(339+30, 282 )
	FactionList.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 100)
		surface.SetMaterial(bg_2)
		surface.DrawTexturedRect(0, 30, me:GetWide(), me:GetTall()-30)
		
		draw.SimpleText('Choose Faction', "StarHUDFontWeapon", me:GetWide()/2-80, 7, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
		draw.SimpleText(faction_name, "StarHUDFontWeapon2", me:GetWide()/2-50, me:GetTall()/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		dframe.faction_ = faction_name
	end
	
	local sc_l = scroll_left
	local sc_r = scroll_right
	
	about_f = "test"
	
	local DHorizontalScroller = vgui.Create( "DHorizontalScroller", FactionList )
	DHorizontalScroller:SetPos(5, 40)
	DHorizontalScroller:SetSize(339 + 30, 60)
	DHorizontalScroller:SetOverlap( -20 )
	function DHorizontalScroller.btnLeft:Paint(w, h)
		surface.SetMaterial(sc_l)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	
	function DHorizontalScroller.btnRight:Paint( w, h )
		surface.SetMaterial(sc_r)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	for k,v in pairs(SChar.Database.Faction) do
		local DImage = vgui.Create( "DImageButton", DHorizontalScroller )
		DImage:SetImage(v.Icon)
		DImage.info = v.About
		DImage.name = v.Name
		function DImage:DoClick()
			dframe.text = DImage.info
			DLabel:SetText(dframe.text)
			faction_name = DImage.name
			
			for k,v in pairs(tbl) do
				v:SetDisabled(false)
			end
			
			if dframe.beenuse == true then
				dframe:SetBGDone()
				dframe:StartModels(gender, faction_name)
			end
		end
	
		DHorizontalScroller:AddPanel( DImage )
	end

	
	
	GenderList = vgui.Create( "DPanelList", dframe )
	GenderList:SetPos(dframe:GetWide()*0.1 - 150 + 50,385)
	GenderList:SetSize(339+30, 282 )
	GenderList:SetSpacing( 5 )
	GenderList:EnableHorizontal( false )
	GenderList:EnableVerticalScrollbar( true )
	GenderList.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 100)
		surface.SetMaterial(bg_2)
		surface.DrawTexturedRect(0, 30, me:GetWide(), me:GetTall()-30)
		
		draw.SimpleText('Choose Gender', "StarHUDFontWeapon", me:GetWide()/2-80, 7, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
		draw.SimpleText(gender, "StarHUDFontWeapon2", me:GetWide()/2-50, me:GetTall()/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	local DHorizontalScroller_Gender = vgui.Create( "DHorizontalScroller", GenderList )
	DHorizontalScroller_Gender:SetPos(5, 50)
	DHorizontalScroller_Gender:SetSize(339 + 30, 40)
	DHorizontalScroller_Gender:SetOverlap( -20 )
	function DHorizontalScroller_Gender.btnLeft:Paint(w, h)
		surface.SetMaterial(sc_l)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	
	function DHorizontalScroller_Gender.btnRight:Paint( w, h )
		surface.SetMaterial(sc_r)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	
	
	
	for k,v in pairs(SChar.Database.Gender) do
		local DImage = vgui.Create( "DImageButton", DHorizontalScroller_Gender )
		DImage:SetImage(v.Icon)
		DImage:SetDisabled(true)
		DImage.name = v.Name
		function DImage:DoClick()
			dframe.beenuse = true
			gender = DImage.name
			dframe:SetBGDone()
			dframe:StartModels(gender, faction_name)
			dframe.gendersel = true
		end
		
		table.insert(tbl, DImage)
		
		DHorizontalScroller_Gender:AddPanel( DImage )
	end

	local TextEntry = vgui.Create( "DTextEntry", dframe )
	TextEntry:SetWide(dframe:GetWide()*0.25)
	TextEntry:SetTall(40)
	TextEntry:SetPos(dframe:GetWide()*0.36, dframe:GetTall()*0.87)
	TextEntry:SetText("" )
	TextEntry:SetFont("StarHUDFontWeapon2")
	TextEntry.Paint = function(me)
		surface.SetMaterial(textbox)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
		
		surface.SetMaterial(icon_mat)
		surface.DrawTexturedRect(me:GetWide() - 30, 13, 16, 16)

		me:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
	end
	TextEntry.Think = function(self)
		if not SChar.Action:validName(self:GetValue()) then
			icon_mat = deny
		else
			icon_mat = approved
		end
		dframe.textentry = self:GetValue()
	end
end)
