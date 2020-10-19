SK_TREE.Active_Menu = SK_TREE.Active_Menu or nil

sk_tree_textures = sk_tree_textures or nil
sk_tree_textures_bg = sk_tree_textures_bg or nil
sk_tree_textures_grad = sk_tree_textures_grad or surface.GetTextureID( "gui/center_gradient" )

function draw.sk_gradient( x, y, col, sx, sy )
	surface.SetDrawColor( col )
	surface.SetTexture( sk_tree_textures_grad )
	surface.DrawTexturedRectUV( sx or 0, sy or 0, x, y, 0, 0, 1, 1 )
end

hook.Add( "InitPostEntity", "SK_TREE_MATERIALS", function()
	SK_TREE.LoadImageFromURL( SK_TREE.MENU.SPRITE_SHEET, function() return ( sk_tree_textures and sk_tree_textures:Width() > 512 ) end, function( material ) sk_tree_textures = material end )
	
	local image = SK_TREE.MENU.SPRITE_BG_DEFAULT
	if ( SK_TREE.MENU.THEME ) then image = SK_TREE.MENU.SPRITE_BG_PNG end
	SK_TREE.LoadImageFromURL( image, function() return ( sk_tree_textures_bg and sk_tree_textures_bg:Width() > 512 ) end, function( material ) sk_tree_textures_bg = material end )
	
	timer.Create( "SK_TREE_VERIFYSIZE", 1, 0, function()
		local valid = true
	
		if ( sk_tree_textures and sk_tree_textures:Width() <= 512 ) then
			SK_TREE.LoadImageFromURL( SK_TREE.MENU.SPRITE_SHEET, function() return ( sk_tree_textures and sk_tree_textures:Width() > 512 ) end, function( material ) sk_tree_textures = material end )
			
			valid = false
		end
		
		if ( sk_tree_textures_bg and sk_tree_textures_bg:Width() <= 512 ) then
			SK_TREE.LoadImageFromURL( image, function() return ( sk_tree_textures_bg and sk_tree_textures_bg:Width() > 512 ) end, function( material ) sk_tree_textures_bg = material end )
			
			valid = false
		end
		
		if ( !sk_tree_textures or !sk_tree_textures_bg ) then valid = false end
		if ( valid ) then timer.Destroy( "SK_TREE_VERIFYSIZE" ) end
	end )
end )

function SK_TREE.LoadImageFromURL( url, valid, callback )
	if valid() == true then return end

	local HtmlPanel = vgui.Create( "DHTML" )
	HtmlPanel:Dock( FILL )
	HtmlPanel:SetAlpha( 0 )
	HtmlPanel:SetMouseInputEnabled( false )
	HtmlPanel.ConsoleMessage = function( msg ) end
	
	HtmlPanel:OpenURL( url )
	
	HtmlPanel.Think = function()	
		local sprite_sheet_material = HtmlPanel:GetHTMLMaterial()
		
		if !( sprite_sheet_material ) then return end
		
		local sprite_sheet_props = {
			["$basetexture"] = sprite_sheet_material:GetName(),
			["$basetexturetransform"] = "center 0 0 scale 1 1 rotate 0 translate 0 0",
			["$translucent"] = 1
		}
		
		local mt_name = "WebMaterial_SK_TREE_" .. tostring( math.random( 1, 100000 ) )
		local mt = CreateMaterial( mt_name, "UnlitGeneric", sprite_sheet_props )
		callback( mt )

		//print( mt_name, mt:Width(), mt:Height() )
		
		HtmlPanel:Remove()
	end
end

surface.CreateFont( "SK_TREET_TEXT_01", {
	font = "Tahoma",
	size = 16,
	weight = 1000
} )

surface.CreateFont( "SK_TREET_TEXT_02", {
	font = "Tahoma",
	size = 8,
	weight = 1000
} )

surface.CreateFont( "SK_TREET_TEXT_03", {
	font = "Tahoma",
	size = 12,
	weight = 1000
} )

surface.CreateFont( "SK_TREET_TEXT_Title", {
	font = "Tahoma",
	size = 24,
	weight = 500
} )

local sk_tree_exits = {
	{ { 32, 10 }, { 31, 10 } },
	{ { 53, 32 }, { 53, 31 } },
	{ { 32, 53 }, { 31, 53 } },
	{ { 10, 32 }, { 10, 31 } }
}

local PANEL = {}
function PANEL:Init()
	self.Think = function()
		if ( self.drag_think == true ) then	
			local currentpos = { gui.MouseX(), gui.MouseY() }
			local DiffX = currentpos[1] - self.drag_start[1]
			local DiffY = currentpos[2] - self.drag_start[2]
			local Diff = { DiffX, DiffY }

			local newx, newy = self.drag_offset.x + Diff[1], self.drag_offset.y + Diff[2]
			
			local gx, gy = self:LocalToScreen()
			local px, py = self.stat_tree:LocalToScreen()
			
			if ( currentpos[1] < px or currentpos[2] < py or currentpos[1] > ( px + self.stat_tree:GetWide() ) or currentpos[2] > ( py + self.stat_tree:GetTall() ) ) then
				self.drag_think = false
				return
			end
			
			self.stat_tree.stats:SetPos( newx, newy )
		end
	end
	
	timer.Simple( 0, function()
		self:SetTitle( " " )
	
		local x, y = self:GetWide(), self:GetTall()
		local xp, yp = self:GetPos()
		self.stat_info = vgui.Create( "RichText", self )
		self.stat_info:SetPos( 301 - ( x / 3 - 10 ) - 9, 129 )
		self.stat_info:SetSize( x / 3 - 10, y / 2.2 - 50 )
		self.stat_info.Paint = function( pnl, x, y )

		end
		
		local stat_info_x, stat_info_y = self.stat_info:GetPos()
		local stat_info_w, stat_info_h = self.stat_info:GetWide(), self.stat_info:GetTall()
		
		self.stat_buy = vgui.Create( "DButton", self )
		self.stat_buy:SetPos( stat_info_x, y - 74 - 50)//stat_info_y + stat_info_h + 5 )
		self.stat_buy:SetSize( stat_info_w, 50 )
		self.stat_buy:SetText( " " )
		self.stat_buy:NoClipping( true )
		
		self.stat_buy.Paint = function( pnl, x, y )
			local col_back, col_text = Color( 0, 0, 0, 175 ), Color( 200, 200, 200, 255 )
			
			if ( self.stat_buy.hover == true ) then col_back = Color( 0, 0, 0, 125 ) col_text = Color( 255, 255, 255, 255 ) end
		
			draw.sk_gradient( x, y, col_back )
			
			local queue_draw = {}
			
			if ( !SK_TREE.SkillOwned( self.active_skill[1] ) ) then
				if ( self.active_skill[2].req_level ) then
					local req_col = Color( 255, 50, 50, 255 )
					if ( SK_TREE.SK_TREE_VAR.SKILL_POINTS.LEVEL >= self.active_skill[2].req_level ) then req_col = Color( 50, 255, 50, 255 ) end
					
					table.insert( queue_draw, { "Required Level: " .. tostring( self.active_skill[2].req_level ), req_col } )
				end
				
				if ( self.active_skill[2].req_stat ) then
					local req_col = Color( 255, 50, 50, 255 )
					if ( SK_TREE.SkillOwned( self.active_skill[2].req_stat ) ) then req_col = Color( 50, 255, 50, 255 ) end
					if ( SK_TREE.SK_TREE_VAR.SKILL_STATS[self.active_skill[2].req_stat] and SK_TREE.SK_TREE_VAR.SKILL_STATS[self.active_skill[2].req_stat] < SK_TREE.SKILLS[self.active_skill[2].req_stat].levels ) then req_col = Color( 255, 50, 50, 255 ) end
					
					table.insert( queue_draw, { "Required Skill: " .. tostring( SK_TREE.SKILLS[self.active_skill[2].req_stat].name ), req_col } )
				end
				
				if ( self.active_skill[2].req_usergroup ) then
					local req_col = Color( 255, 50, 50, 255 )
					if ( table.HasValue( self.active_skill[2].req_usergroup, LocalPlayer():GetUserGroup() ) ) then req_col = Color( 50, 255, 50, 255 ) end
					
					local groups = table.concat( self.active_skill[2].req_usergroup, ", " )
					
					table.insert( queue_draw, { "Required Group/s: " .. groups, req_col } )
				end
			end
			
			for i = 1, #queue_draw do
				draw.SimpleText( queue_draw[i][1], "SK_TREET_TEXT_03", 0, -12 * i, queue_draw[i][2] )
			end
			
			
			draw.SimpleText( "Purchase", "SK_TREET_TEXT_Title", x / 2, y / 2, col_text, 1, 1 )
		end
		
			self.stat_buy.DoClick = function()
				if ( self.selected and self.selected.skill ) then
					net.Start( "SK_TREE_BUY" )
						net.WriteString( self.selected.skill )
					net.SendToServer()
				end
			end
		
		self.stat_buy.OnCursorEntered = function() self.stat_buy.hover = true end		
		self.stat_buy.OnCursorExited = function() self.stat_buy.hover = false end
	
		self.stat_tree = vgui.Create( "DPanel", self )
		self.stat_tree:SetSize( 401, 352 )
		self.stat_tree:SetPos( 301, 74 )
		
		self.stat_tree.Paint = function( pnl, x, y )
			draw.RoundedBox( 0, 0, 0, x, y, Color( 0, 0, 0, 175 ) )
		end
		
		function self.stat_tree:OnMousePressed( num )
			self.stats.OnMousePressed( num )
		end
				
		function self.stat_tree:OnMouseReleased( num )
			self.stats.OnMouseReleased( num )
		end
		
		local x2, y2 = self.stat_tree:GetWide(), self.stat_tree:GetTall()
		
		self.stat_tree.stats = vgui.Create( "DPanel", self.stat_tree )
		self.stat_tree.stats:SetSize( x2 * 2, y2 * 2 )
		self.stat_tree.stats:SetPos( -x2 / 2, -y2 / 2 )
		
		self.stat_tree.stats.OnMousePressed = function( num )
			local x, y = self.stat_tree.stats:GetPos()
			self.drag_offset = { x = x, y = y }
			
			self.drag_think = true
			self.drag_start = { gui.MouseX(), gui.MouseY() }
		end
		
		self.stat_tree.stats.OnMouseReleased = function( num )
			self.drag_think = false
		end
		
		self.stat_tree.stats.Paint = function() 
			for k, sk in pairs( self.stat_tree.stats.skills ) do
				local sides = sk.sides
				
				if !sides then continue end
				
				local skill_data = SK_TREE.SKILLS[sk:GetSkill()]
				local skill_pos_x, skill_pos_y = sk:GetPos()
					
				local skill_req = skill_data.req_stat

				if ( !skill_req ) then continue end

				local reqskill_pos_x, reqskill_pos_y = nil, nil
				
				for _, sk_2 in pairs( self.stat_tree.stats.skills ) do
					if ( sk_2:GetSkill() == skill_req ) then
						reqskill_pos_x, reqskill_pos_y = sk_2:GetPos()
						break
					end
				end
			
				if ( SK_TREE.SkillOwned( sk:GetSkill() ) ) then
					surface.SetDrawColor( Color( 150, 255, 150, 255 ) )
				elseif ( SK_TREE.SkillLocked( sk:GetSkill() ) ) then
					surface.SetDrawColor( Color( 255, 210, 120, 50 ) )
				else
					surface.SetDrawColor( Color( 255, 210, 120, 255 ) )
				end
				
				surface.DrawLine( reqskill_pos_x + sk_tree_exits[sides[1]][1][1], reqskill_pos_y + sk_tree_exits[sides[1]][1][2], skill_pos_x + sk_tree_exits[sides[2]][1][1], skill_pos_y + sk_tree_exits[sides[2]][1][2] )
				surface.DrawLine( reqskill_pos_x + sk_tree_exits[sides[1]][2][1], reqskill_pos_y + sk_tree_exits[sides[1]][2][2], skill_pos_x + sk_tree_exits[sides[2]][2][1], skill_pos_y + sk_tree_exits[sides[2]][2][2] )
			end
		end
		
		self:PopulateSkills()
		
		self.exit = vgui.Create( "DButton" )
		self.exit:SetSize( 10, 10 )
		self.exit:SetPos( xp + x - 10, yp - 11 )
		self.exit:SetText( " " )
		self.exit.Paint = function( pnl, x, y )
			local col = Color( 255, 100, 100, 255 )
		
			if ( self.hover == true ) then
				col = Color( 255, 150, 150, 255 )
			end
		
			draw.SimpleText( "X", "SK_TREET_TEXT_01", x/2, y/2, col, 1, 1 )
		end
		self.exit.DoClick = function() self.exit:Remove() self:Close() end
		self.exit.OnCursorEntered = function() self.hover = true end
		self.exit.OnCursorExited = function() self.hover = false end
	end )
end

function PANEL:PopulateSkills()
		local skills = {}
		
		local x3, y3 = self.stat_tree.stats:GetWide(), self.stat_tree.stats:GetTall()
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 32, y3 / 2 - 32 )
		skill:SetSkill( "medic_training" )
		table.insert( skills, skill )
		
		self:SetActiveSkill( "medic_training" )
		self:SetSelectedSkill( skill )

		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 32, y3 / 2 - 96 )
		skill:SetSkill( "medic_doctor" )
		skill.sides = { 1, 3 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 96, y3 / 2 - 96 )
		skill:SetSkill( "heal_aoe" )
		skill.sides = { 4, 2 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 32, y3 / 2 - 160 )
		skill:SetSkill( "good_fortune" )
		skill.sides = { 1, 3 }
		table.insert( skills, skill )
		
		--[[local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 96, y3 / 2 - 32 )		
		skill:SetSkill( "thief_training" )
		table.insert( skills, skill )

		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 160, y3 / 2 - 32 )		
		skill:SetSkill( "thief_run" )
		skill.sides = { 4, 2 }
		table.insert( skills, skill )		
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 160, y3 / 2 + 32 )		
		skill:SetSkill( "thief_smart" )
		skill.sides = { 3, 1 }
		table.insert( skills, skill )		
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 96, y3 / 2 + 32 )		
		skill:SetSkill( "basic_electronics" )
		skill.sides = { 3, 1 }
		table.insert( skills, skill )

		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 32, y3 / 2 + 32 )		
		skill:SetSkill( "advanced_electronics" )
		skill.sides = { 2, 4 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 96, y3 / 2 + 96 )		
		skill:SetSkill( "printer_lessons" )
		skill.sides = { 3, 1 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 32, y3 / 2 + 96 )		
		skill:SetSkill( "printer_upgrade_extra" )
		skill.sides = { 2, 4 }
		table.insert( skills, skill )
	
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 - 160, y3 / 2 + 96 )		
		skill:SetSkill( "printer_upgrade_armour" )
		skill.sides = { 4, 2 }
		table.insert( skills, skill )
		]]
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 + 32, y3 / 2 - 32 )	
		skill:SetSkill( "athletic_training" )	
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 + 32, y3 / 2 - 96 )	
		skill:SetSkill( "jump_training" )
		skill.sides = { 1, 3 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 + 96, y3 / 2 - 96 )	
		skill:SetSkill( "bullet_dodge" )
		skill.sides = { 2, 4 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 + 32, y3 / 2 + 32 )	
		skill:SetSkill( "health_boost" )	
		skill.sides = { 3, 1 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 + 96, y3 / 2 + 32 )	
		skill:SetSkill( "armour_boost" )	
		skill.sides = { 2, 4 }
		table.insert( skills, skill )
		
		local skill = vgui.Create( "SK_TREE_MENU_SKILL", self.stat_tree.stats )
		skill:SetPos( x3 / 2 + 96, y3 / 2 - 32 )	
		skill:SetSkill( "bullet_boost" )	
		skill.sides = { 1, 3 }
		table.insert( skills, skill )
		
		self.stat_tree.stats.skills = skills
end

function PANEL:SetActiveSkill( skill )
	self.active_skill = { skill, SK_TREE.SKILLS[skill] }
	self.stat_info:SetText( self.active_skill[2].desc )
end

function PANEL:SetSelectedSkill( pnl )
	if ( self.selected ) then self.selected.selected = false end
	
	self.selected = pnl
	pnl.selected = true
end

function PANEL:Paint( x, y )
	draw.RoundedBox( 0, 0, 0, x, y, SK_TREE.MENU.THEME or Color( 0, 0, 0, 0 ) )

	if ( sk_tree_textures_bg ) then
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.SetMaterial( sk_tree_textures_bg )
		
		local condx, condy = sk_tree_textures_bg:Width(), sk_tree_textures_bg:Height()
		local xuvend, yuvend = 768 / 2048, 500 / 512
		if ( condx <= 512 ) then
			xuvend, yuvend = 1.2, 500 / 512
		else
			xuvend, yuvend = 768 / condx, 500 / condy
		end
		
		surface.DrawTexturedRectUV( 0, 0, x, y, 0, 0, xuvend, yuvend )
	end
	
	if ( self.stat_info ) then
		local six, siy = self.stat_info:GetPos()
		local siw, sit = self.stat_info:GetWide(), self.stat_info:GetTall()

		local x, y, w, h = six, siy - 55, siw, 50
		draw.sk_gradient( w, h, Color( 0, 0, 0, 175 ), x,  y )
		draw.SimpleText( self.active_skill[2] and self.active_skill[2].name or "Select an Upgrade", "SK_TREET_TEXT_Title", x + w / 2, y + h / 2, Color( 255, 255, 255, 255 ), 1, 1 )
	end
	
	surface.SetDrawColor( Color( 0, 0, 0, 50 ) )
	surface.DrawOutlinedRect( 0, 0, x, y )
end

vgui.Register( "SK_TREE_MENU", PANEL, "DFrame" )

local PANEL = {}
function PANEL:Init()
	timer.Simple( 0, function() self:SetSize( 64, 64 ) end )
end

function PANEL:Paint( x, y )	
	if ( self.mat_pos and sk_tree_textures ) then
		local condx, condy = sk_tree_textures:Width(), sk_tree_textures:Height()
		local xuvend, yuvend = 768 / 2048, 500 / 512
		if ( condx <= 512 ) then
			xuvend, yuvend = 1.2, 500 / 512
		else
			xuvend, yuvend = 768 / condx, 500 / condy
		end
	
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.SetMaterial( sk_tree_textures )
		
		local h = math.ceil( self.mat_pos / 16 ) - 1
		
		local x = self.mat_pos - ( h * 16 ) - 1

		surface.DrawTexturedRectUV( 16, 16, 32, 32, 64 * ( x ) / condx, h * 64 / condy, ( ( 64 * ( x ) ) + 64 ) / condx, ( 64 + h * 64 ) / condy )
	end
	
	local hover_colour = Color( 255, 210, 120, 255 )
	
	if ( self.selected == true ) then
		hover_colour = Color( 255, 135, 0, 255 )
	elseif ( SK_TREE.SkillOwned( self.skill ) ) then
		hover_colour = Color( 50, 255, 50, 255 )
	end
	
	if ( SK_TREE.SkillLocked( self.skill ) ) then
		hover_colour = Color( 255, 210, 120, 50 )
	end
	
	if ( self.hover ) then
		hover_colour = Color( 255, 135, 0, 255 )
	end
	
	local hover_colour_sec = hover_colour
	hover_colour_sec.r = hover_colour_sec.r + 50 hover_colour_sec.g = hover_colour_sec.g + 50 hover_colour_sec.b = hover_colour_sec.b + 50
	
	draw.RoundedBox( 0, 13, 10, 7, 3, hover_colour )
		draw.RoundedBox( 0, 20, 11, 5, 1, hover_colour_sec )
	draw.RoundedBox( 0, 10, 10, 3, 10, hover_colour )
		draw.RoundedBox( 0, 11, 20, 1, 5, hover_colour_sec )
		
	draw.RoundedBox( 0, 51, 10, 3, 10, hover_colour )
		draw.RoundedBox( 0, 52, 20, 1, 5, hover_colour_sec )
	draw.RoundedBox( 0, 44, 10, 7, 3, hover_colour )
		draw.RoundedBox( 0, 39, 11, 5, 1, hover_colour_sec )
		
	draw.RoundedBox( 0, 10, 51, 10, 3, hover_colour )
		draw.RoundedBox( 0, 20, 52, 5, 1, hover_colour_sec )
	draw.RoundedBox( 0, 10, 44, 3, 7, hover_colour )
		draw.RoundedBox( 0, 11, 39, 1, 5, hover_colour_sec )
		
	draw.RoundedBox( 0, 51, 44, 3, 10, hover_colour )
		draw.RoundedBox( 0, 52, 39, 1, 5, hover_colour_sec )
	draw.RoundedBox( 0, 44, 51, 7, 3, hover_colour )
		draw.RoundedBox( 0, 39, 52, 5, 1, hover_colour_sec )
		
	local skill_data = SK_TREE.SKILLS[self.skill]
		
	local stat_level = SK_TREE.SK_TREE_VAR and SK_TREE.SK_TREE_VAR.SKILL_STATS and SK_TREE.SK_TREE_VAR.SKILL_STATS[self.skill] or 0
	local stat_saturated = skill_data.levels == 1 and stat_level >= skill_data.levels
	
	if !( stat_saturated ) then
		draw.SimpleText( tostring( stat_level ) .. "/" .. tostring( skill_data.levels ), "SK_TREET_TEXT_02", 14, 13, hover_colour )
	end
end

function PANEL:OnCursorEntered()
	surface.PlaySound( "garrysmod/ui_hover.wav" )
	self.hover = true
	self:GetParent():GetParent():GetParent():SetActiveSkill( self.skill )
end

function PANEL:OnCursorExited()
	self.hover = false
	local parent = self:GetParent():GetParent():GetParent()
	
	parent:SetActiveSkill( ( parent.selected and parent.selected.skill ) or self.skill )
end

function PANEL:OnMousePressed( num )
	surface.PlaySound( "garrysmod/ui_click.wav" )
	self:GetParent().OnMousePressed( num )
	self:GetParent():GetParent():GetParent():SetSelectedSkill( self )
end
		
function PANEL:OnMouseReleased( num )
	self:GetParent().OnMouseReleased( num )
end

function PANEL:SetSkill( ID )
	self.skill = ID
	self.mat_pos = ( SK_TREE.SKILLS[ID] and SK_TREE.SKILLS[ID].mat_pos ) or nil
end

function PANEL:GetSkill()
	return self.skill
end

vgui.Register( "SK_TREE_MENU_SKILL", PANEL, "DPanel" )

local PANEL = {}

function PANEL:Init()
	self:SetTitle( "Skill Tree - Admin" )
end

function PANEL:Paint( x, y )
	draw.RoundedBox( 4, 0, 0, x, y, Color( 0, 110, 215, 255 ) )
	draw.RoundedBox( 4, 1, 0, x - 2, y - 1, Color( 51, 80, 100, 255 ) )
	draw.RoundedBoxEx( 4, 0, 0, x, 26, Color( 0, 110, 215, 255 ), true, true )
	draw.RoundedBox( 4, 0, 0, x, 25, Color( 0, 140, 255, 255 ) )
	draw.RoundedBoxEx( 4, 0, 0, x, 25 / 6, Color( 0, 130, 245, 245 ), true, true )
	
	self.content = vgui.Create( "DPanel", self )
	self.content:SetSize( self:GetWide() - 6, self:GetTall() - 31 )
	self.content:SetPos( 3, 28 )
	
	self:Populate()
end

function PANEL:Populate( ... )
	local args = { ... }
	
	net.Start( "SK_TREE_SQREQUEST" )
		net.WriteString( LocalPlayer():GetUserGroup() )
		net.WriteInt( 1, 3 )	
		net.WriteTable( { args[1] } )
	net.SendToServer()
end

net.Receive( "SK_TREE_SQREQUEST", function( len )
	local test = net.ReadTable()
	
	PrintTable( test )
end )

vgui.Register( "SK_TREE_ADMIN", PANEL, "DFrame" )

concommand.Add( "sk_a", function()
	SK_TREE.Active_Menu = vgui.Create( "SK_TREE_ADMIN" )
	SK_TREE.Active_Menu:SetSize( 350, 500 )
	SK_TREE.Active_Menu:Center()
	SK_TREE.Active_Menu:MakePopup()
end )

concommand.Add( "sk_tree_menu", function()
	//sk_tree_textures = nil
	SK_TREE.LoadImageFromURL( SK_TREE.MENU.SPRITE_SHEET, function() return ( sk_tree_textures and sk_tree_textures:Width() > 512 ) end, function( material ) sk_tree_textures = material end )
	
	//sk_tree_textures_bg = nil
	local image = SK_TREE.MENU.SPRITE_BG_DEFAULT
	if ( SK_TREE.MENU.THEME ) then image = SK_TREE.MENU.SPRITE_BG_PNG end
	SK_TREE.LoadImageFromURL( image, function() return ( sk_tree_textures_bg and sk_tree_textures_bg:Width() > 512 ) end, function( material ) sk_tree_textures_bg = material end )
	
	SK_TREE.Active_Menu = vgui.Create( "SK_TREE_MENU" )
	SK_TREE.Active_Menu:SetSize( 768, 500 )
	SK_TREE.Active_Menu:Center()
	SK_TREE.Active_Menu:MakePopup()
	SK_TREE.Active_Menu:ShowCloseButton( false )
end )

local sk_menu_delay_nx = 0
hook.Add( "Think", "SK_TREE_BIND", function()
	if ( SK_TREE.BIND and input.IsKeyDown( SK_TREE.BIND ) and sk_menu_delay_nx <= CurTime() ) then
		if ( !SK_TREE.Active_Menu or SK_TREE.Active_Menu and !SK_TREE.Active_Menu:IsValid() ) then
			sk_menu_delay_nx = CurTime() + .5
			RunConsoleCommand( "sk_tree_menu" )		
		elseif ( SK_TREE.Active_Menu and SK_TREE.Active_Menu:IsValid() and SK_TREE.Active_Menu:IsVisible() ) then
			SK_TREE.Active_Menu.exit:Remove()
			SK_TREE.Active_Menu:Close()
			sk_menu_delay_nx = CurTime() + .5
		end
	end
end )

hook.Add( "HUDPaint", "SK_TREE_BLACK", function()
	if ( SK_TREE.FULLSCREEN == true and SK_TREE.Active_Menu and SK_TREE.Active_Menu:IsValid() ) then
		draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0, 255 ) )
	end
end )

local bl = { "NetGraph", "DarkRP_LocalPlayerHUD", "SK_TREE_HUD" }
hook.Add( "HUDShouldDraw", "SK_TREE_BLACK_HIDE", function( name )
	if ( SK_TREE.FULLSCREEN == true and SK_TREE.Active_Menu and SK_TREE.Active_Menu:IsValid() ) then
		if ( table.HasValue( bl, name ) ) then return false end
	end
end )