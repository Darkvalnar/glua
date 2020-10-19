--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------
This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
      Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields

Add your custom jobs under the following line:
---------------------------------------------------------------------------]]



TEAM_CADET = DarkRP.createJob("Cadet", {
    color = Color(102, 102, 102, 255),
    model = {"models/endeavorroleplay/swtor/triumvirate/triumvirate.mdl"},
    description = [[Untrained Imperial Cadet]],
    weapons = {"salute","Keys"},
    command = "cadet",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Cadets",
    PlayerLoadout = function(ply) ply:SetHealth(100) end,
})



TEAM_IT = DarkRP.createJob("Imperial Trooper", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_basic/gingers_sith_basic_trooper.mdl"},
    description = [[Standard Imperial Trooper]],
    weapons = {"salute","tfa_kotor_bp_5", "tfa_kotor_br_2", "tfa_kotor_repeaten_1", "1"},
    command = "IMPT",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Imperial Trooper",
	PlayerSpawn = function(ply) ply:SetHealth(125) ply:SetArmor(100) end,
})

TEAM_IT = DarkRP.createJob("Imperial Trooper Officer", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_basic/gingers_sith_basic_officer.mdl"},
    description = [[Officer of the Imperial Trooper Regiment]],
    weapons = {"salute","tfa_kotor_bp_5",  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1"},
    command = "IMPO",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Imperial Trooper",
	PlayerSpawn = function(ply) ply:SetHealth(150) ply:SetArmor(125) end,
})
TEAM_IT = DarkRP.createJob("Imperial Trooper Commander", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_basic/gingers_sith_basic_commander.mdl"},
    description = [[Commander of the Imperial Trooper Regiment]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" },
    command = "IMPCO",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Imperial Trooper",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_75TH = DarkRP.createJob("75th Legion Trooper", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_gold/gingers_sith_gold_trooper.mdl"},
    description = [[A trooper of Darth Vago's 75th Legion]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" },
    command = "75TR",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "75th Legion",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_75TH = DarkRP.createJob("75th Legion Medic", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_gold/gingers_sith_gold_trooper.mdl"},
    description = [[A medical trooper of Darth Vago's 75th Legion]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" },
    command = "75MED",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "75th Legion",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_75TH = DarkRP.createJob("75th Legion Heavy", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_gold/gingers_sith_gold_officer.mdl"},
    description = [[Heavy of Darth Vago's 75th Legion]],
    weapons = {"salute","tfa_kotor_hvybp_3" ,  "tfa_752_ihr" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  "tfa_grenade"},
    command = "75HVY",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "75th Legion",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_75TH = DarkRP.createJob("75th Legion Officer", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_gold/gingers_sith_gold_officer.mdl"},
    description = [[Officer of Darth Vago's 75th Legion]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  ""},
    command = "75O",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "75th Legion",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})


TEAM_75TH = DarkRP.createJob("75th Legion Commander", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_gold/gingers_sith_gold_commander.mdl"},
    description = [[Commander of Darth Vago's 75th Legion]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  ""},
    command = "75CO",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "75th Legion",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})


TEAM_308 = DarkRP.createJob("308th Trooper", {
    color = Color(200, 200, 200, 255),
    model = {"models/ajax/ajax_sith_308th_order/ajax_sith_order_trooper.mdl"},
    description = [[Regular 308th Order Trooper]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  "weapon_cuff_elastic", "unarrest_stick", "arrest_stick", "stun_stick"},
    command = "308TR",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "308th Order",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})
TEAM_308 = DarkRP.createJob("308th Dusk Squadron", {
    color = Color(200, 200, 200, 255),
    model = {"models/ajax/ajax_sith_308th_order/ajax_sith_order_sniper.mdl"},
    description = [[Assassin trooper of 308th's Dusk Squadron]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_wsp_5", "weapon_shadowvirus_grenade", "weapon_cuff_elastic", "unarrest_stick", "arrest_stick", "stun_stick"},
    command = "DUSK",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "308th Order",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})
TEAM_308 = DarkRP.createJob("308th Officer", {
    color = Color(200, 200, 200, 255),
    model = {"models/ajax/ajax_sith_308th_order/ajax_sith_order_officer.mdl"},
    description = [[Officer of the 308th Order]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  "weapon_cuff_elastic", "unarrest_stick", "arrest_stick", "stun_stick"},
    command = "308O",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "308th Order",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_308 = DarkRP.createJob("308th Commander", {
    color = Color(200, 200, 200, 255),
    model = {"models/ajax/ajax_sith_308th_order/ajax_sith_order_commander.mdl"},
    description = [[Commander of the 308th Security Order]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  "weapon_cuff_elastic", "unarrest_stick", "arrest_stick", "stun_stick"},
    command = "308CO",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "308th Order",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_403 = DarkRP.createJob("403rd Company E Sniper - Urban", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/grizzlerules/sithurbancamo/sithurbancamo.mdl"},
    description = [[Sniper of 403rd's Company E with urban camo]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_wsp_1" ,  "tfa_imperialdisruptor_extended"},
    command = "403UR",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "403rd",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})
TEAM_403 = DarkRP.createJob("403rd Company E Sniper - Forest", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/grizzlerules/sithforestcamo/sithforestcamo.mdl"},
    description = [[Sniper of 403rd's Company E with forest camo]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_wsp_1" ,  "tfa_imperialdisruptor_extended"},
    command = "403FR",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "403rd",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})
TEAM_403 = DarkRP.createJob("403rd Company E Sniper - Desert", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/grizzlerules/sithdesertcamo/sithdesertcamo.mdl"},
    description = [[Sniper of 403rd's Company E with desert camo]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_wsp_1" ,  "tfa_imperialdisruptor_extended"},
    command = "403DR",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "403rd",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})
TEAM_403 = DarkRP.createJob("403rd Company E Sniper - Frost", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/grizzlerules/sithfrostcamo/sithfrostcamo.mdl"},
    description = [[Sniper of 403rd's Company E with frost camo]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_wsp_1" ,  "tfa_imperialdisruptor_extended"},
    command = "403FRO",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "403rd",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})


TEAM_403 = DarkRP.createJob("403rd Commander", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/gingers_sith_green/gingers_sith_green_commander.mdl"},
    description = [[Commander of the 403rd, part of the Imperial Sniper Corps]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  "tfa_imperialdisruptor_extended"},
    command = "403CO",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "403rd",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_63 = DarkRP.createJob("63rd Trooper", {
    color = Color(200, 200, 200, 255),
    model = {"models/ajax/ajax_sith_901st_panzer/ajax_sith_panzer_jumptrooper.mdl"},
    description = [[A trooper of the 63rd Armored Infantry Division]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  "repair_tool"},
    command = "63TR",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "63rd Armored Infantry",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_63 = DarkRP.createJob("63rd Pilot", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/grizzlerules/sithpilot/sithpilot.mdl"},
    description = [[A trooper of the 63rd Armored Infantry Division]],
    weapons = {"salute","tfa_kotor_bp_5" ,  "tfa_kotor_br_2" , "cross_arms_swep", "tfa_kotor_repeaten_1" ,  "repair_tool"},
    command = "63PLT",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "63rd Armored Infantry",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_63 = DarkRP.createJob("63rd Commander", {
    color = Color(200, 200, 200, 255),
    model = {"models/sith_of_7/sithofficer7_pm.mdl"},
    description = [[Commander of the 63rd Armored Infantry Division]],
    weapons = {"salute","tfa_kotor_bp_5" , "cross_arms_swep", "repair_tool"},
    command = "63CO",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "63rd Armored Infantry",
	PlayerSpawn = function(ply) ply:SetHealth(200) ply:SetArmor(150) end,
})

TEAM_SITH = DarkRP.createJob("Sith Acolyte ", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/sith/human.mdl",
			"models/stickytar/players/femalesith.mdl",
			"models/player/sith/pantoran.mdl",
			"models/player/sith/zabrak.mdl",
			"models/player/sith/twilek.mdl",
			"models/player/sith/nautolan.mdl",
			"models/player/sith/togruta.mdl",
			"models/player/sith/gungan.mdl",
			"models/player/sith/trandoshan.mdl"},
    description = [[ A Sith acolyte has not yet completed his or her trials in the Sith Academy, and may well die before becoming truly “Sith.” ]],
    weapons = {"weapon_lightsaber_vibro2", "wos_inventory"},
    command = "ACOLM",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sith Acolytes",
	PlayerSpawn = function(ply) ply:SetHealth(250) ply:SetArmor(200) end,
})


TEAM_SITHAPP = DarkRP.createJob("Sith Apprentice", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/swtor/arsenic/nook/nook.mdl",
			"models/player/swtor/arsenic/star/star.mdl",
			"models/player/swtor/arsenic/croc2/croc.mdl"},
    description = [[ An acolyte who completes the trials and is accepted as the apprentice of a Sith Lord is considered Sith–no more, no less.]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "APPRNS",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sith Apprentices",
	PlayerSpawn = function(ply) ply:SetHealth(550) ply:SetArmor(200) end,
})


TEAM_SITHLORD = DarkRP.createJob("Sith Lord", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/swtor/arsenic/raeus/raeus.mdl",
			"models/player/swtor/arsenic/whiplash/exalkressh.mdl",
			"models/stickytar/players/femalesith2.mdl",
			"models/helios/talon2.mdl",
			"models/player/swtor/arsenic/croc2/croc.mdl"},
    description = [[ A Sith who advances in the order’s hierarchy will eventually be elevated to Sith Lord. His or her name is preceded by “Lord” in formal address.]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "LORDM",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sith Lords",
	PlayerSpawn = function(ply) ply:SetHealth(1500) ply:SetArmor(200) end,
})

TEAM_SITHLORD = DarkRP.createJob("Sith Lord Juggernaut", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/swtor/arsenic/viatic/viatic3.mdl",
	"models/player/swtor/arsenic/slactir/slactirtest2.mdl"},
    description = [[ Through diligence and clarity, Juggernauts shape the Force to their will to shrug off damage that would destroy others and fill foes with doubt and despair. ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "JUGGS",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sith Lords",
	PlayerSpawn = function(ply) ply:SetHealth(2000) ply:SetArmor(500) end,
})

TEAM_SITHLORD = DarkRP.createJob("Sith Lord Marauder", {
    color = Color(200, 200, 200, 255),
    model = {"models/banks/marauder/eg/egmarauder.mdl",
	"models/imagundi/rexlordskin/rex/rexlordskin.mdl"},
    description = [[ All Sith Marauders can wield two lightsabers in combat, crushing their foes with superior speed and becoming a terror on the battlefield.  ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory", "weapon_lightsaber_personal_dual"},
    command = "MARAUDS",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sith Lords",
	PlayerSpawn = function(ply) ply:SetHealth(1500) ply:SetArmor(200) end,
})




TEAM_SITHAPP = DarkRP.createJob("Sith  Inquisitor", {
    color = Color(200, 200, 200, 255),
    model = {"models/grealms/characters/inquisitor/inquisitor_01.mdl",
	"models/grealms/characters/inquisitor/inquisitor_02.mdl",
	"models/grealms/characters/inquisitor/inquisitor_03.mdl",
	"models/grealms/characters/inquisitor/inquisitor_04.mdl",
	"models/grealms/characters/inquisitor/inquisitor_05.mdl",
	"models/grealms/characters/inquisitor/inquisitor_06.mdl",
	"models/grealms/characters/inquisitor/inquisitor_07.mdl",
	"models/grealms/characters/inquisitor/inquisitor_08.mdl",
	"models/grealms/characters/inquisitor/inquisitor_09.mdl"
	},
    description = [[ Inquisitors overwhelm their targets with Force Lightning and lightsabers alike. ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "INQUISS",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sith Inquisitor",
	PlayerSpawn = function(ply) ply:SetHealth(1500) ply:SetArmor(200) end,
})

TEAM_SITHAPP = DarkRP.createJob("Sith  Sorcerer", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/swtor/arsenic/borth/body1.mdl",
	"models/player/swtor/arsenic/borth/body4.mdl",
	"models/gonzo/darthmalice/darthmalice.mdl",
	"models/player/swtor/arsenic/croc2/croc.mdl"
	},
    description = [[ Inquisitors overwhelm their targets with Force Lightning and lightsabers alike. ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "SORCER",
    max = 0,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Sith Inquisitor",
	PlayerSpawn = function(ply) ply:SetHealth(1500) ply:SetArmor(200) end,
})



TEAM_COUNCIL = DarkRP.createJob("Darth Nox", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/swtor/arsenic/bones/bones01.mdl"},
    description = [[ Part of the Dark Council” ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "THANAT",
    max = 1,
    salary = 100,
    admin = 2,
    vote = false,
    hasLicense = false,
    category = "Dark Council",
	PlayerLoadout = function(ply) ply:SetHealth(2500) ply:SetArmor(1000) end,
})
TEAM_COUNCIL = DarkRP.createJob("Darth Baras", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/valley/baras.mdl"},
    description = [[ Part of the Dark Council” ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "BARAS",
    max = 1,
    salary = 100,
    admin = 2,
    vote = false,
    hasLicense = false,
    category = "Dark Council",
	PlayerSpawn = function(ply) ply:SetHealth(2500) ply:SetArmor(1000) end,
})
TEAM_COUNCIL = DarkRP.createJob("Darth Marr", {
    color = Color(200, 200, 200, 255),
    model = {"models/grealms/characters/darthmarr/darthmarr.mdl"},
    description = [[ Part of the Dark Council” ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "MARR",
    max = 1,
    salary = 100,
    admin = 2,
    vote = false,
    hasLicense = false,
    category = "Dark Council",
	PlayerSpawn = function(ply) ply:SetHealth(2500) ply:SetArmor(1000) end,
})
TEAM_COUNCIL = DarkRP.createJob("Darth Jaku", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/swtor/arsenic/jason/jason.mdl"},
    description = [[ Part of the Dark Council” ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "JASJAK",
    max = 1,
    salary = 100,
    admin = 2,
    vote = false,
    hasLicense = false,
    category = "Dark Council",
	PlayerSpawn = function(ply) ply:SetHealth(2500) ply:SetArmor(1000) end,
})
TEAM_COUNCIL = DarkRP.createJob("Darth Malgus", {
    color = Color(200, 200, 200, 255),
    model = {"models/grealms/characters/malgus/malgus.mdl"},
    description = [[ Part of the Dark Council” ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "MALG",
    max = 1,
    salary = 100,
    admin = 2,
    vote = false,
    hasLicense = false,
    category = "Dark Council",
	PlayerSpawn = function(ply) ply:SetHealth(2500) ply:SetArmor(1000) end,
})
TEAM_COUNCIL = DarkRP.createJob("Darth Jadus", {
    color = Color(200, 200, 200, 255),
    model = {"models/grealms/characters/darthjadus/darthjadus.mdl"},
    description = [[ Part of the Dark Council” ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "JADUS",
    max = 1,
    salary = 100,
    admin = 2,
    vote = false,
    hasLicense = false,
    category = "Dark Council",
	PlayerSpawn = function(ply) ply:SetHealth(2500) ply:SetArmor(1000) end,
})
TEAM_COUNCIL = DarkRP.createJob("Darth Vowrawn", {
    color = Color(200, 200, 200, 255),
    model = {"models/player/swtor/arsenic/sabino/sabino.mdl"},
    description = [[ Part of the Dark Council” ]],
    weapons = {"weapon_lightsaber_personal", "wos_inventory"},
    command = "VOWR",
    max = 1,
    salary = 100,
    admin = 2,
    vote = false,
    hasLicense = false,
    category = "Dark Council",
	PlayerSpawn = function(ply) ply:SetHealth(2500) ply:SetArmor(1000) end,
})

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CADET


--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
	[TEAM_POLICE] = false,
	[TEAM_CHIEF] = false,
	[TEAM_MAYOR] = false,
}

--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_MOB)