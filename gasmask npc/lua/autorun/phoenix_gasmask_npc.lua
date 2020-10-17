local Category = "Phoenix Marine with Gasmask"

--Models made by Phil Modder, NPC code by Rawlings
--Phil Modder is a god for making these models <3 





local NPC = {
	Name = "Phoenix Marine Gasmask (HOSTILE)",
	Class = "npc_combine_s",
	Category = Category,
	Health = 50,
	Model = "models/characters/phoenix_marine_gasmask.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_phoenix_gasmask_hostile", NPC )

local NPC = {
	Name = "Phoenix Marine Gasmask (FRIENDLY)",
	Class = "npc_citizen",
	Category = Category,
	Health = 50,
	Model = "models/characters/phoenix_marine_gasmask.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_phoenix_gasmask_friendly", NPC )

