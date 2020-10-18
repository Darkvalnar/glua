if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "VJ E-11D"
SWEP.Author 					= ""
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
SWEP.WorldModel					= "models/weapons/w_E-11D.mdl"
SWEP.HoldType 					= "ar2"
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 6 -- Damage
SWEP.Primary.Force				= 5 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 50 -- Max amount of bullets per clip
SWEP.NPC_NextPrimaryFire = 0.20 -- Next time it can use primary fire
SWEP.Primary.Tracer				= 1
SWEP.Primary.TracerType	 		= "effect_sw_laser_red"
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= "weapons/star wars/e-11d_fire.wav"
SWEP.Primary.HasDistantSound	= true -- Does it have a distant sound when the gun is shot?
SWEP.Primary.Sound				= "weapons/star wars/e-11d_fire.wav"
SWEP.NPC_CustomSpread	= 0.67 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_DynamicLightColor = Color(255, 0, 0)
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoImpactEffect( tr, dmgtype )
	if( tr.HitSky ) then return true; end
	
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos )
	effectdata:SetScale( 1 )
	effectdata:SetMagnitude( 2 ) 
	util.Effect( "Sparks", effectdata, true, true )
	
	util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal );

	
	end