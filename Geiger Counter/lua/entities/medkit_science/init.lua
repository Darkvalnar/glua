AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self.Entity:SetModel(self.Entity.Model)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.x = 100
	self.Radremove = 75
end

function ENT:Use(ply, caller)
	if (ply:IsPlayer()) then
		if ply:Health() + self.x < 100 then
			ply:SetHealth(ply:Health() + self.x)
		else
			ply:SetHealth(100)
		end

		if ply.srad.cnt > self.Radremove then
			ply.srad.cnt = ply.srad.cnt - self.Radremove
		else
			ply.srad.cnt = 0
		end
		self.Entity:Remove()
	end	
end