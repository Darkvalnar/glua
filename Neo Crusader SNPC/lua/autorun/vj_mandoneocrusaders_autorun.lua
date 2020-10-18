/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "[VJ] Mandalorian Neo Crusaders SNPCs"
local AddonName = "NeoCrusaderSNPCs"
local AddonType = "SNPCs"
local AutorunFile = "autorun/vj_mandoneocrusaders_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "[VJ] Hostile Neo Crusaders" -- Category, you can also set a category individually by replacing the vCat with a string value
	
	
	--VJ.AddNPC_HUMAN("Havoc Trooper (HOSTILE)","npc_vj_hvc_havoc",{"weapon_vj_e5_edit"},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
		-- Parameters:
			-- First is the name, second is the class name
			-- Third is a table of weapon, the base will pick a random one from the table and give it to the SNPC when "Default Weapon" is selected
			-- Fourth is the category that it should be in
			-- Fifth is optional, which is a boolean that defines whether or not it's an admin-only entity
	--VJ.AddNPC_HUMAN("Havoc Trooper (FRIENDLY)","npc_vj_hvcfriend_havoc",{"weapon_vj_e5_edit"},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
	-------------------------------------------------------HOSTILE----------------------------------------------------------------------------
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 1", "npc_VJ_NCb",{"weapon_vj_dt"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 2", "npc_VJ_NCr",{"weapon_vj_dt"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 3", "npc_VJ_NCy",{"weapon_vj_dt"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 4", "npc_VJ_NCg",{"weapon_vj_dt"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 5", "npc_VJ_NCbl",{"weapon_vj_dt"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 6", "npc_VJ_NCb2",{"weapon_vj_dt"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 7", "npc_VJ_NCw",{"weapon_vj_dt"},vCat)
	VJ.AddNPC_HUMAN ("Hostile Neo Crusader 8", "npc_VJ_NCb3",{"weapon_vj_dt"},vCat)
	
	--------------------------FRIENDLY--------------------------------------------------------------------------------------------------------------------
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 1", "npc_VJ_NCbF",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 2", "npc_VJ_NCrF",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 3", "npc_VJ_NCyF",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 4", "npc_VJ_NCgF",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 5", "npc_VJ_NCblF",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 6", "npc_VJ_NCb2F",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 7", "npc_VJ_NCwF",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	VJ.AddNPC_HUMAN ("Friendly Neo Crusader 8", "npc_VJ_NCb3F",{"weapon_vj_dt"},"[VJ] Friendly Neo Crusaders")
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	VJ.AddNPCWeapon("VJ E11-D", "weapon_vj_dt")	
	
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