local Category = "National Guard with Balaclava"

--Models made by Phil Modder, NPC code by Rawlings
--Phil Modder is a god for making these models <3 





local NPC = {
	Name = "National Guard with Balaclava (HOSTILE)",
	Class = "npc_combine_s",
	Category = Category,
	Health = 50,
	Model = "models/humans/playerasd/guradmodel.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_nationalguard_hostile", NPC )

local NPC = {
	Name = "National Guard with Balaclava (FRIENDLY)",
	Class = "npc_citizen",
	Category = Category,
	Health = 50,
	Model = "models/humans/playerasd/guradmodel.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_nationalguard_friendly", NPC )

