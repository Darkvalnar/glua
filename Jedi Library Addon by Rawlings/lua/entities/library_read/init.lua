AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' ) 

--arg1 = EntID
--arg2 = Handshake
--arg3 = Title
--arg4 = URL
--arg5 = Height
local function UpdateBook(ply,cmd,args)
	local Book = Entity(tonumber(args[1]))
	if Book.Handshake ~= args[2] then
		Error(ply:Nick().." HAS FAILED THE HANDSHAKE FOR book_update!\n")
		return
	end
	http.Fetch(args[4],function(c) Book.Content = c end)
	Book.Title = args[3]
	Book.URL = args[4]
	Book.Height = args[5]
end

concommand.Add("book_update",UpdateBook)


function ENT:Initialize()
	self:SetModel( "models/elitelukas/imp/book_shelf.mdl" ) --this is the actual archive model, this guy better not eat my ass for using his prop 
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
end

function ENT:SpawnFunction(ply, tr)
	if ( !tr.Hit ) then return end
	local HS = ""
	local SpawnPos = tr.HitPos + tr.HitNormal * 88 --multiply it by 88 so it spawns nicely on the ground
	
	for i=0,10 do HS = HS..tostring(math.floor(math.random(0,9))) end
	
	self.Owner = ply
	self.URL = ""
	self.Title = ""
	self.Content = ""
	self.Height= 0
	self.Handshake = HS
	
	
	local ent = ents.Create("book_sent")
	ent:SetAngles(ply:GetAngles() + Angle(0,270,0))
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end

local readyes = 0 --- sets the status whether or not you read a story initially to 0, so NO
function storytime()
end 

function ENT:Use(Activator, Caller)
	if self.Title == "" then RunConsoleCommand("book_load",tostring(self:EntIndex()),self.Handshake) readyes=0 -- perform the normal load of the book selection
	elseif readyes>=1 then readyes=0 RunConsoleCommand("book_load", tostring(self:EntIndex()),self.Handshake) --if you read it once or more, set the read state back to 0 and and open up the normal book selection again
	else RunConsoleCommand("book_open",tostring(self:EntIndex()),self.Handshake,self.Title,self.URL,self.Height) readyes=1 
	--if none of the first two conditions apply, read the book fam, it's probably good 
	--Afterwards, change the read status to 1, because you read it, right?
	end
	

end


function ENT:Touch(ent)

end

