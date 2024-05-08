-- Values
_G.currentDigimon = ""


local quest_options = {
  "MegaGrind",
}

local digimon_evolve_options = {
  "BarbamonX",
  "Ordinemon"
}


-- Functions

function initializeStats()
  -- Find the player whose character matches the current script's parent
  local players = game:GetService("Players")
  local myPlayer = nil
  for _, player in pairs(players:GetPlayers()) do
    if player.Character and player.Character == script.Parent then
      myPlayer = player
      break
    end
  end

  if myPlayer then
    -- You now have access to your player's information
    print("My player name:", myPlayer.Name)
    print("digimon : ", myPlayer.Digimon)
    _G.currentDigimon = myPlayer.Digimon
  else
    print("not found")
    -- Handle the case where the character is not found (e.g., script not parented to a character)
  end
end

function AcceptQuest(quest)
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

-- Menu

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({

  Name = "🔥🐱‍🐉 Digimon Masters🐕🐶",
  LoadingTitle = "",
  LoadingSubtitle = "by breadboi | monvictor",
  ConfigurationSaving = {
    Enabled = true,
    FolderName = nil, -- Create a custom folder for your hub/game
    FileName = "Tutorial"
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


local MainTab = Window:CreateTab("🏠 Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
  Title = "You executed the script",
  Content = "Very cool gui",
  Duration = 2,
})

local Dropdown = MainTab:CreateDropdown({
  Name = "Evolve To",
  Options = digimon_evolve_options,
  CurrentOption = { "Starter World" },
  MultipleOptions = false,
  Flag = "dropdownarea", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
  Callback = function(Option)
    print(Option)
  end,
})
