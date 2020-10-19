SK_TREE.DEFAULTS = {}

SK_TREE.DEFAULTS.POINTS = {
	SKILL = 1,
	LEVEL = 1,
	EXP = 0
} // Starting points to be assigned

// Printer shop stuff in darkrp_customthings/skilltree_addtoshop.lua

// When should the player start with? eg. syntax name_stat = defaultlevel | medic_efficiency = 2
SK_TREE.DEFAULTS.SKILLS = {

}

SK_TREE.BIND = KEY_F7

SK_TREE.MENU = {}
SK_TREE.MENU.THEME = nil // color or nil. If you enter a colour there is quality loss, or for the default just type nil

/* = HD Options for anyone who wants to change
	To be able to use these make sure SK_TREE.MENU.THEME = nil
	and SK_TREE.MENU.SPRITE_BG_DEFAULT = your_image
*/
SK_TREE.DEFAULT_OPTIONS = {}
SK_TREE.DEFAULT_OPTIONS.DEFAULT = "http://i.imgur.com/ws9kzzL.jpg"
SK_TREE.DEFAULT_OPTIONS.DARK_BLUE = "http://i.imgur.com/mdSs6oc.jpg"
SK_TREE.DEFAULT_OPTIONS.COOL_BLUE = "http://i.imgur.com/ua8GUjl.jpg"
SK_TREE.DEFAULT_OPTIONS.CYAN = "http://i.imgur.com/S8lM0iE.jpg"
SK_TREE.DEFAULT_OPTIONS.GREEN = "http://i.imgur.com/SFdFVdQ.jpg"
SK_TREE.DEFAULT_OPTIONS.HOT_PINK = "http://i.imgur.com/G7H54WG.jpg"
SK_TREE.DEFAULT_OPTIONS.YELLOW = "http://i.imgur.com/8oa1lGg.jpg"
SK_TREE.DEFAULT_OPTIONS.ORANGE = "http://i.imgur.com/qhuEN7c.jpg"
SK_TREE.DEFAULT_OPTIONS.PEACH = "http://i.imgur.com/O4mbMsY.jpg"
SK_TREE.DEFAULT_OPTIONS.LIGHT_PURPLE = "http://i.imgur.com/hmgSbMi.jpg"
SK_TREE.DEFAULT_OPTIONS.PURPLE = "http://i.imgur.com/PDaGMd0.jpg"
SK_TREE.DEFAULT_OPTIONS.RED = "http://i.imgur.com/OEsicAn.jpg"
SK_TREE.DEFAULT_OPTIONS.WHITE = "http://i.imgur.com/594uVV3.jpg"

SK_TREE.MENU.SPRITE_BG_DEFAULT 	= SK_TREE.DEFAULT_OPTIONS.DEFAULT
SK_TREE.MENU.SPRITE_BG_PNG 		= "http://i.imgur.com/svEHu0w.png"
SK_TREE.MENU.SPRITE_SHEET		= "http://s23.postimg.org/bjm2dgbor/SKTREE_Sprite_Sheet.png"

// eg. SK_TREE.MENU.THEME = Color( 255, 133, 0, 255 )

SK_TREE.LEVELS = {}
SK_TREE.LEVELS.MUL = {  // Change the exp rate for ranks
	base = 1,  			// Base is the normal amount change to 2 if double exp week or something idk
	donator = .25,		// this is an additional .25 to the base totalling a x1.25 mul
	donator_plus = .5
}

SK_TREE.EXP_GAIN = {}

SK_TREE.EXP_GAIN.TIME = {}
SK_TREE.EXP_GAIN.TIME.ENABLED = true
SK_TREE.EXP_GAIN.TIME.DELAY = 300 // 5 Minutes
SK_TREE.EXP_GAIN.TIME.AMOUNT = 20
SK_TREE.EXP_GAIN.TIME.RANKBONUS = {
	donator = 35,
	donator_plus = 50
}

SK_TREE.EXP_GAIN.NPC = {}
SK_TREE.EXP_GAIN.NPC.ENABLED = true
SK_TREE.EXP_GAIN.NPC.RATES = {
	default = 10,
	npc_crow = 4,
	entity_class = 30
}

SK_TREE.EXP_GAIN.PVP = {}
SK_TREE.EXP_GAIN.PVP.ENABLED = true
SK_TREE.EXP_GAIN.PVP.LEECHEXP = true
SK_TREE.EXP_GAIN.PVP.AMOUNT = 15

SK_TREE.EXP_GAIN.PRINTERS = {}
SK_TREE.EXP_GAIN.PRINTERS.ENABLED = true
SK_TREE.EXP_GAIN.PRINTERS.TYPES = {
	default = 15,
	sk_money_printer = 25
}

// Cooldown is pretty much if the same person comes again then exp wont be added.

SK_TREE.EXP_GAIN.GUNLAB = {}
SK_TREE.EXP_GAIN.GUNLAB.ENABLED = false
SK_TREE.EXP_GAIN.GUNLAB.COOLDOWN = 240
SK_TREE.EXP_GAIN.GUNLAB.SELL_AMOUNT = 30
SK_TREE.EXP_GAIN.GUNLAB.BUY_AMOUNT = 30

SK_TREE.EXP_GAIN.DRUGLAB = {}
SK_TREE.EXP_GAIN.DRUGLAB.ENABLED = false
SK_TREE.EXP_GAIN.DRUGLAB.COOLDOWN = 210
SK_TREE.EXP_GAIN.DRUGLAB.AMOUNT = 40

SK_TREE.FULLSCREEN = false

// HERE this is where all information about a stat goes

/*
	medic_training = { req_usergroup = nil, name = "Medical Training", desc = "Improves your healing ability \n \n- Level 1: 10% faster \n- Level 2: 17% faster \n- Level 3: 30% faster", mat_pos = 1, levels = 3, req_stat = nil, req_level = nil, variables = { 10, 17, 30 } },

	THE BREAKDOWN
	
	req_usergroup = nil - what ranks are required to purchase eg. req_usergroup = { "donator", "donator+" } or req_usergroup = { "donator+" }
	name = "Medical Training" - this is how the name will display
	desc = "Improves your healing ability \n \n- Level 1: 10% faster \n- Level 2: 17% faster \n- Level 3: 30% faster" - the description as per the name \n stands for a line break
	mat_pos = 1 - Is the sprite index
	levels = 3 - Is how many levels the skill has
	req_stat = nil - Is there a required skill?
	req_level = nil - Is there a required level?
	variables = { 10, 17, 30 } - for how many levels there are will be the amount of numbers here eg level 1: 10, level 2: 17 and level 3: 30
*/

SK_TREE.SKILLS = {
	
	// MEDIC
	medic_training = { req_usergroup = nil, name = "Medical Training", desc = "Improves your healing ability \n \n- Level 1: 10% faster \n- Level 2: 17% faster \n- Level 3: 30% faster", mat_pos = 1, levels = 3, req_stat = nil, req_level = nil, variables = { 10, 17, 30 } },
	medic_doctor = { req_usergroup = nil, name = "Master Doctor", desc = "Learn all there is to aiding people, be paid when you're a doctor for being such a kind Citizen \n \n- $50 every minute", mat_pos = 17, levels = 1, req_stat = "medic_training", req_level = 5, variables = { { 50, 1 } } },
	good_fortune = { req_usergroup = nil, name = "Good Fortune", desc = "Chance to restore some armour \n \n- Level 1: 5% chance \n- Level 2: 12% chance", mat_pos = 13, levels = 2, req_stat = "medic_doctor", req_level = 9, variables = { 5, 12 } },
	
		
		
	// GENERAL MISC
	athletic_training = { req_usergroup = nil, name = "Athletic Training", desc = "Usain Bolt is in town, he's teaching you the basics of sprinting. \n \n- Level 1: 5% faster \n- Level 2: 9% faster \n- Level 3: 15% faster", mat_pos = 3, levels = 3, req_stat = nil, req_level = nil, variables = { 5, 9, 15 } },
	
	jump_training = { req_usergroup = nil, name = "Jump Power", desc = "People say white men can't jump, despite that jump how you feel no matter the colour \n \n- This will allow you to jump 10% higher", mat_pos = 4, levels = 1, req_stat = "athletic_training", req_level = 3, variables = { 10 } },
	bullet_dodge = { req_usergroup = nil, name = "Bullet Dodge", desc = "With the increase of agility you become more perceptive and can feel the world around you \n \n- Level 1: 5% chance to dodge \n- Level 2: 9% chance to dodge", mat_pos = 8, levels = 2, req_stat = "jump_training", req_level = 9, variables = { 5, 9 } },

	health_boost = { req_usergroup = nil, name = "Health Boost", desc = "This increases your max health \n \n- Level 1: 10% higher \n- Level 2: 25% higher", mat_pos = 9, levels = 2, req_stat = "athletic_training", req_level = 6, variables = { 10, 25 } },
	armour_boost = { req_usergroup = nil, name = "Power Armour", desc = "An armour native to the Brotherhood, reverse engineer it's beauty. \n \n- 15% more health", mat_pos = 10, levels = 1, req_stat = "health_boost", req_level = 11, variables = { 15 } },
	bullet_boost = { req_usergroup = nil, name = "Gun Dexterity", desc = "Knowing how to use a gun is the key to using it. \n \n- Level 1: 5% more damage \n- Level 2: 12% more damage", mat_pos = 11, levels = 2, req_stat = "armour_boost", req_level = 17, variables = { 5, 12 } },
}
