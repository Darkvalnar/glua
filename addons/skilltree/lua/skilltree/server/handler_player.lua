util.AddNetworkString( "SK_TREE_CLIENTVAR" )
util.AddNetworkString( "SK_TREE_CLIENTVAR_CHANGE" )

hook.Add( "PlayerInitialSpawn", "SK_TREE", function( ply )
	ply:SK_Player_Setup()
	ply:SK_Player_Save()
end )

function SK_TREE.PL:SK_ENT_COOLDOWN_SET( cooldown, ent, amt, msg )
	self:SK_AddExp( amt, msg or nil )
	table.insert( self.skt_cooldowns, { type = ent:GetClass(), owner = ent:Getowning_ent(), cooldown_end = CurTime() + cooldown } )
end

function SK_TREE.PL:SK_ENT_COOLDOWN_CHECK( ent )
	local shouldexp = true
	
	if !self.skt_cooldowns then self.skt_cooldowns = {} end

	for k, v in pairs( self.skt_cooldowns or {} ) do
		if ( v.cooldown_end <= CurTime() ) then
			self.skt_cooldowns[k] = nil
		end
	end

	for k, v in pairs( self.skt_cooldowns or {} ) do
		if ( v.type == ent:GetClass() and ent:Getowning_ent() == v.owner ) then
			shouldexp = false
			break
		end
	end
	return shouldexp
end

function SK_TREE.PL:SK_Player_Setup()
	self.SK_TREE_VAR = {}
	self.SK_TREE_VAR.SKILLS = util.JSONToTable( self:GetPData( "SK_TREE_SKILLS", util.TableToJSON( SK_TREE.DEFAULTS.SKILLS ) ) ) or SK_TREE.DEFAULTS.SKILLS
	self.SK_TREE_VAR.SKILLS_POINTS = util.JSONToTable( self:GetPData( "SK_TREE_POINTS", util.TableToJSON( SK_TREE.DEFAULTS.POINTS ) ) ) or SK_TREE.DEFAULTS.POINTS
end

function SK_TREE.PL:SK_Player_Save( spec, nocl )
	if ( !spec or spec == 0 ) then self:SetPData( "SK_TREE_SKILLS", util.TableToJSON( self.SK_TREE_VAR.SKILLS ) ) end	
	if ( !spec or spec == 1 ) then self:SetPData( "SK_TREE_POINTS", util.TableToJSON( self.SK_TREE_VAR.SKILLS_POINTS ) ) end
	
	if ( nocl and nocl == true ) then return end
	
	net.Start( "SK_TREE_CLIENTVAR" )
		net.WriteTable( self.SK_TREE_VAR.SKILLS_POINTS )
		net.WriteTable( self.SK_TREE_VAR.SKILLS )
	net.Send( self )
end

function SK_TREE.PL:SK_GetPointsType( type )
	return self.SK_TREE_VAR.SKILLS_POINTS[type]
end

function SK_TREE.PL:SK_CanAffordPoints( type, amt )
	return self.SK_TREE_VAR.SKILLS_POINTS[type] >= amt
end

//player.GetAll()[1]:SK_AddExp( 2500000 )
//player.GetAll()[1]:SK_Player_Setup()
function SK_TREE.PL:SK_AddExp( amt, msg )
	local multiplier = ( SK_TREE.LEVELS.MUL["base"] or 1 ) + ( SK_TREE.LEVELS.MUL[self:GetUserGroup()] or 0 )
	local amt = amt * multiplier
	
	self.SK_TREE_VAR.SKILLS_POINTS.EXP = ( self.SK_TREE_VAR.SKILLS_POINTS.EXP or 0 ) + amt 

	local exp_data
	local level = self.SK_TREE_VAR.SKILLS_POINTS.LEVEL or 0
	
	repeat
		level = self.SK_TREE_VAR.SKILLS_POINTS.LEVEL or 0
		exp_data = self:iEXP_iLEVEL( level, self.SK_TREE_VAR.SKILLS_POINTS.EXP )
		
		if ( exp_data.level_lvlup ) then
			self.SK_TREE_VAR.SKILLS_POINTS.LEVEL = level + 1
			self.SK_TREE_VAR.SKILLS_POINTS.EXP = -exp_data.exp_toNextOrOver
		
			self:SK_AddPoints( "SKILL", 1 )
		end
	until exp_data.exp_toNextOrOver >= 0

	self:SK_Player_Save( 1, true )
	
	net.Start( "SK_TREE_CLIENTVAR_CHANGE" )
		net.WriteString( ( msg and string.format( msg, tostring( amt ) ) ) or ( "Gained " .. tostring( amt ) .. " Experience" ) )
		net.WriteString( self.SK_TREE_VAR.SKILLS_POINTS.EXP )
	net.Send( self )
end

function SK_TREE.PL:SK_AddPoints( type, amt )
	if ( amt == 0 ) then return end
	
	self.SK_TREE_VAR.SKILLS_POINTS[type] = ( self.SK_TREE_VAR.SKILLS_POINTS[type] or 0 ) + amt

	if ( type == "EXP" ) then
		self:SK_AddExp( amt )
	end
	
	self:SK_Player_Save( 1 )
end
 
function SK_TREE.PL:SK_UpdateStat( stat_name, value )
	self.SK_TREE_VAR.SKILLS[stat_name] = value
	self:SK_Player_Save( 0 )
end

// All hook associated with stats go here -.- gg

/*
	Hooks for Gaining EXP
*/
	hook.Add( "OnNPCKilled", "SK_TREE_GAIN_NPC", function( npc, attacker, inf )
		if ( SK_TREE.EXP_GAIN.NPC.ENABLED == true and attacker:IsPlayer() ) then
			local awarded = SK_TREE.EXP_GAIN.NPC.RATES[npc:GetClass()] or SK_TREE.EXP_GAIN.NPC.RATES.default
			
			attacker:SK_AddExp( awarded, "Gained %s for killing an npc: " .. SK_TREE.NPC_NAME( npc:GetClass() ) )
		end
	end )
	
	hook.Add( "PlayerDeath", "SK_TREE_GAIN_PVP", function( vic, inf, att )
		if ( SK_TREE.EXP_GAIN.PVP.ENABLED == true and att:IsPlayer() and att != vic ) then
			local awarded = SK_TREE.EXP_GAIN.PVP.AMOUNT or 10
			
			if ( SK_TREE.EXP_GAIN.PVP.LEECHEXP == true and vic.SK_TREE_VAR.SKILLS_POINTS.EXP - awarded < 0 ) then awarded = vic.SK_TREE_VAR.SKILLS_POINTS.EXP end
			
			att:SK_AddExp( awarded, "Gained %s for killing a player: " .. vic:Name() )
			if ( SK_TREE.EXP_GAIN.PVP.LEECHEXP == true ) then vic:SK_AddExp( -awarded, "You lost %s for because player: " .. vic:Name() .. " killed you" ) end
		end
	end )

	timer.Create( "SK_TREE_TIMER_GIVEMONEY_DOCTOR", SK_TREE.SKILLS["medic_doctor"].variables[1][2], 0, function()
		for k, v in pairs( player.GetAll() ) do
			if v.SK_TREE_VAR and v.SK_TREE_VAR.SKILLS["medic_doctor"] and ( string.find( string.lower( team.GetName( v:Team() ) ), "doctor" ) != nil or string.find( string.lower( team.GetName( v:Team() ) ), "medic" ) != nil ) then
				v:addMoney( SK_TREE.SKILLS["medic_doctor"].variables[1][1] )
			end			
		end
	end )
	
	timer.Create( "SK_TREE_TIMER_GIVEMONEY_TIME", SK_TREE.EXP_GAIN.TIME.DELAY, 0, function()
		if !( SK_TREE.EXP_GAIN.TIME.ENABLED == true ) then return end
		
		for k, v in pairs( player.GetAll() ) do
			v:SK_AddExp( SK_TREE.EXP_GAIN.TIME.AMOUNT )	
		end
		
	end )
/*
	Hooks for Skills
*/

	local hook_funcs ={

	}

	hook.Add( "playerWanted", "SK_TREE_SPEED_WANTED_01", function( ply ) hook.Call( "UpdatePlayerSpeed", GAMEMODE, ply ) end )
	hook.Add( "playerUnWanted", "SK_TREE_SPEED_WANTED_01", function( ply ) hook.Call( "UpdatePlayerSpeed", GAMEMODE, ply ) end )
	
	hook.Add( "UpdatePlayerSpeed", "SK_TREE_SPEED_TRIG", function( ply ) timer.Simple( 0, function() hook.Call( "SK_TREE_SPEED", GAMEMODE, ply ) end ) end )
	
	hook.Add( "PlayerSpawn", "SK_TREE_BOOSTS", function( ply )
		timer.Simple( 1, function()
			ply:SetHealth( ( tonumber( GAMEMODE.Config.startinghealth ) or 100 ) * ( 1 + hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "health_boost" ) + hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "armour_boost" ) ) )
			ply:SetMaxHealth( ( tonumber( GAMEMODE.Config.startinghealth ) or 100 ) * ( 1 + hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "health_boost" ) + hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "armour_boost" ) ) )
		end )
	end )

	hook.Add( "SK_TREE_SPEED", "SK_TREE_SPEED", function( ply ) 		
		local mul = 1 + hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "athletic_training" )
		if ( ply:isWanted() ) then mul = mul + hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "thief_run" ) end

		local sp1, sp2 = GAMEMODE.Config.walkspeed, GAMEMODE.Config.runspeed
		
		if ply:isArrested() then
			sp1, sp2 = GAMEMODE.Config.arrestspeed, GAMEMODE.Config.arrestspeed
		elseif ply:isCP() then
			sp2 = GAMEMODE.Config.runspeedcp
		end
	
		GAMEMODE:SetPlayerSpeed( ply, sp1 * mul, sp2 * mul )
	
		mul = hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "jump_training" )
	
		local jump_power = 200
		
		if ( ply.isDrugged == true ) then jump_power = jump_power + 100 end
	
		timer.Simple( 1, function() ply:SetJumpPower( jump_power * ( 1 + mul ) ) end )
	end )
	
	hook.Add( "ScalePlayerDamage", "SK_TREE_DODGE", function( ply, g, dmg )
		local chnc = 0 
		local mul = 0
		
		if ( ply:IsPlayer() ) then
			chnc = hook.Call( "SK_TREE_MUL", GAMEMODE, ply, "bullet_dodge", true )
		end
		
		if ( dmg:GetAttacker():IsPlayer() ) then
			mul = hook.Call( "SK_TREE_MUL", GAMEMODE, dmg:GetAttacker(), "bullet_boost" )
		end
		
		dmg:ScaleDamage( 1 + mul )

		if ( chnc > 0 and math.Round( math.Rand( 1, 100 ) ) <= chnc ) then
			return true
		end
	end )
	
	
concommand.Add( "sk_reset", function( ply, cmd, args )
	if !ply:IsSuperAdmin() then return end
	
	ply.SK_TREE_VAR.SKILLS_POINTS.LEVEL = 1
	ply.SK_TREE_VAR.SKILLS_POINTS.SKILL = 1
	ply.SK_TREE_VAR.SKILLS_POINTS.EXP = 0
	ply.SK_TREE_VAR.SKILLS = {}
	ply:SK_Player_Save( 1 )
	ply:SK_Player_Save( 0 )
end )

concommand.Add( "sk_reset_allonline", function( ply, cmd, args )
	if !ply:IsSuperAdmin() then return end
	
	for k, v in pairs( player.GetAll() ) do
		v.SK_TREE_VAR.SKILLS_POINTS.LEVEL = 1
		v.SK_TREE_VAR.SKILLS_POINTS.SKILL = 1
		v.SK_TREE_VAR.SKILLS_POINTS.EXP = 0
		v.SK_TREE_VAR.SKILLS = {}
		v:SK_Player_Save( 1 )
		v:SK_Player_Save( 0 )
	end
end )