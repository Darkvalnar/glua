
local neo_crusader_random = { "models/epangelmatikes/npc/neo_crusader_a.mdl", "models/epangelmatikes/npc/neo_crusader_b.mdl", "models/epangelmatikes/npc/neo_crusader_c.mdl", "models/epangelmatikes/npc/neo_crusader_d.mdl", "models/epangelmatikes/npc/neo_crusader_e.mdl", "models/epangelmatikes/npc/neo_crusader_f.mdl", "models/epangelmatikes/npc/neo_crusader_g.mdl", "models/epangelmatikes/npc/neo_crusader_z.mdl" } 
---specify a local WITH THE MODELS WE HAVE

hook.Add( "PlayerSpawnedNPC", "RandomBodygroupNeoCrusader2", function(ply,npc) --ADD A HOOK, B I T C H, player spawns an NPC, execute function
		if table.HasValue( neo_crusader_random, npc:GetModel() ) then npc:SetBodygroup( 1, math.random(0,7) ); --if our table has the value of the specified local, get the NPC model and set bodygroup randomly
		npc:SetBodygroup( 2, math.random(0,7) ); --randomly sets bodygroup from 0 to 7
		npc:SetBodygroup( 3, math.random(0,4) ); --randomly sets bodygroup from 0 to 4
		npc:SetBodygroup( 4, math.random(0,7) ); --randomly sets bodygroup from 0 to 7
		npc:SetBodygroup( 5, math.random(0,9) ); --randomly sets bodygroup from 0 to 9
		npc:SetSkin		( 	 math.random(0,9 ) ) --randomly sets skin from 0 to 9
		end
end)

--[[
BIG THANKS and SHOUTOUT to my man Engys Epangelmatikes and Pliskin also to undead-servers.com, amazing work on these models guys.
Original Playermodels: https://steamcommunity.com/sharedfiles/filedetails/?id=1781317916
Creators:
https://steamcommunity.com/id/EngysEpangelmatikes
https://steamcommunity.com/profiles/76561198108248796


--]]