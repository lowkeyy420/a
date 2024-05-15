-- Values

getgenv().toggleAutoQuest = false
getgenv().toggleAutoEvolve = false
getgenv().selectedQuest = {}
getgenv().selectedEvolve = {}
getgenv().selectedTeleport = {}
getgenv().toggleAutoAttack = false
getgenv().toggleAutoChip = false
getgenv().toggleAutoTeleport = false

getgenv().quest_options = {
  {"MegaGrind", "Freeze Land"},
  {"JogressGrind", "Infinite Mountain"},
  {"SUGrind", "Infinite Dungeon"},
  {"GodGrind", "Dark Area"},
  {"HardGrind", "Digital Desolation"},
  {"WorldGrind", "World Boss"},
  {"HardWorldGrind", "Hard World Boss"}
}

getgenv().digimon_evolve_options = {
  "BarbamonX",
  "Ordinemon",
  "Dianamon",
  "ExamonX"
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
        [1] = "\28",
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
        [1] = "\28",
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
        [1] = "\24",
        [2] = digimon,
      }
    }
  }
  
  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

function autoAttack()
  while getgenv().toggleAutoAttack == true do
    local args = {
      [1] = {
              [1] = {
                  [1] = "\7",
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
  while getgenv().toggleAutoChip == true do
    local args = {
      [1] = {
              [1] = {
                  [1] = "\t",
                  [2] = "ATK"
              }
          }
      }
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    wait(30)
  end
end

function autoTeleport()
  while getgenv().toggleAutoTeleport == true do
    


    teleport()
    wait(5)
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
  Content = "Very cool gui",
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
  Options = (function()
      local options = {}
      for _, quest in ipairs(getgenv().quest_options) do
          table.insert(options, quest[2])
      end
      return options
  end)(),
  CurrentOption = getgenv().quest_options[3][2],
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
local DigimonSection = MainTab:CreateSection("Notice")
local DigimonLabel1 = DigimonTab:CreateLabel("Auto Attack Only For BarbamonX")
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
  Name = "Auto ATK Chip",
  CurrentValue = false,
  Flag = "autochip",
  Callback = function(Value)
    getgenv().toggleAutoChip = Value
    autoChip()
  end,
})

local DigimonLabel2 = DigimonTab:CreateLabel("Combine With Auto Evolve For Best Results")
local Toggle5 = DigimonTab:CreateToggle({
  Name = "Auto Teleport",
  CurrentValue = false,
  Flag = "autopteleport",
  Callback = function(Value)
    getgenv().toggleAutoTeleport = Value
    autoChip()
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
  Name = "Dark Area",
  Callback = function()
    teleport(Vector3.new(-11571.6, 4536.51, -12656.3))
  end,
})

local Button5 = TeleportTab:CreateButton({
  Name = "Digital Desolation",
  Callback = function()
    teleport(Vector3.new(295.488, 4186.93, 17948))
  end,
})

local Button6 = TeleportTab:CreateButton({
  Name = "Fossil Valley",
  Callback = function()
    teleport(Vector3.new(33311.80859375, 4643.3740234375, -6666.61767578125))
  end,
})  



