include('shared.lua') 

local function explode(whole,key)
	local s1 = whole
	local s2 = {}
	local done = false
	local i = 0
	while done == false do
		local r1,r2 = string.find(s1,key)
		if r1 ~= nil then
			s2[i] = string.sub(s1,1,r1-1)
			s1 = string.sub(s1,r2+1)
			i=i+1
		else
			done = true
		end
	end
	return s2
end

local BOOK_LIST = {}




--[[
These are the variables you want to keep in mind when changing stuff:

arg1 = EntID
arg2 = Handshake
arg3 = Title
arg4 = URL
--]]
function ENT:Initialize() 

--Empty, but you must have this function
end
 
surface.CreateFont( "HolocronFont", { -------------------Creates a custom font
	font = "SF Old Republic SC", ------------must be the actual name of the font that you can see in your font viewer
	extended = true, ------------------read what these values do on https://wiki.garrysmod.com/page/Structures/FontData
	size = 20,
	weight = 50,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = true,
	outline = true,
} )



-----Font wrap really not in use yet 

local function charWrap(text, pxWidth)
    local total = 0

    text = text:gsub(".", function(char)
        total = total + surface.GetTextSize(char)

        -- Wrap around when the max width is reached
        if total >= pxWidth then
            total = 0
            return "\n" .. char
        end

        return char
    end)

    return text, total
end 
 
 
function ENT:Draw()
 
	self:DrawModel() --Draw the model, without this, you'll get a invisible, model-less entity.
 
end

local function OpenBook(ply,cmd,args) --------------This is the shit that draws when you click on one of the stories/books/etc in the menu
	local Ent = Entity(tonumber(args[1]))
	local ExText = string.gsub(Ent.Content,"\r\n","")
	ExText = explode(Ent.Content,"#")

	local Frame = vgui.Create("DFrame")
	Frame:SetDeleteOnClose(true)
	Frame:SetSize(950,900) -----------Yea, yea, I know, pretty big and will probably fuck people up that still use 800x600
	Frame:SetTitle(args[3]) ---------------This will automatically use the title/name of your story on pastebin 
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:SetBackgroundBlur(true)
	Frame:ShowCloseButton(true)
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) 
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 105, 145, 150 ) ) -- Draw a blue-ish box instead of the frame

	local DermaList = vgui.Create( "DPanelList",Frame)
	DermaList:SetPos(5,22)
	DermaList:SetSize(950,875)
	DermaList:SetSpacing(1) -- Spacing between items
	DermaList:EnableHorizontal(false) -- Only vertical items
	DermaList:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis
	
	for i=0,table.maxn(ExText) do
		local Text = vgui.Create("DLabel")
		Text:SetText(ExText[i])
		Text:SetFont("HolocronFont")
		Text:SetTextColor( Color( 255, 255, 255 ) )
		Text:SizeToContents()	
		DermaList:AddItem(Text)

		
	end	
end


end

local function CallContent(ply,cmd,args)
	local Ent = Entity(tonumber(args[1]))
	if Ent.Called == nil then
		http.Fetch(args[4],function(c) Ent.Content = c; end)
		Ent.Called = true
	elseif Ent.Content ~= nil then
		OpenBook(ply,cmd,args)
	end
end



--[[
The function below will fetch books from the pastebin link specified in http.Fetch

If you want to use this, you will probably want to modify this

Your overview/general pastebin content list MUST have this format:
https://PastebinLinkToYourStory@
Title that appears in the in-game menu@!

Now, I'll only say this once.
The @ in your content list on pastebin MUST be at the end of the specific story, whatever
The @! at the end of the ingame title also MUST be there

Should you have problems understanding this, take a look at the pastebin file specified 
--]]

local function GrabBooks() 
	http.Fetch("https://pastebin.com/raw.php?i=KGqke8Me",function(c) ---has to be in raw format
	local f = string.gsub(c,"\r\n","")
	local q = explode(f,"!")
	for i=0,table.maxn(q) do
		local temp = explode(q[i],"@")
		BOOK_LIST[temp[1]] = temp[0]
	end
	end)
	

end

local function SelectBook(ply,cmd,args) -------this is the actual script that builds/draws the menu with all its contents, the refresh button, library sheet, etc.
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
	
	
	
	
	
	local Refreshbutton = vgui.Create("DButton",Frame) 
	Refreshbutton:SetSize(100,22)
	Refreshbutton:SetPos(100,0)
	Refreshbutton:SetText("Refresh")
	Refreshbutton.DoClick = function(but)
			RunConsoleCommand("book_refresh")  ---this button runs the command to fetch the stories/content pointed at in the pastebin
			GrabBooks()
			Frame:Close()
		end
end


concommand.Add("book_load",SelectBook)
concommand.Add("book_open",CallContent)
concommand.Add("book_refresh",function(ply,cmd,args) BOOK_LIST = {}; BOOK_LIST_LOCAL = {} end)