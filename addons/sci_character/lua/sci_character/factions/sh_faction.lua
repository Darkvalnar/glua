--[[ Syntax ]]--

-- You can use faction.Prefix = "TEST" to set prefixes for the name for that faction only.

-- local faction = {}
-- faction.Name = "U.S.A"
-- faction.DefaultClass = TEAM_CITIZEN
-- faction.Icon = "sci_char/logo2.png"
-- faction.About = [[ USA This is example text]]
-- faction.Prefix = 'Sith Master'
-- faction.Models = {
-- 	["Male"] = {
-- 		"models/player/ct_gign.mdl",
-- 		"models/player/ct_urban.mdl",
-- 	},
-- 	["Female"] = {
-- 		"models/Humans/Group01/Female_06.mdl",
-- 		"models/Humans/Group01/Female_06.mdl",
-- 	},
-- } 

------------------------------------------------------------------

local faction = {}
faction.Name = "Imperial Military"
faction.DefaultClass = TEAM_CADET
faction.Icon = "sci_char/logo2.png"
faction.About = [[ The backbone of the Sith Empire]]
faction.Models = {
	["Male"] = {
		"models/endeavorroleplay/swtor/triumvirate/triumvirate.mdl",
		
	},
	["Female"] = {
		"models/endeavorroleplay/swtor/triumvirate/triumvirate.mdl",

	},
} 

SChar.Action:loadFactionTbl(faction)

local faction = {}
faction.Name = "Sith"
faction.DefaultClass = TEAM_SITH
faction.Icon = "sci_char/logo3.png"
faction.About = [[ The Sith are the most infamous of all dark side religions, and the members of the cult were often seen as the pinnacle of power within the dark side]]
faction.Prefix = 'Sith Acolyte'
faction.Models = {
	["Male"] = {
		"models/player/sith/human.mdl",
			"models/player/sith/pantoran.mdl",
			"models/player/sith/zabrak.mdl",
			"models/player/sith/twilek.mdl",
			"models/player/sith/nautolan.mdl",
			"models/player/sith/togruta.mdl",
			"models/player/sith/gungan.mdl",
			"models/player/sith/trandoshan.mdl",

	},
	["Female"] = {
		"models/stickytar/players/femalesith.mdl",
	},
}

SChar.Action:loadFactionTbl(faction)