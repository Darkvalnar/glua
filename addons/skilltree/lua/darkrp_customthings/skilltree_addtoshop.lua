AddCSLuaFile()

DarkRP.createEntity("Drug lab", {
	ent = "sk_drug_lab",
	model = "models/props_lab/crematorcase.mdl",
	price = 400,
	max = 3,
	cmd = "buyskdruglab",
	allowed = {TEAM_GANG, TEAM_MOB}
})

DarkRP.createEntity("Money printer", {
	ent = "sk_money_printer",
	model = "models/props_c17/consolebox01a.mdl",
	price = 1000,
	max = 2,
	cmd = "buyskmoneyprinter"
})

DarkRP.createEntity("Gun lab", {
	ent = "sk_gunlab",
	model = "models/props_c17/TrapPropeller_Engine.mdl",
	price = 500,
	max = 1,
	cmd = "buyskgunlab",
	allowed = TEAM_GUN
})