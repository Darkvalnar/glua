
--[[ Do not touch ]]--------------------------------------------
SChar.Config = SChar.Config or {}
----------------------------------------------------------------

-- [[ Config for backdrop of the character screen. ]]--
-- [[ Do NOT NOT include materials/ directory --]]
// Example of a image located in materials folder //
// mypicture/image/dope.png
// This will be automatically added to fast DL -- Base image is 1920x1080 for proper scaling
SChar.Config.MainBackground = "sci_char/bg_2.png"

--[[ Min Length for Name --]]
SChar.Config.MinLength = 5

-- [[ Set to true to enable Blogswhitelist support ]]--
// Must have Blogs installed and properly working //
SChar.BlogsWhitelist = true

--[[ Max Length for Name --]]
SChar.Config.MaxLength = 20

--[[ The back ground for the main background 1 or 2 ]]--
SChar.Config.Background = 2

--[[ Enabled a shadow model to show until a faction/model is selected ]]--
SChar.Config.EnabledShadow = false

--[[ Enable/Disable (true/false) border effects ]]--
SChar.Config.BorderEffects = true

--[[ Enable Close buttons on menus --]]
SChar.Config.Create_ShowCloseButton = false
SChar.Config.Spawn_ShowCloseButton = true

--[ Enable automatic digit assigning to players -- ]
--[[ EXAMPLE: 6217 Jordan Howard]]
SChar.Config.Digits = false
SChar.Config.DigitsMin = 1000
SChar.Config.DigitsMax = 3500

--[ Enabled prefixs to text ]--
--[ EXAMPLE: CT 1712 JOrdan Howard.. etc --]
SChar.Config.Prefix = false
SChar.Config.PrefixText = "CT"


--[ Open Spawn menu on every join? ]--
--[ Note: This will force player data depending on what they registered their character with. ]--
SChar.Config.SpawnMenu = true

--[[ Enable/Disable forcing data when using the spawn menu ]]--
SChar.Config.S_ForceModel = true
SChar.Config.S_Name = false
SChar.Config.S_Job = true

--[[ This will force them to have the data they made every time they join the server. ]]--
// This must be set to true for the other forces to work //
SChar.Config.EnableForce = false

// Chat command to reopen the main menu //
SChar.Config.ChatCommand = {"!character", "!char"}

// Each time they respawn force their model to what they choose on character creation? //
SChar.Config.DeathModelForce = false

SChar.Config.ForceName = false
SChar.Config.ForceJob = true
SChar.Config.ForceModel = true

--[[ About the Server ]]--
SChar.Config.AboutEnabled = true
SChar.Config.AboutInfo = "Welcome to my server I hope you enjoy it. \n \n Please read the rules and follow them! \n \n Interested in the community? Sign up on the forums!"


--[[ Max Character Configurations -- ]]
SChar.Config.Char_Max = 1
SChar.Config.Char_MaxVIP = 2
SChar.Config.Char_VIPGroups = {"owner", "superadmin", "vip"}

--[[ Button Configurations --]]

// Enable grey backdrop?
SChar.Config.btn_backdrop = true

// enable content button ?
SChar.Config.btn_content = {Enabled = true, Text = "Content", link = "https://steamcommunity.com/sharedfiles/filedetails/?id=1509302380"}

// enable forums button ? 
SChar.Config.btn_forums = {Enabled = false, Text = "Visit Forums", link = "https://www.google.com/"}


--[[ Names that will be blacklisted ]]--
SChar.Config.BlacklistNames = {
	"firstname",
	"lastname",
	"first",
	"last",
    "anal",
    "anus",
    "arse",
    "ass",
    "adderall",
    "ballsack",
    "balls",
    "bastard",
    "bitch",
    "biatch",
    "bloody",
    "blowjob",
    "bollock",
    "bollok",
    "boner",
    "boob",
    "bugger",
    "bum",
    "butt",
    "buttplug",
    "clitoris",
    "cock",
    "coon",
    "cocaine",
    "crap",
    "cunt",
    "cum",
    "damn",
    "dick",
    "dildo",
    "ddos",
    "dyke",
    "fag",
    "feck",
    "fellate",
    "fellatio",
    "felching",
    "fuck",
    "fudgepacker",
    "flange",
    "goddamn",
    "hell",
    "homo",
    "jerk",
    "jizz",
    "knobend",
    "knob",
    "labia",
    "lmao",
    "lmfao",
    "muff",
    "nigger",
    "nigga",
    "omg",
    "penis",
    "piss",
    "poop",
    "porn",
    "pornhub",
    "prick",
    "pube",
    "pussy",
    "queer",
    "scrotum",
    "stoner",
    "sex",
    "shit",
    "slut",
    "smegma",
    "tit",
    "tosser",
    "turd",
    "twat",
    "vagina",
    "weed",
    "wank",
    "whore",
    "wtf",
    "<Enter Name>",
    "<Enter Name>",
}


if SERVER then
	resource.AddFile("materials/".. SChar.Config.MainBackground)
end