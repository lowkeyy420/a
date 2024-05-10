-- Values

getgenv().toggleAutoQuest = false
getgenv().toggleAutoEvolve = false
getgenv().selectedQuest = {}
getgenv().selectedEvolve = {}

getgenv().quest_options = {
  "MegaGrind", -- freeze land
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
  Options = getgenv().quest_options,
  CurrentOption = getgenv().quest_options[3],
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