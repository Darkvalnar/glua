hook.Add("PlayerInitialSpawn", "CreateRadVariable", function(ply)
	ply.srad = {cnt = 0, buff = 0, candmg = true, timer = true}
end)	

hook.Add( "EntityTakeDamage", "SetArmorResist", function(ply, dmginfo)
	if ply:IsPlayer() then
		if dmginfo:GetDamageType() == 262144 and ply.srad.buff == 0 and ply:Alive() then
			dmginfo:ScaleDamage(0)
			if ply.stalkerarmor and ply.stalkerarmor.class ~= "" then
				ply.srad.cnt = ply.srad.cnt + 1 - ARMOR_STALKER[ply.stalkerarmor.class].RADIATION
			else
				ply.srad.cnt = ply.srad.cnt + 1
			end 
			if ply.srad.cnt > 500 and ply:Alive() then
				ply:Kill()
			end
		elseif dmginfo:GetDamageType() == 262144 then
			dmginfo:ScaleDamage(0)
		end
	end
end)

hook.Add("PlayerDeath", "ResetRadiation", function(ply)
	ply.srad.cnt = 0
	ply.srad.buff = 0
	ply.srad.candmg = true
end)

hook.Add("PlayerPostThink", "DamagePlayerRadiation", function(ply)
	if ply.srad.candmg then
		ply.srad.candmg = false
		if ply.srad.cnt > 100 and ply.srad.cnt < 200 then
			ply:SetHealth(ply:Health() - 1)
			timer.Simple(6, function() ply.srad.candmg = true end)
		elseif ply.srad.cnt >= 200 and ply.srad.cnt < 300 then
			ply:SetHealth(ply:Health() - 2)
			timer.Simple(5, function() ply.srad.candmg = true end)
		elseif ply.srad.cnt >= 300 then 
			ply:SetHealth(ply:Health() - 3)
			timer.Simple(4, function() ply.srad.candmg = true end)
		else
			timer.Simple(3, function() ply.srad.candmg = true end)
		end
		if ply:Health() < 1 and ply:Alive() then
			ply:Kill()
		end
	end

	if ply.srad.buff > 0 and ply.srad.timer then
		ply.srad.timer = false
		ply.srad.buff = ply.srad.buff - 1
		timer.Simple(1, function() ply.srad.timer = true end)
	end
end)