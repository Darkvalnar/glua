if CLIENT then return end -- wtf?


util.AddNetworkString("SChar.ProcessCharacter")
util.AddNetworkString("SChar.OpenMenu")
util.AddNetworkString("SChar.OpenSpawnMenu")
util.AddNetworkString("SChar.Quit")
util.AddNetworkString("SChar.Deploy")
util.AddNetworkString("SChar.Delete")
util.AddNetworkString("SChar.CreateNew")
util.AddNetworkString("SChar.ChangeTeam")

// Saves the character so menu doesn't reopen //
function SChar.Action.characterSave(Player, data)
	if not file.IsDir("sci_char", "DATA") then
		file.CreateDir( "sci_char" )
	end

	timer.Simple(1, function()
		file.Write( "sci_char/"..Player:SteamID64()..".txt", util.TableToJSON(data))
	end)
end

net.Receive("SChar.ChangeTeam", function(len, player)
	local intTeam = net.ReadInt(16)
	local intChar = net.ReadInt(16)

	if not intTeam then return end
	if not intChar then return end
	
	SChar.Action.changeTeam(player, intTeam, intChar)
end)

function SChar.Action.changeTeam(pPlayer, intTeam, intCharID)
	if not pPlayer then return end
	if not intTeam then return end
	if not intCharID then return end
	
	if not SChar.BlogsWhitelist then return end
	
	BWhitelist:IsWhitelisted(pPlayer, intTeam, function(bool)
		if (bool == false) then
			MsgN("Player not whitelisted.")
			pPlayer:PrintMessage(HUD_PRINTTALK, "You're not whitelisted to this team.")
			return
		end
	end)


	local data = file.Read("sci_char/"..pPlayer:SteamID64()..".txt", "DATA" )
	if not data then return end

	local tbl = util.JSONToTable(data)
	tbl[intCharID].Team = intTeam

	SChar.Action.characterSave(pPlayer, tbl)
	pPlayer.NoOpen = true
	timer.Simple(1, function()
		pPlayer.NoOpen = false
		pPlayer:PrintMessage(HUD_PRINTTALK, "Character team changed successfully.")
	end)
end

function SChar.Action:hasChar(Player)
	local data = file.Read("sci_char/"..Player:SteamID64()..".txt", "DATA" )
	if not data then return false end
	
 	local tbl = util.JSONToTable(data)

 	local bool = false

 	if table.HasValue(SChar.Config.Char_VIPGroups, Player:GetUserGroup()) then
 		local max = SChar.Config.Char_MaxVIP

 		if table.Count(tbl) >= max then
 			bool = true
 		end
 	else
 		local max = SChar.Config.Char_Max

 		if table.Count(tbl) >= max then
 			bool = true
 		end
 	end

 	return bool
end




//hook.Add( "PostCharacterCreated" , SChar.Action , SChar.Action.characterSave )



// Print Messages //
function SChar.Action:Print(msg)
	if SChar.Config.DarkRP == true then
		// notify dark
	else
		// print chat
	end

end

// Make sure the model sent from clientside is the right one //
function SChar.Action:validModel(faction, mdl)
	local bool = true

	for k,v in pairs(SChar.Database.Faction) do
		if mdl == v.Model then
			bool = false
			break
		end
	end

	return bool
end

net.Receive('SChar.CreateNew', function(len, Player)
	if SChar.Action:hasChar(Player) then
		Player:PrintMessage(HUD_PRINTTALK, "You have reached the max amount of characters!")
		Player:PrintMessage(HUD_PRINTTALK, "You have reached the max amount of characters!")
		return
	end

	SChar.Action:openMenu(Player)
end)

net.Receive("SChar.Delete" ,function(len, Player)
	local index = net.ReadInt(32)

	local data = file.Read("sci_char/"..Player:SteamID64()..".txt", "DATA" )
	local tbl = util.JSONToTable(data)

	if not data then
		Player:PrintMessage(HUD_PRINTTALK, "You don't have a character to delete!")
		return
	end

	tbl[index] = nil
	SChar.Action.characterSave(Player, tbl)
end)

net.Receive("SChar.ProcessCharacter", function(len, Player)
	local faction = net.ReadString()
	local name = net.ReadString()
	local model = net.ReadString()

	if not faction or not name or not model then
		SChar.Action:openMenu(Player)
		return
	end

	if SChar.Action:validModel(model) then 
		// Client sent a model that doesn't match it's faction; restart. //
		SChar.Action:openMenu(Player)
		return 
	end

	if not SChar.Action:validName(name) then
		// Client bypass a clientside name check; restart. //
		SChar.Action:openMenu(Player)
		return
	end

	if not SChar.Database.Faction[faction] then
		// Client sent a invalid faction; restart //
		SChar.Action:openMenu(Player)
		return
	end

	if SChar.Action:hasChar(Player) then
		MsgN("Player used character menu when he already had a character. Exploit?")
		Player:PrintMessage(HUD_PRINTTALK, "You have reached the max amount of characters!")
		Player:PrintMessage(HUD_PRINTTALK, "You have reached the max amount of characters!")
		return
	end

	local data = SChar.Database.Faction[faction]
	if not data then return end

	

	local name = name
	if data.Prefix then
		name = data.Prefix .. " " .. name
	elseif SChar.Config.Prefix == true and SChar.Config.Digits == true   then
		local number = tostring(math.random(SChar.Config.DigitsMin, SChar.Config.DigitsMax))
		name = SChar.Config.PrefixText .. " " .. number .. " " .. name
	elseif SChar.Config.Prefix == true then
		name = SChar.Config.PrefixText .. " " .. name
	elseif SChar.Config.Digits == true and SChar.Config.Prefix != true then
		local number = tostring(math.random(SChar.Config.DigitsMin, SChar.Config.DigitsMax))
		name = number .. " " .. name
	end

	if not data.DefaultClass then
		MsgN("SCI CHARACTER CLASS DOES NOT EXIST ON DARKRP. CREATE THE CLASS.")
		MsgN("Faction Name: " .. faction .. " must have a valid class! WILL BREAK SCRIPT!")
		Player:PrintMessage(HUD_PRINTTALK, "Please inform developer. You created a character with a team that doesn't exist!!!")
		Player:PrintMessage(HUD_PRINTTALK, "Please inform developer. You created a character with a team that doesn't exist!!!")
		Player:PrintMessage(HUD_PRINTTALK, "Please inform developer. You created a character with a team that doesn't exist!!!")
		return
	end

	local tbl = file.Read("sci_char/"..Player:SteamID64()..".txt", "DATA" )
	if tbl then
		tbl = util.JSONToTable(tbl)
	else
		tbl = {}
	end

	table.insert(tbl, {Model = model, Team = data.DefaultClass, Faction = faction, Name = name})
	SChar.Action.characterSave(Player, tbl)
	Player:changeTeam(data.DefaultClass, true, true)
	Player:Spawn()
	Player:SetModel(model)
	Player:setRPName(name, false)

end)

net.Receive("SChar.Quit",function(len, Player)
	Player:SendLua([[RunConsoleCommand('disconnect')]])
end)

net.Receive("SChar.Deploy",function(len, Player)
	local name = net.ReadString()
	local model = net.ReadString()
	local team = net.ReadInt(32)

	Player:changeTeam(team, true, true)
	
	Player:Spawn()

	Player:SetModel(model)

	Player.CurModel = model

	if SChar.Config.S_ForceName == true then
		Player:setRPName(name, false)
	end

	Player:setRPName(name, false)
end)

local function SetCharacterModel( ply )
	if SChar.Config.DeathModelForce == true then
		if not ply.CurModel then return end
		
		ply:SetModel(CurModel)

	end
end
hook.Add( "PlayerSpawn", "SetCharacterModel", SetCharacterModel )

hook.Add( "PlayerSay", "OpenCharacterMenu", function( ply, text, public )
	text = string.lower( text )
	if (table.HasValue(SChar.Config.ChatCommand , text)) then
		local data = file.Read("sci_char/"..ply:SteamID64()..".txt", "DATA" )
		local tbl = util.JSONToTable(data)

		if (ply.NoOpen == true) then
			ply:PrintMessage(HUD_PRINTTALK, "Character data saving... cannot open menu.")
			return
		end

		local tWhitelist = {}
		if SChar.BlogsWhitelist then
			for k,v in pairs(RPExtraTeams) do
				BWhitelist:IsWhitelisted(ply, k, function(whitelisted) 
					if whitelisted == true then
						table.insert(tWhitelist, k)
					end
				end)
			end
		end

		net.Start("SChar.OpenSpawnMenu")
			net.WriteTable(tbl)
			if tWhitelist then
				net.WriteTable(tWhitelist)
			end
		net.Send(ply)
		return ""
	end
end )

function SChar.Action:forceActions(Player, data)
	if not Player then return end
	if not data then return end
	if SChar.Config.EnableForce == false then return end

	for k,v in pairs(data) do
		if SChar.Config.ForceName == true then
			Player:setRPName(v["Name"], false)
		end

		if SChar.Config.ForceJob == true then
			Player:changeTeam(v["Team"], true, true)
		end

		if SChar.Config.ForceModel == true then
			Player:SetModel(v["Model"])
		end

		if SChar.Config.EnableForce == true then
			Player:Spawn()
		end

		Player.SFaction = v["Faction"]
	end
end


function SChar.Action:openMenu(Player)
	net.Start("SChar.OpenMenu")
	net.Send(Player)
end


local function loadCharMenu(Player)
	timer.Simple(2, function()
		if not file.Read("sci_char/"..Player:SteamID64()..".txt", "DATA" ) then
			net.Start("SChar.OpenMenu")
			net.Send(Player)
		else
			local data = file.Read("sci_char/"..Player:SteamID64()..".txt", "DATA" )
			if not data then
				net.Start("SChar.OpenMenu")
				net.Send(Player)
				return
			end
			local tbl = util.JSONToTable(data)
			if not data then return end
			SChar.Action:forceActions(Player, tbl)
			if SChar.Config.SpawnMenu == true then
				local tWhitelist = {}
				if SChar.BlogsWhitelist then
					for k,v in pairs(RPExtraTeams) do
						BWhitelist:IsWhitelisted(Player, k, function(whitelisted) 
							if whitelisted == true then
								table.insert(tWhitelist, k)
							end
						end)
					end
				end
				net.Start("SChar.OpenSpawnMenu")
					net.WriteTable(tbl)
					if tWhitelist then
						net.WriteTable(tWhitelist)
					end
				net.Send(Player)
			end
		end
	end)
end
hook.Add( "PlayerInitialSpawn", "loadcharactermenu", loadCharMenu )



resource.AddWorkshop(1119912464)