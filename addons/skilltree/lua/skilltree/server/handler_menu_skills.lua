util.AddNetworkString( "SK_TREE_BUY" )
util.AddNetworkString( "SK_TREE_SQREQUEST" )

net.Receive( "SK_TREE_BUY", function( len, ply ) 
	local pl_selection = net.ReadString()

	if !ply:SK_CanAffordPoints( "SKILL", 1 ) then return end
	
	if !( SK_TREE.SKILLS[pl_selection] ) then return end
	local selection = SK_TREE.SKILLS[pl_selection]
	
	local pl_level = ply.SK_TREE_VAR.SKILLS_POINTS.LEVEL

	if ( selection.req_usergroup and !table.HasValue( selection.req_usergroup, ply:GetUserGroup() ) ) then return end
	
	if ( selection.req_level != nil and pl_level < selection.req_level ) then return end

	if ( selection.req_stat != nil and ( ply.SK_TREE_VAR.SKILLS[selection.req_stat] or 0 ) < SK_TREE.SKILLS[selection.req_stat].levels ) then return end

	if ( ( ply.SK_TREE_VAR.SKILLS[pl_selection] or 0 ) >= selection.levels ) then return end
	
	ply:SK_AddPoints( "SKILL", -1 )
	
	ply:SK_UpdateStat( pl_selection, ( ply.SK_TREE_VAR.SKILLS[pl_selection] or 0 ) + 1 )
	
	ply:ConCommand( "play buttons/button15.wav" )
end )

local SQREQ_FUNCTION = {}
SQREQ_FUNCTION.FILTER = {}
SQREQ_FUNCTION.FILTER[1] = function()
	
	
	for k, v in pairs( player.GetAll() ) do
		
	end
end

		//local name = Format( "%s[%s]", v:UniqueID(), "SK_TREE_POINTS" )
		//local data = sql.QueryValue( Format( "SELECT `value` FROM playerdata WHERE `infoid` = %s", name ) )

net.Receive( "SK_TREE_SQREQUEST", function( len, ply )
	local recData = { lol_goteem = net.ReadString(), mode = net.ReadInt(), args = net.ReadTable() }
	
	if ( ply:GetUserGroup() != lol_goteem ) then print( "Player: " .. ply:Name() .. " is executing lua and attempting to exploit." ) return end
	if ( !ply:IsSuperAdmin() ) then return end
	
	local s_filter = 1
	local s_mode = recData.mode
	
	if ( s_mode == 0 ) then
		if ( recData.args[1] == "all" ) then filter = 2
		elseif ( recData.args[1] ) then filter = 3 end
		
		local data = nil
		
		sql.Query( "" )
		
		net.Start( "SK_TREE_SQREQUEST" )
			net.WriteTable(  )
		net.Send( ply )
	else
	
	end
end )