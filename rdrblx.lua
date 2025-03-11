-- Variables

getgenv().toggleAutoE = false
getgenv().toggleAutoC = false
getgenv().toggleAutoV = false
getgenv().toggleAutoTeleport = false
getgenv().toggleAutoQuest = false
getgenv().toggleAutoNormalAttack = false
getgenv().toggleAutoHeavyAttack = false
getgenv().toggleAutoFollowRider = false
getgenv().toggleAutoAttackArmedRider = false
local camera = workspace.CurrentCamera
getgenv().toggleCameraLock = false
getgenv().selectedEnemy = {}

getgenv().reputation = {
  "Armed Lost Rider Lv.5",
  "Dragon User Lv.7",
  "Crab User Lv.10",
  "Bat User Lv.12",
  "Bull User Lv.15",
  "Cobra User Lv.20",
  "Manta User Lv.25",
  "Swan User Lv.30",
  "Chameleon User Lv.35",
  "Rhino User Lv.40",
  "Tiger User Lv.40",
  "Ancient Mummy Lv.50",
  "Shark User Lv.60",
  "Steed Lv.80",
  "Gazelle User Lv.45",
  "Dark Dragon User Lv.40",
}

getgenv().riders = {
  "Armed Lost Rider Lv.5",
  "Dragon User Lv.7",
  "Crab User Lv.10",
  "Bat User Lv.12",
  "Bull User Lv.15",
  "Cobra User Lv.20",
  "Manta User Lv.25",
  "Swan User Lv.30",
  "Chameleon User Lv.35",
  "Rhino User Lv.40",
  "Tiger User Lv.40",
  "Ancient Mummy Lv.50",
  "Shark User Lv.60",
  "Riot Combat  Lv.60",
  "Riot Maniac  Lv.60",
  "Riot Range  Lv.70",
  "Riot Maniac  Lv.75",
  "Ancient Goon Lv.70",
  "Steed Lv.80",
  "Gazelle User Lv.45",
  "Dark Dragon User Lv.40",
  "Daguba Lv.90",
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local playerHRP = character:WaitForChild("HumanoidRootPart")

local teleport_table = {
  luna = Vector3.new(395, 19.865028381347656, 447),
  lostminer = Vector3.new(-1300.7811279296875, 25.42669677734375, 107.94029998779297)
}

-- Functions 

function AutoSkill(skillKey)
  while getgenv().toggleAutoE == true do
    playerpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    local args = {
        [1] = {
            ["Key"] = skillKey,
            ["Skill"] = true,
            ["MouseData"] = CFrame.new(playerpos)
        }
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("RiderSkills"):InvokeServer(unpack(args))
    wait(5)
  end
end

function AutoNormalAttack()
  while getgenv().toggleAutoNormalAttack == true do
    playerpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    local args = {
      [1] = {
          ["CombatAction"] = true,
          ["Input"] = "Mouse1",
          ["LightAttack"] = true,
          ["MouseData"] = CFrame.new(playerpos)
      }

    }
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("RiderSkillsRemote"):FireServer(unpack(args))
    wait(1)    
  end
end

function AutoHeavyAttack()
  while getgenv().toggleAutoHeavyAttack == true do
    playerpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    local args = {
      [1] = {
          ["CombatAction"] = true,
          ["AttackType"] = "Down",
          ["HeavyAttack"] = true,
        ["MouseData"] = CFrame.new(playerpos)
      }
    }
  
    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("RiderSkillsRemote"):FireServer(unpack(args))
    wait(1.5)
  end
end

function AutoTeleport(place)
  while getgenv().toggleAutoTeleport == true do
    TeleportTo(place)
    wait(3)
  end
end

function TeleportTo(place)
    local tween_s = game:GetService("TweenService")
    
    local tweenInfo = TweenInfo.new(
        1, -- Time
        Enum.EasingStyle.Linear, -- EasingStyle
        Enum.EasingDirection.Out, -- EasingDirection
        0, -- RepeatCount (when less than zero the tween will loop indefinitely)
        false, -- Reverses (tween will reverse once reaching it's goal)
        0 -- DelayTime
    )

    local lp = game.Players.LocalPlayer

    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = lp.Character.HumanoidRootPart
        local tween = tween_s:Create(hrp, tweenInfo, {CFrame = CFrame.new(place)})
        tween:Play()
    end
  
end

function getNearestRider(selectedEnemy)
  local nearestDistance = math.huge
  local nearestHRP = nil
  
  for _, armedRider in pairs(Workspace.Lives:GetChildren()) do
      if armedRider.Name == selectedEnemy then
          local riderHRP = armedRider:FindFirstChild("HumanoidRootPart")
          if riderHRP then
              local distance = (riderHRP.Position - playerHRP.Position).Magnitude
              if distance < nearestDistance then
                  nearestDistance = distance
                  nearestHRP = riderHRP
              end
          end
      end
  end
  
  return nearestHRP
end

function lockCameraOnTarget(target)
  if not getgenv().toggleCameraLock then return end
  
  local playerPos = playerHRP.Position
  local targetPos = target.Position
  
  -- Calculate the direction to the target
  local lookVector = (targetPos - playerPos).Unit
  
  -- Create a new CFrame for the camera
  local newCameraCFrame = CFrame.new(playerPos, targetPos) * CFrame.new(0, 2, 10)
  
  -- Set the camera CFrame
  camera.CFrame = newCameraCFrame
end

function updatePlayerPositionArmedRider(riderHRP)
  local targetPosition = riderHRP.Position  + Vector3.new(0, -7, 0) -- 5 studs behind the rider
  local lookVector = (riderHRP.Position - targetPosition).Unit
  local targetCFrame = CFrame.new(targetPosition, riderHRP.Position) -- Look at the rider

  playerHRP.CFrame = targetCFrame
  lockCameraOnTarget(riderHRP)
end

function rotatePlayerTowards(targetPosition)
  local lookVector = (targetPosition - playerHRP.Position).Unit
  local targetCFrame = CFrame.new(playerHRP.Position, playerHRP.Position + lookVector)
  
  playerHRP.CFrame = CFrame.new(playerHRP.Position) * targetCFrame.Rotation
end

local isFollowingArmedRider = false
local followConnectionArmedRider

local function startFollowingArmedRider(selectedEnemy)
  if isFollowingArmedRider then return end
  isFollowingArmedRider = true
  
  followConnectionArmedRider = RunService.Heartbeat:Connect(function()
      local nearestRiderHRP = getNearestRider(selectedEnemy)
      if nearestRiderHRP then
          updatePlayerPositionArmedRider(nearestRiderHRP)
          if getgenv().toggleAutoAttackArmedRider then
              print("Auto Attack Armed Lost Rider")
          end
      end
  end)  
end

function stopFollowingArmedRider()
  if not isFollowingArmedRider then return end
  isFollowingArmedRider = false
  
  if followConnectionArmedRider then
      followConnectionArmedRider:Disconnect()
      followConnectionArmedRider = nil
  end  
end

-- Menu

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({

  Name = "Rider Blox",
  LoadingTitle = "",
  LoadingSubtitle = "by breadboi",
  ConfigurationSaving = {
    Enabled = true,
    FolderName = nil, -- Create a custom folder for your hub/game
    FileName = "riderblox"
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

-- 1st Tab
local MainTab = Window:CreateTab("Main", nil)
local MainSection = MainTab:CreateSection("Main")

local mainToggle1 = MainTab:CreateToggle({
  Name = "Enable Auto Heavy Attack",
  CurrentValue = false,
  Flag = "autoev",
  Callback = function(Value)
    getgenv().toggleAutoHeavyAttack = Value
    AutoHeavyAttack()
  end,
})

local mainToggle2 = MainTab:CreateToggle({
  Name = "Enable Auto Normal Attack",
  CurrentValue = false,
  Flag = "autoatk",
  Callback = function(Value)
    getgenv().toggleAutoNormalAttack = Value
    AutoNormalAttack()
  end,
})

local cameraLockToggle = MainTab:CreateToggle({
  Name = "Lock Camera on Target",
  CurrentValue = false,
  Flag = "cameraLock",
  Callback = function(Value)
      getgenv().toggleCameraLock = Value
      if not Value then
          -- Reset camera to default when turning off
          camera.CameraType = Enum.CameraType.Custom
      end
  end,
})


local closeButton = MainTab:CreateButton({
  Name = "Close Hub",
  Callback = function()
    Rayfield:Destroy()
  end
})

-- 2ND TAB
local GemTab = Window:CreateTab("Gems", nil)
local gemButton1 = GemTab:CreateButton({
  Name = "Teleport to Lost Miner",
  Callback = function()
    TeleportTo(teleport_table.lostminer)
  end
})


-- 3RD TAB
local OdinTab = Window:CreateTab("Odin", nil)
local odinLabel1 = OdinTab:CreateLabel("Only For Odin AOE LUNA")
local odinToggle1 = OdinTab:CreateToggle({
  Name = "Enable Auto E",
  CurrentValue = false,
  Flag = "autoe",
  Callback = function(Value)
    getgenv().toggleAutoE = Value
    AutoSkill("E")
  end,
})

local odinToggle2 = OdinTab:CreateToggle({
  Name = "Enable Auto C",
  CurrentValue = false,
  Flag = "autoec",
  Callback = function(Value)
    getgenv().toggleAutoE = Value
    AutoSkill("C")
  end,
})

local odinToggle3 = OdinTab:CreateToggle({
  Name = "Enable Auto V",
  CurrentValue = false,
  Flag = "autoev",
  Callback = function(Value)
    getgenv().toggleAutoE = Value
    AutoSkill("V")
  end,
})

local odinToggle4 = OdinTab:CreateToggle({
  Name = "Enable Auto Teleport ( Luna )",
  CurrentValue = false,
  Flag = "autoev",
  Callback = function(Value)
    getgenv().toggleAutoTeleport = Value
    AutoTeleport(teleport_table.luna)
  end,
})

-- 4TH TAB
local RiderWarsTab = Window:CreateTab("Rider Wars", nil)

local armedRiderToggle1 = RiderWarsTab:CreateToggle({
  Name = "Enable Auto Follow Armed Lost Rider",
  CurrentValue = false,
  Flag = "autoFollowArmedRider",
  Callback = function(Value)
      getgenv().toggleAutoFollowRider = Value
      if Value then
          startFollowingArmedRider("Armed Lost Rider Lv.5")
      else
          stopFollowingArmedRider()
      end
  end,
})

local armedRiderToggle2 = RiderWarsTab:CreateToggle({
  Name = "Enable Auto Attack Armed Lost Rider",
  CurrentValue = false,
  Flag = "autoAttackArmedRider",
  Callback = function(Value)
      getgenv().toggleAutoAttackArmedRider = Value
  end,
})

-- Add a teleport button for the Armed Lost Rider
local armedRiderButton = RiderWarsTab:CreateButton({
  Name = "Teleport to Nearest Armed Lost Rider",
  Callback = function()
      local nearestRider = getNearestRider("Armed Lost Rider Lv.5")
      if nearestRider then
          TeleportTo(nearestRider.Position)
      else
          Rayfield:Notify({
              Title = "No Armed Lost Rider Found",
              Content = "Could not find any Armed Lost Rider Lv.5 nearby",
              Duration = 3,
          })
      end
  end,
})


-- 5Th TAB
local QuestTab = Window:CreateTab("Daily Quest", nil)

local questDropdown1 = QuestTab:CreateDropdown({
  Name = "Enemy to Defeat",
  Options = getgenv().riders,
  CurrentOption = {},
  MultipleOptions = false,
  Flag = "enemydropdown", 
  Callback = function(Option)
    getgenv().selectedEnemy = Option
  end,
})

local RiderToggle1 = QuestTab:CreateToggle({
  Name = "Auto Follow Rider",
  CurrentValue = false,
  Flag = "autoFollowRider",
  Callback = function(Value)
      getgenv().toggleAutoFollowRider = Value
      if Value then
          print(getgenv().selectedEnemy[1])
          startFollowingArmedRider(getgenv().selectedEnemy[1])
      else
          stopFollowingArmedRider()
      end
  end,
})
