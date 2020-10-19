SK_TREE.HUD = {}

SK_TREE.HUD.w = 400
SK_TREE.HUD.h = 75
SK_TREE.HUD.x = ScrW() / 2 - SK_TREE.HUD.w / 2
SK_TREE.HUD.y = 10

SK_TREE.HUD.BACKGROUND_COL = Color( 0, 0, 0, 150 )
SK_TREE.HUD.BAR_COL = Color( 100, 255, 0, 255 )
SK_TREE.HUD.LEVEL_COL = Color( 255, 255, 255, 255 )

surface.CreateFont( "SK_TREE_TEXT_01", {
	font = "Tahoma",
	size = 16
} )

surface.CreateFont( "SK_TREE_TEXT_01_BOLD", {
	font = "Tahoma",
	size = 16,
	weight = 1000
} )

surface.CreateFont( "SK_TREE_TEXT_02", {
	font = "Tahoma",
	size = 32
} )

SK_TREE.SK_TREE_VAR = SK_TREE.SK_TREE_VAR or {}
local sk_tree_trans = sk_tree_trans or 0
local sk_tree_anim = sk_tree_anim or { { msg = "Gained 100 Experience", pos_change = 0 } }

hook.Add( "HUDPaint", "SK_TREE_HUD_LEVEL", function()
	if ( SK_TREE.FULLSCREEN == true and hook.Call( "HUDShouldDraw", GAMEMODE, "SK_TREE_HUD" ) == false ) then return end

	local x, y, w, h = SK_TREE.HUD.x, SK_TREE.HUD.y, SK_TREE.HUD.w, SK_TREE.HUD.h
	SK_TREE.Blur( x, y, w, h, 5 )
	draw.RoundedBox( 0, x, y, w, h, SK_TREE.HUD.BACKGROUND_COL )
	
	surface.SetDrawColor( 0, 0, 0, 125 )
	surface.DrawOutlinedRect( x, y, w, h )
	
	surface.DrawOutlinedRect( x + 5,  y + h - 10, w - 10, 5 )
	draw.RoundedBox( 0, x + 5, y + h - 10, w - 10, 5, Color( 0, 0, 0, 85 ) )
	
	/* Dynamic Stuff */	
	
	local exp_bar = ( w - 12 )
	local pl_level = tonumber( SK_TREE.SK_TREE_VAR and SK_TREE.SK_TREE_VAR.SKILL_POINTS and SK_TREE.SK_TREE_VAR.SKILL_POINTS.LEVEL ) or 0
	local pl_exp = math.Round( tonumber( SK_TREE.SK_TREE_VAR and SK_TREE.SK_TREE_VAR.SKILL_POINTS and SK_TREE.SK_TREE_VAR.SKILL_POINTS.EXP ) or 0 )
	local pl_skp = tonumber( SK_TREE.SK_TREE_VAR and SK_TREE.SK_TREE_VAR.SKILL_POINTS and SK_TREE.SK_TREE_VAR.SKILL_POINTS.SKILL ) or 0
	local exp_data = LocalPlayer():iEXP_iLEVEL( pl_level, pl_exp )
	
	if ( math.Round( sk_tree_trans ) > pl_exp - 2 and sk_tree_trans != pl_exp ) then
		sk_tree_trans = pl_exp
	elseif ( pl_exp and math.Round( sk_tree_trans ) != pl_exp ) then
		sk_tree_trans = Lerp( .025, sk_tree_trans, pl_exp )
	end
	
	exp_bar = exp_bar * ( sk_tree_trans / exp_data.exp_requiredflevel )
	
	draw.RoundedBox( 0, x + 1, y + 1, w - 2, 1, Color( 255, 255, 255, 5 ) )
	
	draw.RoundedBox( 0, x + 6, y + h - 9, math.Clamp( exp_bar, 0, w - 12 ), 3, SK_TREE.HUD.BAR_COL  )
	draw.RoundedBox( 0, x + 6, y + h - 9, math.Clamp( exp_bar, 0, w - 12 ), 1, Color( 255, 255, 255, 35 )  )
	
	draw.SimpleText( pl_level, "SK_TREE_TEXT_02", ( x ) + w / 2, ( y ), SK_TREE.HUD.LEVEL_COL, 1 )
	
	draw.SimpleText( tostring( pl_skp ) .. " Skill Point/s", "SK_TREE_TEXT_01", ( x ) + 5, ( y ) + h - 27, Color( 255, 255, 255, 175 ) )
	draw.SimpleText( tostring( math.Round( sk_tree_trans ) ) .. " / " .. tostring( math.Round( exp_data.exp_requiredflevel ) ), "SK_TREE_TEXT_01", ( x ) + w - 5, ( y ) + h - 27, Color( 255, 255, 255, 175 ), 2 )
	
	for _, v in pairs( sk_tree_anim ) do
		v.pos_change = Lerp( .005, v.pos_change, 60 )
		
		if ( v.pos_change > 58 ) then
			sk_tree_anim[_] = nil
			continue
		end
		
		draw.SimpleText( v.msg, "SK_TREE_TEXT_01_BOLD", ( x ) + w / 2, ( y ) + 75 + 50 - v.pos_change, Color( 180, 255, 85, 255 - ( v.pos_change * 5 ) ), 1 )
	end
end )

net.Receive( "SK_TREE_CLIENTVAR", function( len )
	SK_TREE.SK_TREE_VAR = SK_TREE.SK_TREE_VAR or {}
	SK_TREE.SK_TREE_VAR.SKILL_POINTS = net.ReadTable()
	SK_TREE.SK_TREE_VAR.SKILL_STATS = net.ReadTable()
end )

net.Receive( "SK_TREE_CLIENTVAR_CHANGE", function( len )
	local msg = net.ReadString()
	local amt = tonumber( net.ReadString() )

	SK_TREE.SK_TREE_VAR = SK_TREE.SK_TREE_VAR or {}
	SK_TREE.SK_TREE_VAR.SKILL_POINTS = SK_TREE.SK_TREE_VAR.SKILL_POINTS or {}	
	SK_TREE.SK_TREE_VAR.SKILL_POINTS.EXP = amt
	
	table.insert( sk_tree_anim, { msg = msg, pos_change = 0 } )
end )