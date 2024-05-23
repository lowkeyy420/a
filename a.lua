-- Values

getgenv().toggleAutoQuest = false
getgenv().toggleAutoEvolve = false
getgenv().selectedQuest = {}
getgenv().selectedEvolve = {}
getgenv().selectedTeleport = {}
getgenv().toggleAutoAttack = false
getgenv().toggleAutoChip = false
getgenv().toggleAutoTeleport = false
getgenv().toggleAutoEquipSkill = Value

getgenv().quest_options = {
  "MegaGrind", -- freeze land
  "JogressGrind", -- infinite mountain
  "SUGrind", -- infinite dungeon
  "GodGrind", -- dark area
  "HardGrind", -- digital desolation
  "WorldGrind", -- wb
  "HardWorldGrind", -- hard wb
}

getgenv().digimon_evolve_options = {
  "BarbamonX",
  "Ordinemon",
  "Dianamon",
  "ExamonX"
}

getgenv().teleport_options = {
  "Western Village",
  "Freeze Land",
  "Infinite Mountain",
  "Infinite Dungeon",
  "Dark Area",
  "Digital Desolation",
  "Fossil Valley"
}


-- Functions

function autoQuest()
  while getgenv().toggleAutoQuest == true do
    for i, quest in ipairs(getgenv().selectedQuest) do
      
      submitQuest(quest)
      wait(0.5)
      acceptQuest(quest)
    end
    wait(5)
  end
end

function acceptQuest(quest)
  local args = {
    [1] = {
      [1] = {
        [1] = "\29",
        [2] = quest,
        [3] = "Accept"
      }
    }
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

function submitQuest(quest)
  local args = {
    [1] = {
      [1] = {
        [1] = "\29",
        [2] = quest,
        [3] = "Submit"
      }
    }
  }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

function autoEvolve()
  while getgenv().toggleAutoEvolve == true do
      evolveTo(getgenv().selectedEvolve)
      wait(5)
  end
end


function evolveTo(digimon)
  local args = {
    [1] = {
      [1] = {
        [1] = "\25",
        [2] = digimon,
      }
    }
  }
  
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

function autoEquipSkill()
  while getgenv().toggleAutoEquipSkill == true do
    equipSkill("PandemoniumLostX")
    wait(60)
  end
end

function equipSkill(skillName)
  local player = game:GetService("Players").LocalPlayer
  local playername = player.Name
  local workspacePlayer = game:GetService("Workspace"):WaitForChild(playername)

  local backpack = player.Backpack 
  local skill = backpack:FindFirstChild(skillName) 

  if skill then
    skill.Parent = workspacePlayer
  end
  
end


function autoAttack()
  while getgenv().toggleAutoAttack == true do
    local args = {
      [1] = {
              [1] = {
                  [1] = "\8",
                  [2] = "PandemoniumLostX",
                  [4] = 180,
                  [6] = 1
              }
          }
      }
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    wait(2)
  end
end

function autoChip()
  local args = {
    [1] = {
            [1] = {
                [1] = "\n",
                [2] = "ATK"
            }
        }
    }
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
  
end

function autoTeleport()
  while getgenv().toggleAutoTeleport == true do
    if getgenv().selectedTeleport == "Western Village" then
      teleport(Vector3.new(-3095.77, 4078.9, 1249.98))
    elseif getgenv().selectedTeleport == "Freeze Land" then
      teleport(Vector3.new(2263.09, 4151.19, -1305.74))
    elseif getgenv().selectedTeleport == "Infinite Mountain" then
      teleport(Vector3.new(-8511.37, 4085.64, -524.546))
    elseif getgenv().selectedTeleport == "Infinite Dungeon" then
      teleport(Vector3.new(-10387.4599, 3888.49682, -512.0713500))
    elseif getgenv().selectedTeleport == "Dark Area" then
      teleport(Vector3.new(-11571.6, 4536.51, -12656.3))
    elseif getgenv().selectedTeleport == "Digital Desolation" then
      teleport(Vector3.new(-19.8861, 4246.79, 19583.6))
    elseif getgenv().selectedTeleport == "Fossil Valley" then
      teleport(Vector3.new(33311.80859375, 4643.3740234375, -6666.61767578125))
    end
    wait(60)
  end
end


function teleport(place)
  local player = game.Players.LocalPlayer
  player.Character.HumanoidRootPart.CFrame = CFrame.new(place)
end

-- Menu

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({

  Name = "Digimon Masters",
  LoadingTitle = "",
  LoadingSubtitle = "by breadboi",
  ConfigurationSaving = {
    Enabled = true,
    FolderName = nil, -- Create a custom folder for your hub/game
    FileName = "digimonmaster"
  },
  Discord = {
    Enabled = false,
    Invite = "noinvitelink",
    RememberJoins = true
  },
  KeySystem = false,
  KeySettings = {
    Title = "Untitled",
    Subtitle = "Key System",
    Note = "No method of obtaining the key is provided",
    FileName = "Key",        -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
    SaveKey = true,          -- The user's key will be saved, but if you change the key, they will be unable to use your script
    GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
    Key = { "Hello" }        -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
  }
})

Rayfield:Notify({
  Title = "Script successfully executed",
  Content = "kiyowow",
  Duration = 1,
})


local MainTab = Window:CreateTab("Main", nil)
local MainSection = MainTab:CreateSection("Main")

local Label1 = MainTab:CreateLabel("Choose Quest Before Enabling Auto Quest")

local Toggle1 = MainTab:CreateToggle({
  Name = "Enable Auto Quest",
  CurrentValue = false,
  Flag = "autoquest",
  Callback = function(Value)
    getgenv().toggleAutoQuest = Value
    autoQuest()
  end,
})

local Dropdown1 = MainTab:CreateDropdown({
  Name = "Quests",
  Options = getgenv().quest_options,
  CurrentOption = {},
  MultipleOptions = true,
  Flag = "questdropdown", 
  Callback = function(Option)
    getgenv().selectedQuest = Option
  end,
})

local Toggle2 = MainTab:CreateToggle({
  Name = "Enable Auto Evolve",
  CurrentValue = false,
  Flag = "autoevolve",
  Callback = function(Value)
    getgenv().toggleAutoEvolve = Value
    autoEvolve()
  end,
})

local Dropdown2 = MainTab:CreateDropdown({
  Name = "Auto Evolve Digimon To",
  Options = getgenv().digimon_evolve_options,
  CurrentOption = { ""},
  MultipleOptions = false,
  Flag = "digimonevolvedropdown", 
  Callback = function(Option)
    getgenv().selectedEvolve = Option[1]    
  end
})


local Button = MainTab:CreateButton({
  Name = "Close Hub",
  Callback = function()
    Rayfield:Destroy()
  end
})


local DigimonTab = Window:CreateTab("Digimon", nil)
local DigimonSection = DigimonTab:CreateSection("Notice")
local DigimonLabel1 = DigimonTab:CreateLabel("Auto Attack and Equip Only For BarbamonX")
local DigimonSection2 = DigimonTab:CreateSection("Automation")

local Toggle3 = DigimonTab:CreateToggle({
  Name = "Auto Attack",
  CurrentValue = false,
  Flag = "autoattack",
  Callback = function(Value)
    getgenv().toggleAutoAttack = Value
    autoAttack()
  end,
})

local Toggle4 = DigimonTab:CreateToggle({
  Name = "Auto Equip Skill 1",
  CurrentValue = false,
  Flag = "autoequipskill",
  Callback = function(Value)
    getgenv().toggleAutoEquipSkill = Value
    autoEquipSkill()
  end,
})

-- local Toggle5 = DigimonTab:CreateToggle({
--   Name = "Auto ATK Chip",
--   CurrentValue = false,
--   Flag = "autochip",
--   Callback = function(Value)
--     getgenv().toggleAutoChip = Value
--     autoChip()
--   end,
-- })

local AtkChipButton = DigimonTab:CreateButton({
  Name = "Use ATK Chip",
  Callback = function()
    autoChip()
  end,
})

local DigimonLabel2 = DigimonTab:CreateLabel("Combine With Auto Evolve For Best Results")

local Dropdown3 = DigimonTab:CreateDropdown({
  Name = "Auto Teleport",
  Options = getgenv().teleport_options,
  CurrentOption = { "" },
  MultipleOptions = false,
  Flag = "teleportdropdown", 
  Callback = function(Option)
    getgenv().selectedTeleport = Option[1]
    print(getgenv().selectedTeleport)
  end,
})


local Toggle6 = DigimonTab:CreateToggle({
  Name = "Auto Teleport",
  CurrentValue = false,
  Flag = "autopteleport",
  Callback = function(Value)
    getgenv().toggleAutoTeleport = Value
    autoTeleport()
  end,
})


local TeleportTab = Window:CreateTab("Teleport", nil)
local TeleportSection = TeleportTab:CreateSection("Area")

local Button1 = TeleportTab:CreateButton({
  Name = "Western Village",
  Callback = function()
    teleport(Vector3.new(-3095.77, 4078.9, 1249.98))
  end,
})

local Button2 = TeleportTab:CreateButton({
  Name = "Freeze Land",
  Callback = function()
    teleport(Vector3.new(2263.09, 4151.19, -1305.74))
  end,
})

local Button3 = TeleportTab:CreateButton({
  Name = "Infinite Mountain",
  Callback = function()
    teleport(Vector3.new(-8511.37, 4085.64, -524.546))
  end,
})

local Button4 = TeleportTab:CreateButton({
  Name = "Infinite Dungeon",
  Callback = function()
    teleport(Vector3.new(-10387.4599, 3888.49682, -512.0713500))
  end,
})

local Button5 = TeleportTab:CreateButton({
  Name = "Dark Area",
  Callback = function()
    teleport(Vector3.new(-11571.6, 4536.51, -12656.3))
  end,
})

local Button6 = TeleportTab:CreateButton({
  Name = "Digital Desolation",
  Callback = function()
    teleport(Vector3.new(-19.8861, 4246.79, 19583.6))
  end,
})

local Button7 = TeleportTab:CreateButton({
  Name = "Fossil Valley",
  Callback = function()
    teleport(Vector3.new(33311.80859375, 4643.3740234375, -6666.61767578125))
  end,
})  



