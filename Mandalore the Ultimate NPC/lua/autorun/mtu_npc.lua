--------------------FULL CREDIT FOR MODELS GOES TO ENGYS EPANGELMATIKES, CHECK HIM OUT ON STEAM---------------------------
-------------------- https://steamcommunity.com/id/EngysEpangelmatikes ---------------------------------------------------

local NPC = {
	Name = "Mandalore The Ultimate",
	Class = "npc_combine_s",
	Category = "Mandalore The Ultimate (HOSTILE)",
	Model = "models/epangelmatikes/mtunpc/MTUltimate.mdl",
	Health = 1000
}
list.Set( "NPC", "Mandalore_TU_1_H", NPC )

----------------FRIENDLY---------------------

local NPC = {
	Name = "Mandalore The Ultimate",
	Class = "npc_citizen",
	Category = "Mandalore The Ultimate (FRIENDLY)",
	Model = "models/epangelmatikes/mtunpc/MTUltimate.mdl",
	Health = 1000,
		KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "Mandalore_TU_1_F", NPC )





