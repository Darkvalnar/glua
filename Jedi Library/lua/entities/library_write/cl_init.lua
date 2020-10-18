include('shared.lua') --we need this 


function ENT:Draw()
	self:DrawModel()
end

net.Receive ("writelore", function () --we are receiving the call from the write entity and will now begin construction the input derma layers
local WriteSelect = vgui.Create("DFrame") --this is the main parent of selection
	WriteSelect:SetSize (300,500)
	WriteSelect:Center()
	WriteSelect:MakePopup()

local DscrollPanel = vgui.Create( "DScrollPanel", WriteSelect ) --we will now create a list with a button that allows us to progress to write a story
	DscrollPanel:Dock ( FILL )
local DButton =	DscrollPanel:Add( "DButton" )
	DButton:Center()
	DButton:SetText( "Write a story" )
	DButton:Dock( TOP )
	DButton:DockMargin( 0, 0, 0, 5 )
	DButton.DoClick = function()

	
		local EnterTitle = vgui.Create( "DTextEntry", WriteSelect ) -- create the form as a child of writeselect
		EnterTitle:Center()
		EnterTitle:SetSize( 950, 875 )
		EnterTitle:SetText( "Enter the title of your entry." )
		EnterTitle.OnEnter = function( test1 )  --we store our title in LoreTitle
		chat.AddText( test1:GetValue() )
		end
		local LoreTitle = EnterTitle.OnEnter()
		file = file.Open(LoreTitle() + ".txt", "w") --We will now create a file with the title in .txt format with writing permissions, creates new file if file doesn't already exist (which it shouldn't)
		file:Write("") --we write a whole bunch of JACKSHIT in there
		file:close()
		WriteSelect:Close() --we done
		EnterTitle:Close()
		DButton:Close()
		end 
		
		--if LoreTitle ==0 then  --check if we actually put a title in, cuz if we didn't then we're fucked
		
		--chat.AddText ("NO TITLE SPECIFIED, ABORTING") --bro why didn't you input a title WTF

	--	else		-- you input a title, now we will build up another derma frame and will allow for the actual lore entry/story entry
		
		local Frame = vgui.Create("DFrame") --we are creating a dframe as the main component
		Frame:SetDeleteOnClose(true)
		Frame:SetSize(950,900) -----------Yea, yea, I know, pretty big and will probably fuck people up that still use 800x600
		Frame:SetVisible(true)
		Frame:SetDraggable(true)
		Frame:SetBackgroundBlur(true)
		Frame:ShowCloseButton(true)
		Frame:Center()
		Frame:MakePopup()
		Frame.Paint = function( self, w, h ) 
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 105, 145, 150 ) ) -- Draw a blue-ish box instead of the frame
		end

		local EnterLore = vgui.Create( "DTextEntry", Frame ) -- create the form as a child of frame
		EnterLore:SetSize( 950, 875 ) -- Only vertical items
		EnterLore:Center()
		EnterLore:SetText( "Your entry" )
	--	EnterLore.OnEnter() = LoreEntry --we will store the story/lore entry in LoreEntry 
		EnterLore.OnEnter = function (test2)
		chat.AddText( test2:GetValue() )
		end
		local LoreEntry = EnterLore.OnEnter()
		local f = file.Open(LoreEntry() + ".txt", "w") --we will now open the previously created lore file with write permissions 
		file:Write(LoreEntry) --we will now store the contents of the loreentry into the file 
		file:Close() --done
		Frame:Close() --we done, completely, finished, ende, end, finito
		EnterLore:Close()

end)