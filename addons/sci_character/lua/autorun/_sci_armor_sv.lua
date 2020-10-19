

// Thanks Richard for this!
Skeleton = Skeleton or {}
Skeleton.Script = Skeleton.Script or {}
Skeleton.Script.Name = "Sci-Fi Character"
Skeleton.Script.Author = "Nykez"
Skeleton.Script.Build = "1.0"
Skeleton.Script.Released = "Aug, 25, 2017"
Skeleton.Script.Website = "www.gmodstore.com"




local luaroot = "sci_character"
local name = "Sci-Fi Character Addon"

local SkeletonStartupHeader = {
    '\n\n',
    [[.................................................................... ]],
}

local SkeletonStartupInfo = {
    [[[title]....... ]] .. Skeleton.Script.Name .. [[ ]],
    [[[build]....... v]] .. Skeleton.Script.Build .. [[ ]],
    [[[released].... ]] .. Skeleton.Script.Released .. [[ ]],
    [[[author]...... ]] .. Skeleton.Script.Author .. [[ ]],
    [[[website]..... ]] .. Skeleton.Script.Website .. [[ ]],
}

local SkeletonStartupFooter = {
    [[.................................................................... ]],
}

function Skeleton:PerformCheck(func)
    if (type(func)=="function") then
        return true
    end
    
    return false
end


for k, i in ipairs( SkeletonStartupHeader ) do 
    MsgC( Color( 255, 255, 0 ), i .. '\n' )
end

for k, i in ipairs( SkeletonStartupInfo ) do 
    MsgC( Color( 255, 255, 255 ), i .. '\n' )
end

for k, i in ipairs( SkeletonStartupFooter ) do 
    MsgC( Color( 255, 255, 0 ), i .. '\n\n' )
end

-----------------------------------------------------------------
-- [ SERVER-SIDE ACTIONS ]
-----------------------------------------------------------------

if SERVER then

    local fol = luaroot .. "/"
    local files, folders = file.Find(fol .. "*", "LUA")

    for k, v in pairs(files) do
        include(fol .. v)
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] SHARED file: " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] SERVER file: " .. File .. "\n")
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] CLIENT file: " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/vgui_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] CLIENT file: " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
        end
    end

    MsgC(Color( 0, 255, 0 ), "\n..........................[ Sci-Fi Character Loaded ]..........................\n\n")

end

-----------------------------------------------------------------
-- [ CLIENT-SIDE ACTIONS ]
-----------------------------------------------------------------

if CLIENT then

    local root = "sci_character" .. "/"
    local _, folders = file.Find(root .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] SHARED file: " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] CLIENT file: " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/vgui_*.lua", "LUA"), true) do
            MsgC(Color(255, 0, 0), "[" .. Skeleton.Script.Name .. "] VGUI file: " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    MsgC(Color( 0, 255, 0 ), "\n..........................[ Sci-Fi Character Loaded ]..........................\n\n")

end
