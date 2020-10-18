-----------НАСТРОЙКИ-------------------------------------------------------
local swepmodel = "models/stalker/item/handhelds/datachik1.mdl" -- модель
---------------------------------------------------------------------------------
SWEP.Base = "hand_base"
SWEP.PrintName	= "Geiger Counter"
SWEP.Author	= "Barney"
SWEP.Instructions	= "ЛКМ - отобразить количество радиации на персонаже"
SWEP.Category = "Stalker Radiation"

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

local anomalies = {}
anomalies["radiation_small"] = true
anomalies["radiation_med"] = true
anomalies["radiation_big"] = true


function SWEP:PrimaryAttack()
	rad = CreateSound(self.Owner, "stalkerdetectors/geig2.wav")
	if SERVER then
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Radiation: "..self.Owner.srad.cnt)
		--rad:Play()
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	rad = CreateSound(self.Owner, "stalkerdetectors/geig2.wav")
	if CLIENT then
		local anoms = {}
		for k, v in pairs(ents.GetAll()) do
			if anomalies[string.lower(v:GetClass())] then
				table.insert(anoms, v)
			end
		end
		local dist = 501
		local ent = nil
		for k, v in pairs(anoms) do
			if v:GetPos():Distance(self.Owner:GetPos()) < dist then
				dist = v:GetPos():Distance(self.Owner:GetPos())
				ent = v_eq_flashbang
			end
		end
		if dist < 500 then
			rad:Play()
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