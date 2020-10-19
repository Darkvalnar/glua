SK_TREE.PL = FindMetaTable( "Player" )
SK_TREE.ENT = FindMetaTable( "Entity" )

if CLIENT then
	local b = Material( "pp/toytown-top" )
	function SK_TREE.Blur( x, y, w, h, i )
		surface.SetMaterial( b )
		surface.SetDrawColor( 255, 255, 255, 255 )
		
		for i = 1, i do
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect( x, y, w, h )
			surface.DrawTexturedRectUV( x, y, w, h, 0, 1, 0, 0 )
		end
	end
end

function SK_TREE.NPC_NAME( class )
	local npcs = list.Get("NPC")
	
	for _, v in pairs( npcs ) do
		if v.Class == class then return v.Name end
	end
end

function SK_TREE.PL:SK_LEVEL_EXP( level )
	return math.Round( ( ( level * 10 ) ^ 2 + ( 1.27 ^ level ) ) )
end

function SK_TREE.PL:iEXP_iLEVEL( level, exp )
	local data = {}
	data.exp_requiredflevel = self:SK_LEVEL_EXP( level )
	data.exp_toNextOrOver = ( exp and math.Round( data.exp_requiredflevel - exp ) ) or nil
	data.exp = exp or nil
	data.level = level
	data.level_lvlup = data.exp_toNextOrOver <= 0

	return data
end

function SK_TREE.SkillOwned( skill )
	return SK_TREE.SK_TREE_VAR.SKILL_STATS[skill] != nil
end

function SK_TREE.SkillLocked( skill )
	local skill_data = SK_TREE.SKILLS[skill]
 
	if ( skill_data.req_stat != nil and !SK_TREE.SkillOwned( skill_data.req_stat ) ) then return true end
	
	local skill_req = SK_TREE.SKILLS[skill_data.req_stat]

	if ( skill_data.req_stat != nil and SK_TREE.SK_TREE_VAR.SKILL_STATS[skill_data.req_stat] < skill_req.levels ) then return true end

	if ( skill_data.req_level != nil and SK_TREE.SK_TREE_VAR.SKILL_POINTS.LEVEL < skill_data.req_level ) then return true end
	
	if ( skill_data.req_usergroup and !table.HasValue( skill_data.req_usergroup, LocalPlayer():GetUserGroup() ) ) then return true end
	
	return false
end

hook.Add( "SK_TREE_MUL", "SK_TREE_MULTIPLIERS", function( ply, type, nodecimal )
	if ( nodecimal == true ) then nodecimal = 1 else nodecimal = 100 end

	local plskills = ( ply.SK_TREE_VAR and ply.SK_TREE_VAR.SKILLS ) or SK_TREE.SK_TREE_VAR.SKILL_STATS
	
	local val = ( plskills[type] and SK_TREE.SKILLS[type] and SK_TREE.SKILLS[type].variables and SK_TREE.SKILLS[type].variables[plskills[type]] ) or 0
	if ( val ) then return val / nodecimal end
	
	return 0
end )