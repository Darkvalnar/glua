local Category = "Skytrooper [Hostile]"

--Models made by Omega Assailant 
--NPCs by Rawlings





local NPC = {
	Name = "Skytrooper White",
	Class = "npc_combine_s",
	Category = Category,
	Health = 100,
	Model = "models/omega/npc/skytrooper/skytrooper.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_skytrooper1h", NPC )

local NPC = {
	Name = "Skytrooper Blue",
	Class = "npc_combine_s",
	Category = Category,
	Health = 100,
	Model = "models/omega/npc/skytrooperblue/skytrooperblue.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_skytrooper2h", NPC )

local NPC = {
	Name = "Skytrooper Green",
	Class = "npc_combine_s",
	Category = Category,
	Health = 100,
	Model = "models/omega/npc/skytroopergreen/skytroopergreen.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_skytrooper3h", NPC )

local NPC = {
	Name = "Skytrooper Red",
	Class = "npc_combine_s",
	Category = Category,
	Health = 100,
	Model = "models/omega/npc/skytrooperred/skytrooperred.mdl",
	KeyValues = { citizentype = CT_UNIQUE },
	Weapons = { "weapon_ar2", "weapon_shotgun", "weapon_smg1" } --everyone uses TFA override anyways
}
list.Set( "NPC", "npc_skytrooper4h", NPC )


