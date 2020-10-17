/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "[VJ] Old Republic SNPCs"
local AddonName = "TOR"
local AddonType = "SNPCs"
local AutorunFile = "autorun/vj_tornpcs_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "[VJ] Hostile TOR NPCs" -- Category, you can also set a category individually by replacing the vCat with a string value
	
	
	--VJ.AddNPC_HUMAN("Havoc Trooper (HOSTILE)","npc_vj_hvc_havoc",{"weapon_vj_e5_edit"},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
		-- Parameters:
			-- First is the name, second is the class name
			-- Third is a table of weapon, the base will pick a random one from the table and give it to the SNPC when "Default Weapon" is selected
			-- Fourth is the category that it should be in
			-- Fifth is optional, which is a boolean that defines whether or not it's an admin-only entity
	--VJ.AddNPC_HUMAN("Havoc Trooper (FRIENDLY)","npc_vj_hvcfriend_havoc",{"weapon_vj_e5_edit"},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
	-------------------------------------------------------HOSTILE----------------------------------------------------------------------------
	VJ.AddNPC ("Rancor", "npc_vj_rancor_tor", vCat)
	VJ.AddNPC_HUMAN ("Hostile 81st Trooper", "npc_vj_trooper_81",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile 81st Officer", "npc_vj_officer_81",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile 81st Commander", "npc_vj_commander_81",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Havoc Squad Trooper", "npc_vj_trooper_havoc",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Havoc Squad Officer", "npc_vj_officer_havoc",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Havoc Squad Commander", "npc_vj_commander_havoc",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Vulture Squad Trooper", "npc_vj_trooper_vulture",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Vulture Squad Officer", "npc_vj_officer_vulture",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Vulture Squad Commander", "npc_vj_commander_vulture",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Republic Medic", "npc_vj_med_rep",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Republic Trooper", "npc_vj_trooper_standart",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Republic Officer", "npc_vj_officer_standart",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Republic Commander", "npc_vj_commander_standart",{"weapon_vj_kotor_blast2r"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Sith Trooper", "npc_vj_trooper_sith",{"weapon_vj_kotor_blast1"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Sith Medic", "npc_vj_med_sith",{"weapon_vj_kotor_blast1"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Sith Officer", "npc_vj_officer_sith",{"weapon_vj_kotor_blast1"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Sith Commander", "npc_vj_commander_sith",{"weapon_vj_kotor_blast1"},vCat)
	VJ.AddNPC_HUMAN ("Hostile 75th Legion Sith Trooper", "npc_vj_trooper_75",{"weapon_vj_kotor_blast1"},vCat)
	VJ.AddNPC_HUMAN ("Hostile 75th Legion Sith Officer", "npc_vj_officer_75",{"weapon_vj_kotor_blast1"},vCat)
	VJ.AddNPC_HUMAN ("Hostile 75th Legion Sith Commander", "npc_vj_commander_75",{"weapon_vj_kotor_blast1"},vCat)
	
	--------------------------FRIENDLY--------------------------------------------------------------------------------------------------------------------
	VJ.AddNPC_HUMAN ("Friendly 81st Trooper", "npc_vj_trooper_81f",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly 81st Officer", "npc_vj_officer_81f",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly 81st Commander", "npc_vj_commander_81f",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Havoc Squad Trooper", "npc_vj_trooper_havocf",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Havoc Squad Officer", "npc_vj_officer_havocf",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Havoc Squad Commander", "npc_vj_commander_havocf",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Vulture Squad Trooper", "npc_vj_trooper_vulturef",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Vulture Squad Officer", "npc_vj_officer_vulturef",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Vulture Squad Commander", "npc_vj_commander_vulturef",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Republic Trooper", "npc_vj_trooper_standartf",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Republic Medic", "npc_vj_med_repf",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Republic Officer", "npc_vj_officer_standartf",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Republic Commander", "npc_vj_commander_standartf",{"weapon_vj_kotor_blast2r"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Sith Trooper", "npc_vj_trooper_sithf",{"weapon_vj_kotor_blast1"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Sith Medic", "npc_vj_med_sithf",{"weapon_vj_kotor_blast1"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Sith Officer", "npc_vj_officer_sithf",{"weapon_vj_kotor_blast1"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly Sith Commander", "npc_vj_commander_sithf",{"weapon_vj_kotor_blast1"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly 75th Legion Sith Trooper", "npc_vj_trooper_75f",{"weapon_vj_kotor_blast1"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly 75th Legion Sith Officer", "npc_vj_officer_75f",{"weapon_vj_kotor_blast1"},"[VJ] Friendly TOR NPCs")
	VJ.AddNPC_HUMAN ("Friendly 75th Legion Sith Commander", "npc_vj_commander_75f",{"weapon_vj_kotor_blast1"},"[VJ] Friendly TOR NPCs")
	
	
	
	
	
	
	
	
	
	
	
	
	
	VJ.AddNPCWeapon("TOR SITH VJ Blaster", "weapon_vj_kotor_blast1")	
	VJ.AddNPCWeapon("TOR REPUBLIC VJ Blaster", "weapon_vj_kotor_blast2r")	
	
	-- ConVars --
	VJ.AddConVar("vj_dum_dummy_h",100) -- Example 1
	VJ.AddConVar("vj_dum_dummy_d",20) -- Example 2
	VJ.AddConVar("vj_snpcdamage", 100) -- Base damage of melee attacks

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end