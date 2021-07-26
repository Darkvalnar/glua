include('shared.lua') --we need this 


function ENT:Draw()
	self:DrawModel()
end

net:Receive ("writelore", function () --we are receiving the call from the write entity and will now begin construction the input derma layers


--aight so, I KNOW this is janky as shit. 
--there is a much more smoother method
--soon(tm)


local writeselect = vgui.create ("Dframe") --this is the main parent of selection
	writeselect:SetSize (300,500)
	writeselect:Center()
	writeselect:MakePopup()

local DscrollPanel = vgui.Create( "DScrollPanel", writeselect ) --we will now create a list with a button that allows us to progress to write a story
	DscrollPanel:Dock ( FILL )
local DButton =	DscrollPanel:Add( "DButton" )
	DButton:SetText( "Write a story" )
	DButton:Dock( TOP )
	DButton:DockMargin( 0, 0, 0, 5 )
	DButton.DoClick = function()
	
		local EnterTitle = vgui.Create( "DTextEntry", writeselect ) -- create the form as a child of writeselect
		EnterTitle:SetPos( 5, 22 )
		EnterTitle:SetSize( 950, 875 )
		EnterTitle:EnableHorizontal(false) -- Only vertical items
		EnterTitle:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis
		EnterTitle:SetText( "Enter the title of your entry." )
		EnterTitle.OnEnter = LoreTitle  --we store our title in LoreTitle
		file = io.open( LoreTitle + ".txt", "w") --We will now create a file with the title in .txt format with writing permissions, creates new file if file doesn't already exist (which it shouldn't)
		file:write("") --we write a whole bunch of JACKSHIT in there
		file:close()
		writeselect:Close() --we done
		
		if LoreTitle = null  --check if we actually put a title in, cuz if we didn't then we're fucked
		
		then
		
			chat.AddText ("NO TITLE SPECIFIED, ABORTING") --bro why didn't you input a title WTF

		else		-- you input a title, now we will build up another derma frame and will allow for the actual lore entry/story entry
		
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


		local EnterLore = vgui.Create( "DTextEntry", frame ) -- create the form as a child of frame
		EnterLore:SetPos( 5, 22 )
		EnterLore:SetSize( 950, 875 )
		EnterLore:EnableHorizontal(false) -- Only vertical items
		EnterLore:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis
		EnterLore:SetText( "Your entry" )
		EnterLore.OnEnter = LoreEntry --we will store the story/lore entry in LoreEntry 
		file = io.open( LoreTitle + ".txt", "w") --we will now open the previously created lore file with write permissions 
		file:write(LoreEntry) --we will now store the contents of the loreentry into the file 
		file:close() --done
		Frame:Close() --we done, completely, finished, ende, end, finito
end
end
end
end
end