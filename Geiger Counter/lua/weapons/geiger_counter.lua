local swepmodel = "models/stalker/item/handhelds/datachik1.mdl" 
---------------------------------------------------------------------------------
SWEP.Base = "hand_base"
SWEP.PrintName	= "Geiger Counter"
SWEP.Author	= "Barney, Rawlings"
SWEP.Instructions	= "Left Click to display current rad levels"
SWEP.Category = "Geiger Counter"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic	= false
SWEP.Primary.Ammo	= "none"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo	= "none"

SWEP.Weight	= 5 
SWEP.AutoSwitchTo	= false
SWEP.AutoSwitchFrom	= false

SWEP.Slot	= 0
SWEP.SlotPos	= 1
SWEP.DrawCrosshair	= false

SWEP.DrawAmmo = true
SWEP.HoldType = "camera"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_eq_flashbang.mdl"
SWEP.WorldModel = swepmodel
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["v_weapon.Flashbang_Parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["geiger"] = { type = "Model", model = swepmodel, bone = "v_weapon.Flashbang_Parent", rel = "", pos = Vector(0, -1.5, 0), angle = Angle(180, 85, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["geiger_world"] = { type = "Model", model = swepmodel, bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 4, -1), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local radentities = {}
radentities["radiation_small"] = true
radentities["radiation_med"] = true
radentities["radiation_big"] = true

radioactive = {}
radioactive[1]= nil

function SWEP:PrimaryAttack() --fuck this entire function 
	if SERVER then 
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Radiation: "..self.Owner.srad.cnt) --Do I need this? 

	end

end

function SWEP:SecondaryAttack()
--nobody needs this
--could probablly draw a derma menu here for more custom shit...
PrintMessage(HUD_PRINTCENTER, radioactive[1])
end

function SWEP:Think()
	rad = CreateSound(self.Owner, "stalkerdetectors/geig2.wav")
	radiationradius = 1 --setting value to have something to work with
	--radiationradius = radiuval -- this literally saved my sanity, you have NO idea
	if SERVER then
		local anoms = {}
		for k, v in pairs(ents.GetAll()) do
			if radentities[string.lower(v:GetClass())] then
				table.insert(anoms, v)
				print (v:GetClass())
			end
		end
		local dist = 3000
		local ent = nil
		for k, v in pairs(anoms) do
			if v:GetPos():Distance(self.Owner:GetPos()) < dist then
				dist = v:GetPos():Distance(self.Owner:GetPos())
				ent = v_eq_flashbang
				radiationradius = radiuval
				--table.remove(radioactive)
				--table.insert(radioactive, radiationradius)
			end
		end
		if radiationradius == nil then --sanity check
			dist = 1
			radiationradius = 1
		elseif dist < radiationradius then --we're now in the vincinity of the radiation
			rad:Play()
			PrintMessage (HUD_PRINTTALK, radiationradius) --debug 
			--PrintMessage (HUD_PRINTCENTER, v:GetClass) --debug

		end
		if dist > radiationradius then 
			self.Owner:StopSound ("stalkerdetectors/geig2.wav") --ezclap, spent like 5 hours on a workaround until I remembered this fucking function
			--PrintMessage (HUD_PRINTTALK, "STOP") -- debug
		end
	end
end	

function SWEP:OnRemove()
end

function SWEP:GetViewModelPosition(position, angle)
	self:SetWeaponHoldType("pistol")
	local owner = self.Owner

	if(IsValid(owner)) then
		position = position + owner:GetRight() + owner:GetAimVector()*4 - owner:GetUp()*2
	end

	return position, angle
end

function SWEP:DrawWorldModel()
	local _Owner = self:GetOwner()

	if ( IsValid( _Owner ) ) then
		-- Specify a good position
		local offsetVec = Vector(5, -3, -2)
		local offsetAng = Angle(90, 180, 0)

		local boneid = _Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ) -- Right Hand
		if !boneid then return end

		local matrix = _Owner:GetBoneMatrix( boneid )
		if !matrix then return end

		local newPos, newAng = LocalToWorld( offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles() )

		self:SetPos( newPos )
		self:SetAngles( newAng )
		self:SetNoDraw(false)
		self:SetupBones()
		self:DrawModel()
	else
		self.ShowWorldModel = true
		self:DrawModel()
		self:SetNoDraw(false)
	end
end