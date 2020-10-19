--[[ Nykez 2017. Do not edit ]]--

if !CLIENT then return end
--------------

local base = Material(SChar.Config.MainBackground, "noclamp smooth")
local titlemat = Material("sci_char/border/top_border_effect.png", "noclamp smooth")
local botmat = Material("sci_char/border/bottom_border_effect.png", "noclamp smooth")
local merged  = Material("sci_char/menu/merged.png", "noclamp smooth")
local panel_char  = Material("sci_char/menu/hover_highlight.png", "noclamp smooth")
local panel_char_h  = Material("sci_char/menu/selected.png", "noclamp smooth")
local char_frame = Material("sci_char/menu/character_frame.png", "noclamp smooth")
local panel_char_bg = Material("sci_char/menu/char_info_bg.png", "noclamp smooth")
local panel_char_port = Material("sci_char/menu/portrait.png", "noclamp smooth")
local background_glow = Material("sci_char/menu/name_glow.png", "noclamp smooth")
local deny = Material("sci_char/denied.png")

local aboutmat_desc = Material("sci_char/description_body.png")
local aboutmat = Material("sci_char/description_head.png")


net.Receive("SChar.OpenSpawnMenu", function()

	local tbl = net.ReadTable()

	local tblWhitelist = net.ReadTable()

	if not tblWhitelist then tblWhitelist = {} end


	local frame = vgui.Create("DFrame")
	frame:SetSize(ScrW(), ScrH())
	frame:Center()
	frame:MakePopup()
	if SChar.Config.Spawn_ShowCloseButton == true then
		frame:ShowCloseButton(true)
	else
		frame:ShowCloseButton(false)
	end
	frame:SetTitle("")
	frame.name = ""
	frame.mdl = "models/error.mdl"
	frame.selected = nil
	frame.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(base)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(titlemat)
		surface.DrawTexturedRect(0, 2, me:GetWide(), 76)

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(botmat)
		surface.DrawTexturedRect(0, ScrH()-80, me:GetWide(), 75)

		surface.SetDrawColor(255, 255, 255, 200)
		surface.SetMaterial(background_glow)
		surface.DrawTexturedRect(me:GetWide()/2 - 255, me:GetTall()/2+240, 500, 75)


		draw.DrawText(frame.name, "StarHUDFontTitle", me:GetWide()/2 - 100, me:GetTall()/2+270, Color(255, 255, 255, 255),TEXT_ALIGN_LEFT)
	end

	local icon = vgui.Create( "DModelPanel", frame )
	icon:SetPos(frame:GetWide()/2-275, frame:GetTall()/2-200)
	icon:SetSize( 500, 500 )
	icon:SetModel(frame.mdl)
	local mn, mx = icon.Entity:GetRenderBounds()
	local size = 0
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

	icon:SetFOV( 45 )
	icon:SetCamPos( Vector( size, size, size ) )
	icon:SetLookAt( ( mn + mx ) * 0.5 )
	icon:SetVisible(false)

	local panelinfo = vgui.Create("DPanel", frame)
	panelinfo:SetSize(353, frame:GetTall()*0.3)
	panelinfo:Dock(RIGHT)
	panelinfo:DockMargin(0, 50, 20, 225 )
	panelinfo.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(merged)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
	end

	local DScrollPanel = vgui.Create( "DScrollPanel", panelinfo )
	DScrollPanel:Dock( FILL )
	DScrollPanel:DockMargin(0, 67, 0, 5)

	local sel = nil;
	local deletesel = nil;

	for k,v in pairs(tbl) do
		local panel = DScrollPanel:Add("DPanel")
		panel:SetTall(79)
		panel:Dock(TOP)
		panel.Mat = panel_char
		panel:DockMargin(23, 1, 23, 3)
		panel.Paint = function(me)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(me.Mat)
			surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())

			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(panel_char_port)
			surface.DrawTexturedRect(7, 7, 59, 59)

			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(char_frame)
			surface.DrawTexturedRect(5, 5, 69, 69)

			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(panel_char_bg)
			surface.DrawTexturedRect(75, 12, 223, 59)

			draw.DrawText(v.Name, "StarHUDFontWeapon2", 80, 20, Color(255, 255, 255, 255),TEXT_ALIGN_LEFT)

			draw.DrawText(v.Faction, "StarHUDFontWeapon3", 80, 55, Color(149, 165, 166, 255),TEXT_ALIGN_LEFT)

			draw.DrawText(team.GetName(v.Team), "StarHUDFontWeapon3", 250, 55, Color(149, 165, 166, 255),TEXT_ALIGN_CENTER)
		end
		panel.OnMouseReleased = function(me)
			if sel then
				sel.Mat = panel_char
			end
			sel = me
			if me.Mat == panel_char then
				me.Mat = panel_char_h
			else
				me.Mat = panel_char
			end
			surface.PlaySound("UI/buttonclick.wav")
			frame.selected = v
			icon:SetModel(v.Model)
			icon:SetVisible(true)
			frame.name = v.Name
			frame.index = k
			deletesel = panel
			createButton()
			setChar(k)
		end

		panel.OnCursorEntered = function()
			surface.PlaySound("UI/buttonrollover.wav")
		end
	end

	DeployButton = vgui.Create("DButton_Char", panelinfo)
	DeployButton:SetSize(150, 30)
	DeployButton:Dock(BOTTOM)
	DeployButton:DockMargin(180, 5, 15, 20)
	DeployButton.DoClick = function() end
	DeployButton:SetText("")
	DeployButton:Text("Deploy")
	DeployButton.DoClick = function()
		local data = frame.selected
		if not data then return end
		net.Start("SChar.Deploy")
			net.WriteString(data['Name'])
			net.WriteString(data["Model"])
			net.WriteInt(data["Team"], 32)
		net.SendToServer()
		frame:Close()
	end

	LeaveButton = vgui.Create("DButton_Char", panelinfo)
	LeaveButton:SetSize(150, 30)
	LeaveButton:Dock(BOTTOM)
	LeaveButton:DockMargin(15, 5, 180, -35)
	LeaveButton.DoClick = function() end
	LeaveButton:SetText("")
	LeaveButton:Text("Delete")
	LeaveButton.DoClick = function()
		if not deletesel then return end
		if not frame.index then return end
		deletesel:Remove()
		if frame.selected then
			frame.selected = nil
		end
		sel = nil
		net.Start("SChar.Delete")
			net.WriteInt(frame.index, 32)
		net.SendToServer()
		icon:SetVisible(false)
		frame.name = ""
	end


	local OptionsPanel = vgui.Create( "DScrollPanel", frame )
	OptionsPanel:SetPos(frame:GetWide()*0.010, frame:GetTall()*0.07)//
	OptionsPanel:SetSize( 250, frame:GetTall()*0.17 )
	OptionsPanel.Paint = function(me)
		surface.SetDrawColor(32, 32, 32, 200)
		surface.DrawRect(0, 0, me:GetWide(), me:GetTall())
	end

	local iscreated = false
	local myChar;

	function setChar(char)
		myChar = char
	end

	function getChar()
		return myChar
	end

	function createButton()
		if !SChar.BlogsWhitelist then return end
		if iscreated then return end
		iscreated = true

		OptionsPanel:SetSize( 250, frame:GetTall()*0.20 )
		local btn_changeteam = OptionsPanel:Add( "DButton" )
		btn_changeteam:SetTall(25)
		btn_changeteam:SetText("Change Team (Selected)")
		btn_changeteam:Dock( TOP )
		btn_changeteam:DockMargin( 10, 5, 10, 5 )
		btn_changeteam:SetFont("StarHUDFontWeapon2")
		btn_changeteam:SetColor(color_white)
		btn_changeteam.alpha = 255
		btn_changeteam.rollover = false
		btn_changeteam.Paint = function(me)
	   		surface.SetDrawColor( 68, 87, 101, me.alpha )
	    	surface.DrawRect( 0, 0, me:GetWide(), me:GetTall() )

	    	if me.rollover == true then
	    		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall() )
			end
		end
		btn_changeteam.OnCursorEntered = function(me)
			me.Alpha = 155
			surface.PlaySound("UI/buttonrollover.wav")
			me.rollover = true
		end
		btn_changeteam.OnCursorExited = function(me)
			me.Alpha = 255
			me.rollover = false
		end
		btn_changeteam.DoClick = function(self)
			createTeamChange(btn_changeteam)
		end
	end

	function createTeamChange()
		if not SChar.BlogsWhitelist then return end
		if pnl_change_team then pnl_change_team:Remove() end

		pnl_change_team = vgui.Create( "DFrame", frame)
		pnl_change_team:SetPos( frame:GetWide() * 0.2, frame:GetTall() * 0.1 )
		pnl_change_team:SetSize(frame:GetWide() * 0.2, frame:GetTall() * 0.4 )
		pnl_change_team:SetTitle( "" )
		pnl_change_team:SetDraggable( true )
		pnl_change_team:MakePopup()
		pnl_change_team:ShowCloseButton(false)
		pnl_change_team.Paint = function(me)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(merged)
			surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
		end

		local DScrollPanel = vgui.Create( "DScrollPanel", pnl_change_team )
		DScrollPanel:Dock( FILL )
		DScrollPanel:DockMargin(0, 15, 0, 0)

		local selectedteam;
		local selectedteannum;
		for k, v in pairs(tblWhitelist) do
			local job_btn = DScrollPanel:Add( "DButton" )
			job_btn:SetText(RPExtraTeams[v].name)
			job_btn:SetTextColor(color_white)
			job_btn:SetFont("StarHUDFontWeapon2")
			job_btn:Dock( TOP )
			job_btn.alpha = 255
			job_btn.index = v
			job_btn.rollover = false
			job_btn:DockMargin( 15, 0, 15, 5 )
			job_btn.Paint = function(me)
		   		surface.SetDrawColor( 68, 87, 101, me.alpha )
		    	surface.DrawRect( 0, 0, me:GetWide(), me:GetTall() )

		    	if me.rollover == true and selectedteam != me then
		    		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
					surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall() )
				end

				if selectedteam == me then
					surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
					surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall() )
				end
			end

			job_btn.OnCursorEntered = function(me)
				me.Alpha = 155
				surface.PlaySound("UI/buttonrollover.wav")
				me.rollover = true
			end
			job_btn.OnCursorExited = function(me)
				me.Alpha = 255
				me.rollover = false
			end
			job_btn.DoClick = function(self)
				selectedteam = self
				selectedteamnum = self.index
			end
		end

		teamBtn = vgui.Create("DButton_Char", pnl_change_team)
		teamBtn:SetTall(30)
		teamBtn:Dock(BOTTOM)
		teamBtn:Text("")
		teamBtn:SetText("Change Team")
		teamBtn:DockMargin(45, 0, 45, 5)
		teamBtn:SetFont('StarHUDFontWeapon2')
		teamBtn:SetTextColor(color_white)
		teamBtn.DoClick = function()
			if selectedteamnum then 
				MsgN("sent")
				net.Start("SChar.ChangeTeam")
					net.WriteInt(selectedteamnum, 16)
					net.WriteInt(getChar(), 16)
				net.SendToServer()
				frame:Close()
			end
		end

		//
		exitBtn = vgui.Create("DButton_Char", pnl_change_team)
		exitBtn:SetText("")
		exitBtn:SetSize(24, 24)
		exitBtn:SetPos(frame:GetWide() * 0.18, frame:GetTall() * 0.01)
		exitBtn.Paint = function(me)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(deny)
			surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
		end
		function exitBtn:DoClick() 
			pnl_change_team:Remove()
		end
	


	end

	local btn_disconnect = OptionsPanel:Add( "DButton" )
	btn_disconnect:SetTall(25)
	btn_disconnect:SetText("Create Character")
	btn_disconnect:Dock( TOP )
	btn_disconnect:DockMargin( 10, 5, 10, 5 )
	btn_disconnect:SetFont("StarHUDFontWeapon2")
	btn_disconnect:SetColor(color_white)
	btn_disconnect.alpha = 255
	btn_disconnect.rollover = false
	btn_disconnect.Paint = function(me)
   		surface.SetDrawColor( 68, 87, 101, me.alpha )
    	surface.DrawRect( 0, 0, me:GetWide(), me:GetTall() )

    	if me.rollover == true then
    		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall() )
		end
	end
	btn_disconnect.OnCursorEntered = function(me)
		me.Alpha = 155
		surface.PlaySound("UI/buttonrollover.wav")
		me.rollover = true
	end
	btn_disconnect.OnCursorExited = function(me)
		me.Alpha = 255
		me.rollover = false
	end
	btn_disconnect.DoClick = function(self)
		frame:Close()
		net.Start("SChar.CreateNew")
		net.SendToServer()
	end
	

	local btn_disconnect2 = OptionsPanel:Add( "DButton" )
	btn_disconnect2:SetTall(25)
	btn_disconnect2:SetText("Disconnect")
	btn_disconnect2:Dock( TOP )
	btn_disconnect2:DockMargin( 10, 5, 10, 5 )
	btn_disconnect2:SetFont("StarHUDFontWeapon2")
	btn_disconnect2:SetColor(color_white)
	btn_disconnect2.alpha = 255
	btn_disconnect2.rollover = false
	btn_disconnect2.Paint = function(me)
   		surface.SetDrawColor( 68, 87, 101, me.alpha )
    	surface.DrawRect( 0, 0, me:GetWide(), me:GetTall() )

    	if me.rollover == true then
    		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall() )
		end
	end
	btn_disconnect2.OnCursorEntered = function(me)
		me.Alpha = 155
		surface.PlaySound("UI/buttonrollover.wav")
		me.rollover = true
	end
	btn_disconnect2.OnCursorExited = function(me)
		me.Alpha = 255
		me.rollover = false
	end
	btn_disconnect2.DoClick = function(self)
		net.Start("SChar.Quit")
		net.SendToServer()
	end

	if SChar.Config.btn_forums.Enabled == true then

		local btn_disconnect3 = OptionsPanel:Add( "DButton" )
		btn_disconnect3:SetTall(25)
		btn_disconnect3:SetText(SChar.Config.btn_forums.Text)
		btn_disconnect3:Dock( TOP )
		btn_disconnect3:DockMargin( 10, 5, 10, 5 )
		btn_disconnect3:SetFont("StarHUDFontWeapon2")
		btn_disconnect3:SetColor(color_white)
		btn_disconnect3.alpha = 255
		btn_disconnect3.link = SChar.Config.btn_forums.link
		btn_disconnect3.rollover = false
		btn_disconnect3.Paint = function(me)
	   		surface.SetDrawColor( 68, 87, 101, me.alpha )
	    	surface.DrawRect( 0, 0, me:GetWide(), me:GetTall() )

	    	if me.rollover == true then
	    		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall() )
			end
		end
		btn_disconnect3.OnCursorEntered = function(me)
			me.Alpha = 155
			surface.PlaySound("UI/buttonrollover.wav")
			me.rollover = true
		end
		btn_disconnect3.OnCursorExited = function(me)
			me.Alpha = 255
			me.rollover = false
		end
		btn_disconnect3.DoClick = function(self)
			gui.OpenURL(self.link)
		end
	end

	if SChar.Config.btn_content.Enabled == true then
		local btn_disconnect4 = OptionsPanel:Add( "DButton" )
		btn_disconnect4:SetTall(25)
		btn_disconnect4:SetText(SChar.Config.btn_content.Text)
		btn_disconnect4:Dock( TOP )
		btn_disconnect4:DockMargin( 10, 5, 10, 5 )
		btn_disconnect4:SetFont("StarHUDFontWeapon2")
		btn_disconnect4:SetColor(color_white)
		btn_disconnect4.alpha = 255
		btn_disconnect4.link = SChar.Config.btn_content.link
		btn_disconnect4.rollover = false
		btn_disconnect4.Paint = function(me)
	   		surface.SetDrawColor( 68, 87, 101, me.alpha )
	    	surface.DrawRect( 0, 0, me:GetWide(), me:GetTall() )

	    	if me.rollover == true then
	    		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall() )
			end
		end
		btn_disconnect4.OnCursorEntered = function(me)
			me.Alpha = 155
			surface.PlaySound("UI/buttonrollover.wav")
			me.rollover = true
		end
		btn_disconnect4.OnCursorExited = function(me)
			me.Alpha = 255
			me.rollover = false
		end
		btn_disconnect4.DoClick = function(self)
			gui.OpenURL(self.link)
		end
	end

end)