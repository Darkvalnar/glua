
local Leak_Protection_Status=[[OK]]

/* READ THIS BEFORE HAVE PROBLEM PLEASE,

If you find my work serious know they are all my other scripts here: https://originahl-scripts.com/gmod-scripts
I'm not only an simple coder you can see and support my creativity:

My Facebook Page: https://www.facebook.com/zworld.afterlife/
My Drawing: http://steamcommunity.com/id/zworld-dev/images/
My Steam Group: http://steamcommunity.com/groups/zworld-afterlife
My servers here: https://zworld-afterlife.com/fr/servers


----1.Script Activation & antileak----
Tout ce que tu dois savoir: https://originahl-scripts.com/fr/help
All you must know:  https://originahl-scripts.com/en/help

----2.Leak----
Our biggest issues here are people who purchase scripts, with the sole purpose of leaking them.
As a developer, if I see my scripts, or any other developer's scripts here for that matter leaked by a member of the ScriptFodder community,
rest assured that I will do everything in my power to ensure you fail.
This includes but not limited to, notifying a moderator / admin of ScriptFodder of your attempt to leak,
with proof of course (because we will find you); ensuring you are banned from the website.
Your access to my script completely revoked without any additional warning.
Your name publicly blasted, with SteamID, on any and all developer forums, including Facepunch.com.
As well as any Steam groups you may be part of (maybe even your friends).
And finally, a phone call to PayPal explaining who you are, and what you are attempting to do.
Which in the future can jeopardize your very own PayPal account and have it limited.
We are developers, this is partially how we make a living, and it helps support our families.
If you have an issue, simply tell me and I'll do everything in my power to fix it.
Attempting charge-backs is not the way to handle a business transaction.
If you are not a leaker, you have nothing to worry about, and I thank you for your purchase.

Keep in mind. The leak destroys the creation and the opportunity to see something new and different on Gmod.

----3.Copyright----
The Zworld-Afterlife scripts are placed at Copyright France since 2012.
zworld-afterlife.com© 2008-2015. Created by Nordahl
Do not publish without my authorization.

With my regards,
Thank You.

By Nordahl                                                                                                                                                                                                                                                                      76561198042689327 
If you find my work serious know they are all my other scripts here: https://originahl-scripts.com/gmod-scripts                                                                                                                                                                                                                                                                     76561198042689327                      
*/

local WJL_CONFIG=nordahl_cfg_1402

local Nordah_Whitelist_Job = Nordah_Whitelist_Job or {}
local dontreadasecondtime=nil

local Add_Job_In_the_Whiteliste = {}
local ZJOBwhitelist={}

local ztvo=0.02 --More this number is big more the download of data is slow. antivorflow system. Default value is 0.01 (0 = zero second of delay Too much information is sent your crash server if you have a big list)

local function eRight(a)
if a:SteamID()==WJL_CONFIG.OwnerSteamID then return true end
if a:IsAdmin()==true then if WJL_CONFIG.Allow_Admin==1 then return true end end
if a:IsSuperAdmin()==true then if WJL_CONFIG.Allow_SUPER_Admin==1 then return true end end
for _,c in ipairs(WJL_CONFIG.Allow_ULX_GROUP_CAN_ACCESS_PANEL)do if a:IsUserGroup(c) then return true end end
for _,c in ipairs(WJL_CONFIG.Allow_JOB_CAN_ADD_INWHITLIST)do if c==team.GetName( a:Team() ) then return true end end
if serverguard then for _,c in ipairs(WJL_CONFIG.SERVERGUARD_Access_rank)do if serverguard.player:GetRank(a)==c then return true end end end
return false
end

local norrep=0
local function optim(a,b,c)
if eRight(a)==true then
if c[1]==nil then
if norrep==0 then norrep=norrep+1 
print("Nordahl: 'Hello, :) Your command is not complet. Instert the number of month to delete the old entries, like 'whitelist_suppressor_oldentries 4' to remove entries older than 4 months. Don't make me repeat please. ^^'") 
elseif norrep==1 then norrep=norrep+1 
print("Nordahl: 'You?  Read my previous message please... USES THE NUMBERS!!!'")
elseif norrep==2 then norrep=norrep+1 
print("Nordahl: 'Anyway... Good luck :3'")
else
print("Nordahl: '...'")
end
return end
local m=os.date("%m")-c[1]
local y
local mo
if m<=0 then
m=m+12
y=(os.date("%Y")-1)
else
y=(os.date("%Y"))
end
if m<10 then mo="0" else mo="" end
local res=os.date(y.." / "..mo..m.." / %d")
print("All entrie more old than '(YYYY / MM / DD) "..os.date(y.." / "..mo..m.." / %d").."' will be deleted")
for k,v in pairs(ZJOBwhitelist)do
local dt=string.Explode( " ", v[5] )
local n=string.Explode( "/", dt[1] )
local jleJ=n[2]
local jlem=n[1]
local jleAn="20"..n[3]
local nomb=0
if os.date(jleAn.." / "..jlem.." / "..jleJ)<=res then
nomb=nomb+1
table.remove(ZJOBwhitelist,k)
print("Whitelist Job number Entries deleted: "..nomb)
end
end
file.Write( "zwhitelistjobdata/whitelistjob.txt",util.TableToJSON(ZJOBwhitelist))
end
end
concommand.Add("whitelist_suppressor_oldentries",optim)

if WJL_CONFIG.USeWorkshopContent==1 then
resource.AddWorkshop("493897275")
end
if WJL_CONFIG.F1_to_Open_WHitelsitjob==1 then
local function ShowHelp(ply)
ply:ConCommand("whitelist_systemjob")
return false
end
hook.Add("ShowHelp", "Nord_ShowHelp", ShowHelp)
end
if WJL_CONFIG.F2_to_Open_WHitelsitjob==1 then
local function ShowTeam(ply)
ply:ConCommand("whitelist_systemjob")
return false
end
hook.Add("ShowTeam", "Nord_ShowTeam", ShowTeam)
end
if WJL_CONFIG.F3_to_Open_WHitelsitjob==1 then
local function ShowSpare1(ply)
ply:ConCommand("whitelist_systemjob")
return false
end
hook.Add("ShowSpare1", "Nord_ShowSpare1", ShowSpare1)
end
if WJL_CONFIG.F4_to_Open_WHitelsitjob==1 then
local function ShowSpare2(ply)
ply:ConCommand("whitelist_systemjob")
return false
end
hook.Add("ShowSpare2", "Nord_ShowSpare2", ShowSpare2)
end
if dontreadasecondtime==nil then
dontreadasecondtime=1
ZJOBwhitelist={}
local str= file.Read( "zwhitelistjobdata/whitelistjob.txt", "DATA" )
if str==nil then
file.CreateDir("zwhitelistjobdata")
file.Write( "zwhitelistjobdata/whitelistjob.txt", "[]" )
else
local tbl = util.JSONToTable( str )
for k,v in pairs(tbl)do
table.insert(ZJOBwhitelist,v)
end
end

Add_Job_In_the_Whiteliste = {}
local str= file.Read( "zwhitelistjobdata/jobsetting.txt", "DATA" )
if str==nil then
file.CreateDir("zwhitelistjobdata")
file.Write( "zwhitelistjobdata/jobsetting.txt", "[]" )
else
local tbl = util.JSONToTable( str )
for i,o in pairs(tbl)do
Add_Job_In_the_Whiteliste[i]=o
end
end
end

function Nordah_Whitelist_Job.AddCommand( func, name )
local newfunc = function( ply, cmd, args ) 
local target = Nordah_Whitelist_Job.GetPlayer( args[1] )
if name=="wjs_goto" or name=="wjs_bring" then 
else
if not target or not eRight(ply) or(ply==target and name=="wjs_superadmin") then return end 
end
func( ply, cmd, args ) 
end
concommand.Add( name, newfunc )
end

function Nordah_Whitelist_Job.GetPlayer( id )
if id==nil then return end
local ply = Entity( id )
if not IsValid( ply ) or not ply:IsPlayer() then return end
return ply
end
Nordah_Whitelist_Job.Commands = {}
--Nordah_Whitelist_Job.Tabs = {}
function Nordah_Whitelist_Job.RegisterCommand( name, commandname, chatcmd, args, override )
table.insert( Nordah_Whitelist_Job.Commands, { Name = name, CommandName = commandname, ChatCmd = chatcmd, Args = args, ArgOverride = override } )
end

util.AddNetworkString("SynchAllJobWhitelisted")
util.AddNetworkString("SynchAddJobwhitelist")
util.AddNetworkString("NSynchAddJob")
local function JobWriteToFile()
file.Write( "zwhitelistjobdata/whitelistjob.txt",util.TableToJSON(ZJOBwhitelist))
MsgN( "[Update Plugin] Whitelist.")
end
local function JobListToFile()
file.Write( "zwhitelistjobdata/jobsetting.txt",util.TableToJSON(Add_Job_In_the_Whiteliste))
MsgN( "[Update Plugin] JobList.")
end
local function JobSynchAddwhite(pl,id,rs,met,date,remove)
net.Start("SynchAddJobwhitelist")
net.WriteString(pl)
net.WriteString(id)
net.WriteString(rs)
net.WriteString(met)
net.WriteString(date)
net.WriteBit(tobool(remove))
net.Broadcast()
end

function Nordah_Whitelist_Job.AddWhitelist(tbl)
local heisinjob=false
for k,v in pairs(ZJOBwhitelist)do
if (v[2]==tbl[2])and(tbl[4]==v[4])then
MsgN( "TRUE")
heisinjob=true
--return
end
end
print("Pass")
if heisinjob==true then
MsgN( "[Update Plugin] msg id 1: Whitelist is not updated because this user exist in this list of Job.")
return
end

table.insert(ZJOBwhitelist,tbl)
JobWriteToFile()
JobSynchAddwhite(tbl[1],tbl[2],tbl[3],tbl[4],tbl[5])
end
function Nordah_Whitelist_Job.RemoveJobWhitelist(steamid,job)
for k,v in pairs(ZJOBwhitelist)do
if v[2]==steamid and v[4]==job then
table.remove(ZJOBwhitelist,k)
JobWriteToFile()
JobSynchAddwhite(steamid,"","","","",true)
return
end
end
end
function Nordah_Whitelist_Job.RemoveJobWhitelist5(steamid)
JobSynchAddwhite(steamid,"","","","",true)
end
local function RemoveJobWhitelist(ply,cmd,args)
if not eRight(ply) or not args[1]then return end
Nordah_Whitelist_Job.RemoveJobWhitelist(args[1],args[2])
end
concommand.Add("wjs_remove_whitelist",RemoveJobWhitelist)
local function AddWhitelist(ply,cmd,args)
if not eRight(ply) or not args[1]or not args[2]then return end
Nordah_Whitelist_Job.AddWhitelist{ply:Name(),args[1],args[2],args[3],tostring( os.date() )}
end
concommand.Add("wjs_add_whitelist",AddWhitelist)


local function Metajourmalist(a,b,c)
if eRight(a)==true then
if tostring(c[2])=="0" then
Add_Job_In_the_Whiteliste[c[1]]=nil
else
Add_Job_In_the_Whiteliste[c[1]]=c[2]
end
for k,v in pairs( player.GetAll() ) do
if eRight(v)==true then
net.Start("NSynchAddJob")net.WriteString(c[1])net.WriteString(c[2])net.Send(v)
end
end
JobListToFile()
end
end
concommand.Add("Metajourmalist",Metajourmalist)


local function get_j_t(j_nu)
for k,v in SortedPairsByMemberValue(team.GetAllTeams(), "Name") do
if "Citizen"!=v.Name then
if j_nu==nil or "0" then
Add_Job_In_the_Whiteliste[v.Name]=j_nu
elseif j_nu=="1" then
Add_Job_In_the_Whiteliste[v.Name]=j_nu
elseif j_nu=="2" then
Add_Job_In_the_Whiteliste[v.Name]=j_nu
elseif j_nu=="3" then
Add_Job_In_the_Whiteliste[v.Name]=j_nu
end
end
end
JobListToFile()
end

local function Metajourmalist_G(a,b,c)
if eRight(a)==true then
local j_nu=tostring(c[1])
get_j_t(j_nu)
for k,v in pairs( player.GetAll() ) do
if eRight(v)==true then
v:ConCommand("Metajolist_f_G "..j_nu)
end
end
end
end
concommand.Add("Metajourmalist_G",Metajourmalist_G)

local function MetajolistDe(a,b,c)
if eRight(a)==true then
Add_Job_In_the_Whiteliste={}
for k,v in pairs( player.GetAll() ) do
if eRight(v)==true then
v:ConCommand("Metajolistcl")
end
end
JobListToFile()
end
end
concommand.Add("MetajolistDe",MetajolistDe)

function hookselection(gmjobwhitel)
if WJL_CONFIG.overrides_custom_heck==0 then print("WJL_CONFIG.overrides_custom_heck is == 0 the system is disabled") return end
if gmjobwhitel=="1" then
print("Nordahl Whitelist Job System: Enabled")
hook.Add("playerCanChangeTeam", "Nordahl_Job_Whitelist", function(a,b,c)
local meti=team.GetAllTeams()[b].Name
local d=Add_Job_In_the_Whiteliste[meti]
-- VIEUX / OLD
-- if d==nil then
-- return true
-- elseif d=="1" then
-- if PlychangeAllowed(a,meti)==true then return true end
-- return false,"You are not Whitelisted"
-- elseif d=="2" then
-- return false,"JOB LOCKED"
-- elseif d=="3" then
-- if PlychangeAllowed2(a,meti)==true then return true end
-- return false,"Job reserved for the donators"
-- end
if d=="1" then
if PlychangeAllowed(a,meti)!=true then
return false,"You are not Whitelisted"
end
elseif d=="2" then
return false,"JOB LOCKED"
elseif d=="3" then
if PlychangeAllowed2(a,meti)!=true then
return false,"Job reserved for the donators"
end
end
end)
else
print("Nordahl Whitelist Job System: Disabled")
hook.Remove("playerCanChangeTeam","Nordahl_Job_Whitelist")
end
end

function sysjobwhitelist(ply,nom,aze)
if eRight(ply) then 
file.Write("zmodserveroption/sysjobwhitelist.txt",tostring(aze[1]))
gmjobwhitel=tostring(aze[1])
for k,v in pairs ( player.GetAll() ) do
v:ConCommand("ntsysjobwi "..tostring(aze[1]))
end
hookselection(gmjobwhitel)
end
end
concommand.Add("sysjobwhitelist",sysjobwhitelist)

local files=file.Read("zmodserveroption/sysjobwhitelist.txt", "DATA")
if (!files) then
file.CreateDir("zmodserveroption")
file.Write("zmodserveroption/sysjobwhitelist.txt","1")
gmjobwhitel="1"
hookselection(gmjobwhitel)
else
gmjobwhitel=file.Read("zmodserveroption/sysjobwhitelist.txt","DATA")
hookselection(gmjobwhitel)
end




if WJL_CONFIG.Donator_Rank_Tester==1 then
function nordahl_donator_rank_tester(ply,b,c)
MsgAll("----------------------------------------------nordahl_donator_tester BEGIN----------------------------------------------------")MsgAll(" ")
MsgAll("1.Script Test:")
MsgAll("    1.1) Your user Rank=                                                           ",ply:GetUserGroup())
MsgAll("    1.2) Donator Rank name set in the script line 48: WJL_CONFIG.ULX_DONATOR_RANK= ",WJL_CONFIG.ULX_DONATOR_RANK)
MsgAll("    1.3) Your user Group is = Donator Rank set in the script:                      ",ply:GetUserGroup() == WJL_CONFIG.ULX_DONATOR_RANK)
MsgAll(" ")
MsgAll("2.In Some Words:")
local fonctionne=false
for _,c in ipairs(WJL_CONFIG.ULX_DONATOR_RANK)do
if c==ply:GetUserGroup() then
fonctionne=true
end 
end

if fonctionne==true then
MsgAll("    2.1) Work for your rank:                                                        "..ply:GetUserGroup())
else
MsgAll("    2.1) Dont work for you, you are    :                                            "..ply:GetUserGroup())
MsgAll("    2.1) If you are donator it's supposed work Go line 48 change the word 'donator' to fix it.")
end

MsgAll(" ")
MsgAll("---------------------------------------------nordahl_donator_tester FINISHED---------------------------------------------------")

end
concommand.Add("nordahl_donator_rank_tester",nordahl_donator_rank_tester)
end

function PlychangeAllowed(ply,job)
local SteamID64=ply:SteamID64()
local Job=job
for k,v in pairs(ZJOBwhitelist)do
if v[2]==SteamID64 then
if Job==v[4] or v[4]=="Full Access" then
return true
end
end
end
if Add_Job_In_the_Whiteliste[Job]=="3" then
for _,c in ipairs(WJL_CONFIG.ULX_DONATOR_RANK)do if c==ply:GetUserGroup() then return true end end
end
return false
end
concommand.Add("PlychangeAllowed",PlychangeAllowed)

function PlychangeAllowed2(a,b)
local SteamID64=a:SteamID64()
local d=b
for k,v in pairs(ZJOBwhitelist)do
if v[2]==SteamID64 then
if v[4]=="Full Access" then
return true
end
end
end
if Add_Job_In_the_Whiteliste[d]=="3" then
for _,c in ipairs(WJL_CONFIG.ULX_DONATOR_RANK)do if c==a:GetUserGroup() then return true end end
end
return false
end

function CAddWhiteList(a,b,c)
if a:IsPlayer() then
if eRight(a)==false then
print("You Are Not Admin")
return
end
end
for k,v in pairs(ZJOBwhitelist)do
if v[2]==c[2] then
if c[4]==v[4] then
print("SteamID64 already exists for this job")
return
end
end
end

if c[1]==nil then
print("[Your command is not complet] Your Sended: Addwhitelist ??? ??? ??? ???")
print("The Format of Complet Command: Addwhitelist "..'"'.."Yourname"..'"'.." "..'"'.."SteamID64"..'"'.." "..'"'.."Nameofplayer"..'"'.." "..'"'.."JobName"..'"'.."")
return
end
if c[2]==nil then
print("[Your command is not complet]Your Sended: Addwhitelist Yourname ??? ??? ???")
print("The Format of Complet Command: Addwhitelist "..'"'.."Yourname"..'"'.." "..'"'.."SteamID64"..'"'.." "..'"'.."Nameofplayer"..'"'.." "..'"'.."JobName"..'"'.."")
return
end
if c[3]==nil then
print("[Your command is not complet]Your Sended: Addwhitelist Yourname SteamID64 ??? ???")
print("The Format of Complet Command: Addwhitelist "..'"'.."Yourname"..'"'.." "..'"'.."SteamID64"..'"'.." "..'"'.."Nameofplayer"..'"'.." "..'"'.."JobName"..'"'.."")
return
end
if c[4]==nil then
print("[Your command is not complet]Your Sended: Addwhitelist Yourname SteamID64 Nameofplayer ???")
print("The Format of Complet Command: Addwhitelist "..'"'.."Yourname"..'"'.." "..'"'.."SteamID64"..'"'.." "..'"'.."Nameofplayer"..'"'.." "..'"'.."JobName"..'"'.."")
return
end
Nordah_Whitelist_Job.AddWhitelist({c[1],c[2],c[3],c[4],tostring( os.date() )})
end
concommand.Add("Addwhitelist",CAddWhiteList)

function CMassRemovewhitelist(a,b,c)
if a:IsPlayer() then
if eRight(a)==false then
print("You Are Not Admin")
return
end
end
if c[1]==nil then
print("[Your command is not complet] Your Sended: Massremovewhitelist ???")
print("Where is the STEAM64? Replace ??? by steamid64")
return
end
print("Nordahl_Whitelist_Job_system: Massremovewhitelist")
local function testencore()
for k,v in pairs(ZJOBwhitelist)do
if v[2]==c[1] then
print(v[2].." Is removed from "..v[4])
table.remove(ZJOBwhitelist,k)
Nordah_Whitelist_Job.RemoveJobWhitelist5(c[1])
testencore()
return
end
end
end
testencore()

file.Write( "zwhitelistjobdata/whitelistjob.txt",util.TableToJSON(ZJOBwhitelist))
end
concommand.Add("Massremovewhitelist",CMassRemovewhitelist)


local function cleanup_joblist(a,b,c)
if a:IsPlayer() then
if eRight(a)==false then
print("You Are Not Admin")
return
else
for k,v in pairs(ZJOBwhitelist)do
if v[4]==c[1] then
ZJOBwhitelist[k]=nil
end
end
print("Whitelist Job System: '"..c[1].."' CLEANUP DONE")
end
else
for k,v in pairs(ZJOBwhitelist)do
if v[4]==a then
ZJOBwhitelist[k]=nil
end
end
print("Whitelist Job System: '"..a.."' CLEANUP DONE")
end
file.Write( "zwhitelistjobdata/whitelistjob.txt",util.TableToJSON(ZJOBwhitelist))
end
concommand.Add("cleanup_joblist",cleanup_joblist)



local function AddWhiteListPlayer(ply,cmd,args)
local target=Nordah_Whitelist_Job.GetPlayer(args[1])
if target then
if eRight(ply) then
local reason=""
for i=2,#args do
reason=reason..tostring(args[i])
end
local heisinjob=false
for k,v in pairs(ZJOBwhitelist)do
if (v[2]==target:SteamID64())and(args[2]==v[4])then
MsgN( "TRUE")
heisinjob=true
--return
end
end
print("Pass")
if heisinjob==true then
MsgN( "[Update Plugin] msg id 2: Whitelist is not updated because this user exist in this list of Job.")
return
end
MsgAll("[JOB Whitelist Plugin] "..target:GetName().." was added in Job-WhiteList by ",ply)
Nordah_Whitelist_Job.AddWhitelist{ply:Name(),target:SteamID64(),target:Name(),args[2],tostring( os.date() )}
elseif eRight(ply) then
admincommandst(ply)
end
end
end
Nordah_Whitelist_Job.AddCommand(AddWhiteListPlayer,"wjs_addwhite")

local function AddWhitewjs_addbuto(ply,cmd,args)
local identifiant=args[1]
local lenom=args[2]
local travail=args[3]
if eRight(ply) then
local reason=""
for i=2,#args do
reason=reason..tostring(args[i])
end
local heisinjob=false
for k,v in pairs(ZJOBwhitelist)do
if (v[2]==identifiant)and(travail==v[4])then
MsgN( "TRUE")
heisinjob=true
--return
end
end
print("Pass")
if heisinjob==true then
MsgN( "[Update Plugin] msg id 2: Whitelist is not updated because this user exist in this list of Job.")
return
end
MsgAll("[JOB Whitelist Plugin] "..lenom.." was added in Job-WhiteList by ",ply)
Nordah_Whitelist_Job.AddWhitelist{ply:Name(),identifiant,lenom,travail,tostring( os.date() )}
elseif eRight(ply) then
admincommandst(ply)
end
end
--Nordah_Whitelist_Job.AddCommand(AddWhitewjs_addbuto,"wjs_addbuto")
concommand.Add("wjs_addbuto",AddWhitewjs_addbuto)


local function ZWUnd_1(a,tab,Jlist)
if eRight(a)==true then
a:ConCommand("whitelist_update "..tostring(table.Count(tab)).." "..tostring(table.Count(Jlist)).." "..tostring(gmjobwhitel))
if table.Count(Jlist)>0 then
for c,d in pairs(Jlist)do
a.num9=a.num9+ztvo timer.Simple(a.num9,function() if IsValid(a) then net.Start("NSynchAddJob")net.WriteString(c)net.WriteString(d)net.Send(a) else return end end)
end
end
end
end

local function ZWUnd_2(a,tab)
if eRight(a)==true then
for c,d in pairs(tab)do
a.num9=a.num9+ztvo timer.Simple(a.num9,function() if IsValid(a) then net.Start("SynchAllJobWhitelisted")net.WriteString(d[1])net.WriteString(d[2])net.WriteString(d[3])net.WriteString(d[4])net.WriteString(d[5])net.Send(a) else return end end)
end
else
for c,d in pairs(tab)do
if a:SteamID64()==d[2] then
a.num9=a.num9+ztvo timer.Simple(a.num9,function() if IsValid(a) then net.Start("SynchAllJobWhitelisted")net.WriteString(d[1])net.WriteString(d[2])net.WriteString(d[3])net.WriteString(d[4])net.WriteString(d[5])net.Send(a) else return end end)
end
end
end
end

function ZWUnd_SynchroConnect(a)
a.num9=0
local a=a
local idx=a:EntIndex()
local tab=ZJOBwhitelist
local Jlist=Add_Job_In_the_Whiteliste
if serverguard then
timer.Create("whitelsitjob_bynord1_"..idx,5,1,function()ZWUnd_1(a,tab,Jlist)end)
else
ZWUnd_1(a,tab,Jlist)
end

if tab[1]then
if serverguard then
timer.Create("whitelsitjob_bynord2_"..idx,5,1,function()ZWUnd_2(a,tab)end)
else
ZWUnd_2(a,tab)
end
end
end
hook.Add("PlayerInitialSpawn", "ZWUnd_SynchroConnect", ZWUnd_SynchroConnect)

print("Nordahl JOB WhiteList System: OK")