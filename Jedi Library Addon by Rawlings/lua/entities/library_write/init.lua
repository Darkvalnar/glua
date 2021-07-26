AddCSLuaFile( "cl_init.lua" ) --we need this to be loaded on clientside in order to function properly 
AddCSLuaFile( "shared.lua" )

util.AddNetworkString( "writelore" ) --the string we will use later in our actual writing entity

function ENT:Initialize() --we will intitialize the actual entity as it is being shown ingame

	self:setModel("models/elitelukas/imp/book_shelf.mdl") --which model to use for this entity? 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then

	phys:Wake()
	end

self:SetUseType(SIMPLE_USE) --press E once on it

end

function ENT:Use( ply ) --if player presses E on the entity
if is Valid (ply ) && ply:IsPlayer() then --then......
	net.Start ( "writelore" ) --send our previously declared network string to the actual writing script
	net.Send( ply )
	end
end
