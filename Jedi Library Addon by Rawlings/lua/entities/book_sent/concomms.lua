include( "cl_init.lua" ) 
include( "shared.lua" )
if SERVER then
    --Make sure clients download this script.
    AddCSLuaFile("cl_init.lua")
	AddCSLuaFile( "shared.lua" )
 
    --Add a console command for clients to use.
    function SelectBook(ply,cmd,args) -------this is the actual script that builds/draws the menu with all its contents, the refresh button, library sheet, etc.
	local Ent = Entity(tonumber(args[1]))
	local HS = args[2]
	
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(300,500)
	Frame:SetTitle("Select Wisdom")
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:ShowCloseButton(true) -----set this to false if you're feeling crazy and want to trap people
	Frame:Center()
	Frame:MakePopup()
	
	local Sheet = vgui.Create("DPropertySheet",Frame)
	Sheet:SetSize(300,478)
	Sheet:SetPos(0,22)
	
	local LIST = vgui.Create("DPanelList")
	LIST:SetPos(0,22)
	LIST:SetSize(350,478)
	LIST:SetSpacing(10)
	LIST:EnableVerticalScrollbar(true)
	LIST:EnableHorizontal(false)
	
	for i,v in pairs(BOOK_LIST) do
		local button = vgui.Create("DButton")
		button:SetSize(280,30)
		button:SetText(i)
		button.Book = i
		button.DoClick = function(but)
			RunConsoleCommand("book_update",Ent:EntIndex(),HS,but.Book,BOOK_LIST[but.Book])
			Frame:Close()
		end
		LIST:AddItem(button)
	end
 
	Sheet:AddSheet("Library", LIST, "mar8studios/jedicons/2340419766_3904615653.png", false, false, "Books stored in the Jedi library") ------adds the library select menu 
	
    concommand.Add("recievestuff",recieveStuffFromPlayer)
	concommand.Add("book_load",SelectBook)
	concommand.Add("book_open",CallContent)
	concommand.Add("book_refresh",function(ply,cmd,args) BOOK_LIST = {}; BOOK_LIST_LOCAL = {} end)
end
if CLIENT then
   --When this script is loaded by the clients, have it run the console command we made on the server.
   LocalPlayer():ConCommand("recievestuff Hello! How are you?")
end