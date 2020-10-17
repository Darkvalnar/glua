
local bf3_models = { "models/npc/trandoshanheavy.mdl", "models/npc/trandoshanmerc1.mdl", "models/npc/trandoshanmerc2.mdl", "models/npc/trandoshanmerc3.mdl", "models/npc/trandoshanmerc4.mdl", "models/npc/trandoshanmerc5.mdl", "models/npc/trandoshanslaver.mdl" } ---specify a local WITH THE MODELS WE HAVE

hook.Add( "PlayerSpawnedNPC", "RandomBodygroupcitizen2", function(ply,npc) --ADD A HOOK, B I T C H, player spawns an NPC, execute function
		if table.HasValue( bf3_models, npc:GetModel() ) then npc:SetBodygroup( 1, math.random(0,1) ); --if our table has the value of the specified local, get the NPC model and set bodygroup randomly
		npc:SetBodygroup( 2, math.random(0,1) ); --randomly sets bodygroup from 0 to 7
		npc:SetBodygroup( 3, math.random(0,1) ); --randomly sets bodygroup from 0 to 4
		npc:SetBodygroup( 4, math.random(0,2) ); --randomly sets bodygroup from 0 to 7
		npc:SetBodygroup( 5, math.random(0,2) ); --randomly sets bodygroup from 0 to 9
		npc:SetBodygroup( 6, math.random(0,2) ); --randomly sets bodygroup from 0 to 9
		npc:SetBodygroup( 7, math.random(0,2) ); --randomly sets bodygroup from 0 to 9
		npc:SetBodygroup( 8, math.random(0,2) ); --randomly sets bodygroup from 0 to 9
		npc:SetBodygroup( 9, math.random(0,2) ); --randomly sets bodygroup from 0 to 9
		npc:SetBodygroup( 10,math.random(0,2) ); --randomly sets bodygroup from 0 to 9
		
		npc:SetBodygroup (11,math.random(0,7) ); --randomly sets bodygroup 11 from 0 to 7
		npc:SetSkin		( 	 math.random(0,9 ) ) --randomly sets skin from 0 to 9
		end
end)

--[[
BIG THANKS and SHOUTOUT to my man James_UK from Steam Workshop for making these amazing Republic Commando Trandoshans. 

--]]