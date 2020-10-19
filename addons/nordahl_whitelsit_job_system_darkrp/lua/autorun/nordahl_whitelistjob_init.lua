
if SERVER then
AddCSLuaFile("nordahl_cl/nordahl_whitelistjob_cl.lua")
include("nordahl_sv/nordahl_whitelistjob_sv.lua")
end

if CLIENT then
include("nordahl_cl/nordahl_whitelistjob_cl.lua")
end

print("Nordahl - Job Whitelist system - Init Ok")