if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "Medic Kit"
SWEP.Author = "DarkRP Developers, Skilltree"
SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.Description = "Heals the wounded."
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Left click to heal someone\nRight click to heal yourself"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "DarkRP (Utility)"

SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.WorldModel = "models/weapons/w_medkit.mdl"
SWEP.UseHands = true

SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic  = true
SWEP.Primary.Delay = 0.1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Recoil = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = 0.3
SWEP.Secondary.Ammo = "none"

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local found
	local lastDot = -1 -- the opposite of what you're looking at
	self:GetOwner():LagCompensation(true)
	local aimVec = self:GetOwner():GetAimVector()

	for k,v in pairs(player.GetAll()) do
		local maxhealth = v:GetMaxHealth() or 100
		if v == self:GetOwner() or v:GetShootPos():Distance(self:GetOwner():GetShootPos()) > 85 or v:Health() >= maxhealth or not v:Alive() then continue end

		local direction = v:GetShootPos() - self:GetOwner():GetShootPos()
		direction:Normalize()
		local dot = direction:Dot(aimVec)

		-- Looking more in the direction of this player
		if dot > lastDot then
			lastDot = dot
			found = v
		end
	end
	self:GetOwner():LagCompensation(false)

	if SERVER then 
		local aoe = hook.Call( "SK_TREE_MUL", GAMEMODE, self.Owner, "heal_aoe", true )

		local pl = self.Owner:GetEyeTrace().Entity and self.Owner:GetEyeTrace().Entity:IsPlayer() and self.Owner:GetEyeTrace().Entity
		
		if pl and pl:Health() < pl:GetMaxHealth() then
			local newhealth = pl:Health() + 1 * ( 1 + hook.Call( "SK_TREE_MUL", GAMEMODE, self.Owner, "medic_training" ) )
		
			if ( newhealth > pl:GetMaxHealth() ) then newhealth = pl:GetMaxHealth() end
		
			pl:SetHealth( newhealth )
			local perc = math.Round( hook.Call( "SK_TREE_MUL", GAMEMODE, self.Owner, "good_fortune", true ) )
			local chanc = math.Rand( 1, 100 ) 
			
			if chanc <= perc and pl:Armor() < 100 then 
				local newarmor = pl:Armor() + 3
			
				if newarmor > 100 then newarmor = 100 end
			
				pl:SetArmor( newarmor )
			end
			
			self.Owner:EmitSound("hl1/fvox/boop.wav", 150, pl:Health() / pl:GetMaxHealth() * 100, 1)
		elseif aoe == 1 then
			local ent_sph = ents.FindInSphere( self.Owner:GetPos(), 50 )
			
			local plz = 0
			
			for k, v in pairs( ent_sph ) do
				if !v:IsPlayer() or v == self.Owner then continue end
				if ( v:Health() >= v:GetMaxHealth() ) then continue end
				
				local newhealth = v:Health() + 1 * ( 1 + hook.Call( "SK_TREE_MUL", GAMEMODE, self.Owner, "medic_training" ) )
		
				if ( newhealth > v:GetMaxHealth() ) then newhealth = v:GetMaxHealth() end
				
				plz = plz + 1
			end
			
			if plz > 0 then		
				for k, v in pairs( ent_sph ) do
					if !v:IsPlayer() or v == self.Owner then continue end
					print(1)
					if ( v:Health() >= v:GetMaxHealth() ) then continue end
					print(2)
					local newhealth = v:Health() + 1 * ( 1 + hook.Call( "SK_TREE_MUL", GAMEMODE, self.Owner, "medic_training" ) / plz * .5 )
		
					if ( newhealth > v:GetMaxHealth() ) then newhealth = v:GetMaxHealth() end
					
					v:SetHealth( newhealth )
					local perc = math.Round( hook.Call( "SK_TREE_MUL", GAMEMODE, self.Owner, "good_fortune", true ) / 2 )
					local chanc = math.Rand( 1, 100 ) 
					
					if chanc <= perc and v:Armor() < 100 then 
						local newarmor = v:Armor() + 3 / ( plz * 1.25 )
			
						if newarmor > 100 then newarmor = 100 end
					
						pl:SetArmor( newarmor )
					end
					
					self.Owner:EmitSound("hl1/fvox/boop.wav", 150, v:Health() / v:GetMaxHealth() * 100, 1)
				end
			end
		end
		
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	local ply = self:GetOwner()
	local maxhealth = self:GetOwner():GetMaxHealth() or 100
	if SERVER then
		if ply:Health() < maxhealth then
			ply:SetHealth(ply:Health() + 1 * ( 1 + hook.Call( "SK_TREE_MUL", GAMEMODE, self.Owner, "medic_training" ) ) )
			self.Owner:EmitSound("hl1/fvox/boop.wav", 150, ply:Health() / ply:GetMaxHealth() * 100, 1, CHAN_AUTO)
		end
	end
end
