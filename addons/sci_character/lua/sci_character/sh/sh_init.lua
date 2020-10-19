SChar = SChar or {}
SChar.Config = SChar.Config or {}
SChar.Action = SChar.Action or {}
SChar.Database = SChar.Database or {}
SChar.Database.Faction = SChar.Database.Faction or {}
SChar.Database.Gender = SChar.Database.Gender or {}
SChar.Database.Button = SChar.Database.Button or {}
local folder = "sci_character"

function SChar.Action.loadFactions()
	local foundFiles = file.Find(folder .. "/factions/*.lua", "LUA")
	MsgN("[SCharacter] Found " .. #foundFiles .. " factions files!")

	for k, v in pairs(foundFiles) do
        local fileName = folder.. "/factions/".. v

    	if SERVER then
			AddCSLuaFile(fileName)
		end

		include(fileName)
	end

end

function SChar.Action.loadGenders()
	local foundFiles = file.Find(folder .. "/genders/*.lua", "LUA")
	MsgN("[SCharacter] Found " .. #foundFiles .. " genders files!")

	for k, v in pairs(foundFiles) do
        local fileName = folder.. "/genders/".. v

    	if SERVER then
			AddCSLuaFile(fileName)
		end

		include(fileName)
	end
end

function SChar.Action:loadFactionTbl(tblFaction)
	SChar.Database.Faction[tblFaction.Name] = tblFaction
	if SERVER then
		resource.AddFile("materials/"..tblFaction.Icon)
	end
end

function SChar.Action:createButton(tblButton)
	if CLIENT then
		SChar.Database.Button[tblButton.ID] = tblButton
	end
end

function SChar.Action:CheckModel(mdl)
	if not util.IsValidModel(mdl) then
		MsgN("SCIFI CHARACTER MODEL IS INVALID. FACTION HAS A INVALID MODEL. MAY BREAK SCRIPT.")
	end
	MsgN("checked")
end

function SChar.Action:loadGenderTbl(tblGender)
	SChar.Database.Gender[tblGender.Name] = tblGender
	if SERVER then
		resource.AddFile("materials/"..tblGender.Icon)

	end
end

hook.Add("loadCustomDarkRPItems", "SChar.LoadAll()", function()
	// always load genders first, since factions can inherit gender data //
	SChar.Action.loadGenders()
	SChar.Action.loadFactions()
	timer.Simple(0.5, function()
		SChar.Action.finished()
	end)
end)

hook.Add("DarkRPFinishedLoading", "SCharLoadStuff", function()
	SChar.Action.loadGenders()
	SChar.Action.loadFactions()
end)

if ezJobs then
    hook.Add("ezJobsLoaded", "gayezjobshooklol", function()
        timer.Simple(1, function() 
            SChar.Action.loadGenders()
			SChar.Action.loadFactions()
			SChar.Action.finished()
        end)
    end)
end

function SChar.Action:finished()
	MsgN("Finished loading SCIFI Character")
end

function SChar.Action:checkName(text)
	return table.HasValue(SChar.Config.BlacklistNames, string.lower(text))
end

function SChar.Action:validName(text)
	if not text then return false end
	
	text = string.lower(text)
	text = string.Trim(text)

	if string.len(text) < SChar.Config.MinLength or string.len(text) >= SChar.Config.MaxLength then
        return false
    end

    if SChar.Action:checkName(text) then return false end
    
    return true
end
