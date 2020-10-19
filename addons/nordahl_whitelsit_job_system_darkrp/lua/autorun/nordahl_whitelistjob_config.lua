nordahl_cfg_1402 = nordahl_cfg_1402 	or {}
--------------------------------------------------------------VERSION---------------------------------------------------------
local Ver="3.7.1"
if NCS_VER==nil then
NCS_VER={}
NCS_VER["nordahl_whitelsit_job_system_darkrp"]=Ver
else
NCS_VER["nordahl_whitelsit_job_system_darkrp"]=Ver
end
nordahl_cfg_1402.Ver=Ver
--------------------------------------------------------------CONFIGURATION---------------------------------------------------------
nordahl_cfg_1402.OwnerSteamID="STEAM_0:0:00000000000" --"STEAM_0:1:36759270" --If you are the owner and you dont use Admin System put your Steam ID here. Value exemple: ---> "STEAM_0:1:125347606"                               {{ user.id }}
nordahl_cfg_1402.F1_to_Open_WHitelsitjob=1 --0 = Disable, You Can open with F1 if the value is = 1. 
nordahl_cfg_1402.F2_to_Open_WHitelsitjob=0 --0 = Disable, You Can open with F2 if the value is = 1. 
nordahl_cfg_1402.F3_to_Open_WHitelsitjob=0 --0 = Disable, You Can open with F3 if the value is = 1. 
nordahl_cfg_1402.F4_to_Open_WHitelsitjob=0 --0 = Disable, You Can open with F4 if the value is = 1. 
nordahl_cfg_1402.Allow_Admin=1
nordahl_cfg_1402.Allow_SUPER_Admin=1
nordahl_cfg_1402.Allow_ULX_GROUP_CAN_ACCESS_PANEL={"superadmin","admin", "senioradmin", "seniormod", "moderator", "tmod", "gamemaster"} --Add ULX Admin Group if you want add "admin" ULX rank and another {"superadmin","admin","anothergroup"}
nordahl_cfg_1402.SERVERGUARD_Access_rank={"superadmin","admin"} --Add ServerGuard Admin Group if you want add "admin" {"superadmin","admin","anothergroup"} if you dont have Server Guard installed keep it empty.
nordahl_cfg_1402.Allow_JOB_CAN_ADD_INWHITLIST={} -- In this exemple Mayor can add players in white list Job Can add player in whitelist do like it if you wan tadd more follow this exemple: {"Mayor","Anotherjob","Anotherjob"} to keep it empty like it: {}
nordahl_cfg_1402.USeWorkshopContent=1 --If you dont have a fastdownload you can use workshop content (1 Enable "I want use workshop" / 0 Disable "I prefer use my fastdl")
nordahl_cfg_1402.ULX_DONATOR_RANK={"donator","vip"} -- You can add more group donator since the version 3.1
nordahl_cfg_1402.overrides_custom_heck=1 -- Put 0 to keep the old system of customchecks. 1 = All customcheck jobs are disabled with the new system. System overrides custom check and requires to set permissions ex : public donator or whitelist. Currently all my custom check jobs are default public. reboot your server if you change it.
nordahl_cfg_1402.Donator_Rank_Tester=1 -- enable disable command to check the user rank, "nordahl_donator_rank_tester"

print("Nordahl - Job Whitelist system - Config Ok")