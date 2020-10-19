AddCSLuaFile( "skilltree/config.lua" )
AddCSLuaFile( "skilltree/shared.lua" )
AddCSLuaFile( "skilltree/client/menu_skills.lua" )
AddCSLuaFile( "skilltree/client/hud_level.lua" )

SK_TREE = SK_TREE or {}

include( "skilltree/config.lua" )

include( "skilltree/shared.lua" )
include( "skilltree/server/handler_player.lua" )
include( "skilltree/server/handler_menu_skills.lua" )