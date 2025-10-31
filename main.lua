local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Lexi Hub (MM2)", -- Title of the window
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by trakker and MonkeyTaggers",
   ShowText = "Murder Mystery hub", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Murder Mystery Hub by trakker, monkey"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "https://discord.gg/XQxKYR5krK", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Key in Discord",
      Subtitle = "Key System",
      Note = "Key in Discord", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Lexi_Hub123"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
local Tab = Window:CreateTab("Player", 4483362458)-- Title, Image

local Button = Tab:CreateButton({
   Name = "Infinite Jump Toggle",
   Callback = function()
       --Toggles the infinite jump between on or off on every script run
_G.infinjump = not _G.infinjump

if _G.infinJumpStarted == nil then
	--Ensures this only runs once to save resources
	_G.infinJumpStarted = true
	
	--Notifies readiness
	game.StarterGui:SetCore("SendNotification", {Title="Lexi Hub"; Text="Infinite Jump Activated!"; Duration=5;})

	--The actual infinite jump
	local plr = game:GetService('Players').LocalPlayer
	local m = plr:GetMouse()
	m.KeyDown:connect(function(k)
		if _G.infinjump then
			if k:byte() == 32 then
			humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
			humanoid:ChangeState('Jumping')
			wait()
			humanoid:ChangeState('Seated')
			end
		end
	end)
end
   end,
})


local Slider = Tab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 250},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)

      --anti spam needed because this is spamming maybe replace any message if changed
     
      Rayfield:Notify({
   Title = "WalkSpeed Changed",
   Content = "Current WalkSpeed: "..Value,
   Duration = 6.5,
   Image = 4483362458,
})
   
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Toggleable Role ESP
local espEnabled = false
local function setRoleESP(enabled)
   for _, player in pairs(game.Players:GetPlayers()) do
      if player.Character then
         local old = player.Character:FindFirstChild("RoleHighlight")
         if old then old:Destroy() end
         if enabled and player.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "RoleHighlight"
            highlight.Adornee = player.Character
            highlight.FillTransparency = 0.3
            highlight.OutlineTransparency = 1
            local role = "Innocent"
            if player.Backpack:FindFirstChild("Knife") or (player.Character:FindFirstChild("Knife")) then
               role = "Murderer"
            elseif player.Backpack:FindFirstChild("Gun") or (player.Character:FindFirstChild("Gun")) then
               role = "Sheriff"
            end
            if role == "Murderer" then
               highlight.FillColor = Color3.fromRGB(255,0,0)
            elseif role == "Sheriff" then
               highlight.FillColor = Color3.fromRGB(0,0,255)
            else
               highlight.FillColor = Color3.fromRGB(0,255,0)
            end
            highlight.Parent = player.Character
         end
      end
   end
end

local Button = Tab:CreateButton({
   Name = "Toggle Player ESP",
   Callback = function()
      espEnabled = not espEnabled
      setRoleESP(espEnabled)
      Rayfield:Notify({
         Title = "Player ESP",
         Content = espEnabled and "ESP activated." or "ESP deactivated  .",
         Duration = 6.5,
         Image = 4483362458,
      })
   end,
})

   


local Button = Tab:CreateButton({
   Name = "Fly Gui",
   Callback = function()
   -- The function that takes place when the button is pressed
loadstring(game:HttpGet("https://raw.githubusercontent.com/idkjfiuehfi3hfiu34jfiu34jf/idkdedeef/refs/heads/main/fly", true))()
   end,
})

local Tab = Window:CreateTab("Misc", 4483362458)-- Title, Image

local noclipEnabled = false
local noclipConnection = nil
local Button = Tab:CreateButton({
   Name = "Toggle No Clip",
   Callback = function()
      noclipEnabled = not noclipEnabled
      if noclipEnabled then
         noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char then
               for _, part in pairs(char:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false
                  end
               end
            end
         end)
         Rayfield:Notify({
            Title = "No Clip",
            Content = "No Clip aktiviert! Du kannst durch Wände laufen.",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         if noclipConnection then noclipConnection:Disconnect() end
         -- Restore CanCollide for character parts
         local char = game.Players.LocalPlayer.Character
         if char then
            for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = true
               end
            end
         end
         Rayfield:Notify({
            Title = "No Clip",
            Content = "No Clip deaktiviert! Du kannst nicht mehr durch Wände laufen.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})

--Kill All

local Tab = Window:CreateTab("Testing", 4483362458)-- Title, Image

local Button = Tab:CreateButton({
   Name = "Kick Me",
   Callback = function()
   -- The function that takes place when the button is pressed
   game.Players.LocalPlayer:Kick("You have been kicked from the game.")
   end,
})

local Button = Tab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
   -- The function that takes place when the button is pressed
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

   end,
})
local Button = Tab:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
   -- The function that takes place when the button is pressed
loadstring(game:HttpGet("https://raw.githubusercontent.com/BigBoyTimme/New.Loadstring.Scripts/refs/heads/main/Dex.Explorer"))()

   end,
})
local Button = Tab:CreateButton({
   Name = "null walkspeed",
   Callback = function()
   -- The function that takes place when the button is pressed
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
   end,
})



local Button = Tab:CreateButton({
   Name = "Save Location",
   Callback = function()
   -- The function that takes place when the button is pressed
_G.savedCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
Rayfield:Notify({
   Title = "Location Saved",
   Content = "You can now teleport back to this location",
   Duration = 6.5,
   Image = 4483362458,
})
   end,
})
--Teleport back to saved location
local Button = Tab:CreateButton({
   Name = "Teleport to Saved Location",
   Callback = function()
   -- The function that takes place when the button is pressed
if _G.savedCFrame then
   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.savedCFrame
else
   Rayfield:Notify({
   Title = "No Location Saved",
   Content = "Please save a location first",
   Duration = 6.5,
   Image = 4483362458,
})
end
   end,
})

local Tab = Window:CreateTab("Teleport", 4483362458)-- Title, Image

--save current location but! in a text file where it has generated a lua code to teleport to that location

local Button = Tab:CreateButton({
   Name = "Generate Teleport Code to Current Location",
   Callback = function()
   -- The function that takes place when the button is pressed
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
   local locationCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
   local code = 'game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new('..locationCFrame.X..', '..locationCFrame.Y..', '..locationCFrame.Z..', '..locationCFrame:components()..')'
   --save to a text file
   writefile("TeleportCode.txt", code)
   Rayfield:Notify({
      Title = "Code Generated",
      Content = "Teleport code saved to TeleportCode.txt",
      Duration = 6.5,
      Image = 4483362458,
   })
   --set clipboard to code
   setclipboard(code)
   Rayfield:Notify({
      Title = "Code Copied",
      Content = "Teleport code copied to clipboard",
      Duration = 6.5,
      Image = 4483362458,
   })
   --notifi user where the file is saved
   Rayfield:Notify({
      Title = "File Location",
      Content = "The file is saved in your executor's workspace folder",
      Duration = 6.5,
      Image = 4483362458,
   })
else
   Rayfield:Notify({
      Title = "Error",
      Content = "Could not generate code. Make sure your character is loaded.",
      Duration = 6.5,
      Image = 4483362458,
   })
end
   end,
})

local Button = Tab:CreateButton({
   Name = "Teleport to Knife ",
   Callback = function()
      local gun = nil
      for _, v in pairs(workspace:GetChildren()) do
         if v:IsA("Tool") and v.Name == "AAAAA" then
            gun = v
            break
         end
      end
      if gun and gun.Parent == workspace then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gun.Handle.CFrame
         Rayfield:Notify({
            Title = "Teleported!",
            Content = "You have been teleported to the gun.",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Gun Not Found",
            Content = "The gun is not currently available in the workspace.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})


--bruteforce teleport to gun (toggle)







      local Button = Tab:CreateButton({
         Name = "Teleport to Player with Gun",
         Callback = function()
            --teleport to Player with tool = "Gun"
            local targetPlayer = nil
            for _, player in pairs(game.Players:GetPlayers()) do
               if player.Character and player.Character:FindFirstChildOfClass("Tool") and player.Character:FindFirstChildOfClass("Tool").Name == "Gun" then
                  targetPlayer = player
                  break
               end
            end
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
               Rayfield:Notify({
                  Title = "Teleported!",
                  Content = "You have been teleported to "..targetPlayer.Name..".",
                  Duration = 6.5,
                  Image = 4483362458,
               })
            else
               Rayfield:Notify({
                  Title = "No Player with Gun Found",
                  Content = "No player with the gun is currently in the game.",
                  Duration = 6.5,
                  Image = 4483362458,
               })
            end
         end,
      })

      



--teleport to lobby V1
local Button = Tab:CreateButton({
   Name = "Teleport to Lobby",
   Callback = function()
   
      --teleport
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
    Vector3.new(86.356, 140.253, 64.210), -- Position
    Vector3.new(90, 140.253, 64.210)      -- Blickrichtung (z. B. leicht nach rechts)
)
      Rayfield:Notify({
         Title = "Teleported!",
         Content = "You have been teleported to the lobby.",
         Duration = 6.5,
         Image = 4483362458,
      })
   end,
})

local Button = Tab:CreateButton({
   Name = "Teleport to Murderer",
   Callback = function()
      local murderer = nil
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= game.Players.LocalPlayer then
            if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
               murderer = player
               break
            end
         end
      end
      if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = murderer.Character.HumanoidRootPart.CFrame
         Rayfield:Notify({
            Title = "Teleport",
            Content = "Du wurdest zum Murderer teleportiert.",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Teleport",
            Content = "Kein Murderer gefunden.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})

local Button = Tab:CreateButton({
   Name = "Teleport to Sheriff",
   Callback = function()
      local sheriff = nil
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= game.Players.LocalPlayer then
            if player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
               sheriff = player
               break
            end
         end
      end
      if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sheriff.Character.HumanoidRootPart.CFrame
         Rayfield:Notify({
            Title = "Teleport",
            Content = "Du wurdest zum Sheriff teleportiert.",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Teleport",
            Content = "Kein Sheriff gefunden.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})

local Button = Tab:CreateButton({
   Name = "Teleport to Random Innocent",
   Callback = function()
      local innocents = {}
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= game.Players.LocalPlayer then
            local isMurderer = player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife"))
            local isSheriff = player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun"))
            if not isMurderer and not isSheriff and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
               table.insert(innocents, player)
            end
         end
      end
      if #innocents > 0 then
         local chosen = innocents[math.random(1, #innocents)]
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chosen.Character.HumanoidRootPart.CFrame
         Rayfield:Notify({
            Title = "Teleport",
            Content = "Du wurdest zu einem zufälligen Innocent teleportiert.",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Teleport",
            Content = "Kein Innocent gefunden.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})
















--new tab
local Tab = Window:CreateTab("Troll", 4483362458)-- Title, Image

local Button = Tab:CreateButton({
   Name = "Fling All (Im Player)",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local char = lp.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if not hrp then return end

      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = v.Character.HumanoidRootPart
            -- Positioniere exakt im Spieler und flinge ihn
            local flingDuration = 5 -- seconds
            local startTime = tick()
            while tick() - startTime < flingDuration do
               hrp.CFrame = targetHRP.CFrame
               hrp.Velocity = Vector3.new(math.random(-10000,10000), math.random(-10000,10000), math.random(-10000,10000))
               wait(0.01)
            end
         end
      end
      Rayfield:Notify({
         Title = "Fling All",
         Content = "Flinged?",
         Duration = 6.5,
         Image = 4483362458,
      })
   end,
})


local Button = Tab:CreateButton({
   Name = "Auto Win Sheriff (Aimbot)",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local char = lp.Character
      local function hasGun()
         return (char and char:FindFirstChild("Gun")) or lp.Backpack:FindFirstChild("Gun")
      end
      if not hasGun() then
         Rayfield:Notify({
            Title = "Auto Win Sheriff",
            Content = "Du musst die Gun besitzen!",
            Duration = 6.5,
            Image = 4483362458,
         })
         return
      end
      -- Equip Gun if in Backpack
      if lp.Backpack:FindFirstChild("Gun") then
         char.Humanoid:EquipTool(lp.Backpack:FindFirstChild("Gun"))
         wait(0.2)
      end
      local mouse = lp:GetMouse()
      local tries = 0
      while hasGun() and tries < 20 do
         local murderer = nil
         for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= lp then
               if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
                  murderer = player
                  break
               end
            end
         end
         if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = murderer.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
            wait(0.1)
            mouse.Target = murderer.Character.HumanoidRootPart
            local gun = char:FindFirstChild("Gun")
            if gun then
               pcall(function() gun:Activate() end)
            end
            wait(0.1)
         else
            break -- Murderer not found, probably dead
         end
         tries = tries + 1
      end
      Rayfield:Notify({
         Title = "Auto Win Sheriff",
         Content = "Auto Win Sheriff mit Aimbot beendet.",
         Duration = 6.5,
         Image = 4483362458,
      })
   end,
})

local Button = Tab:CreateButton({
   Name = "Auto Win Murderer (Aimbot)",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local char = lp.Character
      local function hasKnife()
         return (char and char:FindFirstChild("Knife")) or lp.Backpack:FindFirstChild("Knife")
      end
      if not hasKnife() then
         Rayfield:Notify({
            Title = "Auto Win Murderer",
            Content = "Du musst das Knife besitzen!",
            Duration = 6.5,
            Image = 4483362458,
         })
         return
      end
      -- Equip Knife if in Backpack
      if lp.Backpack:FindFirstChild("Knife") then
         char.Humanoid:EquipTool(lp.Backpack:FindFirstChild("Knife"))
         wait(0.2)
      end
      local mouse = lp:GetMouse()
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
            wait(0.1)
            mouse.Target = player.Character.HumanoidRootPart
            local knife = char:FindFirstChild("Knife")
            if knife then
               pcall(function() knife:Activate() end)
            end
            -- Try click detectors if present
            local head = player.Character:FindFirstChild("Head")
            if head and head:FindFirstChild("ClickDetector") then
               pcall(function() fireclickdetector(head.ClickDetector) end)
               pcall(function() head.ClickDetector:Click() end)
            end
            wait(0.2)
         end
      end
      Rayfield:Notify({
         Title = "Auto Win Murderer",
         Content = "Auto Win Murderer mit Aimbot beendet.",
         Duration = 6.5,
         Image = 4483362458,
      })
   end,
})


local Button = Tab:CreateButton({
   Name = "Kill All (Murderer Only)",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local char = lp.Character
      local knife = char and char:FindFirstChild("Knife") or lp.Backpack:FindFirstChild("Knife")
      if not knife then
         Rayfield:Notify({
            Title = "Kill All",
            Content = "Du musst der Mörder sein (Knife besitzen)!",
            Duration = 6.5,
            Image = 4483362458,
         })
         return
      end
      -- Equip Knife if in Backpack
      if lp.Backpack:FindFirstChild("Knife") then
         char.Humanoid:EquipTool(lp.Backpack:FindFirstChild("Knife"))
         wait(0.2)
      end
      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            wait(0.1)
            local knifeTool = char:FindFirstChild("Knife")
            if knifeTool then
               pcall(function() knifeTool:Activate() end)
            end
            local head = v.Character:FindFirstChild("Head")
            if head and head:FindFirstChild("ClickDetector") then
               pcall(function() fireclickdetector(head.ClickDetector) end)
               pcall(function() head.ClickDetector:Click() end)
            end
            wait(0.2)
         end
      end
      Rayfield:Notify({
         Title = "Kill All",
         Content = "Alle Spieler wurden als Mörder angegriffen!",
         Duration = 6.5,
         Image = 4483362458,
      })
   end,
})

local Button = Tab:CreateButton({
   Name = "Shoot Murder",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local char = lp.Character
      local gun = char and char:FindFirstChild("Gun") or lp.Backpack:FindFirstChild("Gun")
      if not gun then
         Rayfield:Notify({
            Title = "Shoot Murderer",
            Content = "Du musst die Gun besitzen!",
            Duration = 6.5,
            Image = 4483362458,
         })
         return
      end
      -- Equip Gun if in Backpack
      if lp.Backpack:FindFirstChild("Gun") then
         char.Humanoid:EquipTool(lp.Backpack:FindFirstChild("Gun"))
         wait(0.2)
      end
      -- Find Murderer
      local murderer = nil
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= lp then
            if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
               murderer = player
               break
            end
         end
      end
      if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
         char.HumanoidRootPart.CFrame = murderer.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
         wait(0.1)
         local mouse = lp:GetMouse()
         mouse.Target = murderer.Character.HumanoidRootPart
         local gunTool = char:FindFirstChild("Gun")
         if gunTool then
            pcall(function() gunTool:Activate() end)
         end
         Rayfield:Notify({
            Title = "Shoot Murderer",
            Content = "Du hast automatisch auf den Murderer geschossen!",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Shoot Murderer",
            Content = "Kein Murderer gefunden.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})

local spamTeleportEnabled = false
local spamTeleportConnection = nil
local lobbyCFrame = CFrame.new(
    Vector3.new(86.356, 140.253, 64.210),
    Vector3.new(90, 140.253, 64.210)
) -- Lobby position

local Button = Tab:CreateButton({
   Name = "Toggle Spam Teleport to Murderer",
   Callback = function()
      spamTeleportEnabled = not spamTeleportEnabled
      if spamTeleportEnabled then
         spamTeleportConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local murderer = nil
            for _, player in pairs(game.Players:GetPlayers()) do
               if player ~= lp then
                  if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
                     murderer = player
                     break
                  end
               end
            end
            if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
               char.HumanoidRootPart.CFrame = murderer.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
            end
         end)
         Rayfield:Notify({
            Title = "Spam Teleport",
            Content = "Spam Teleport to Murderer activated!",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         if spamTeleportConnection then spamTeleportConnection:Disconnect() end
         local lp = game.Players.LocalPlayer
         local char = lp.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = lobbyCFrame
         end
         Rayfield:Notify({
            Title = "Spam Teleport",
            Content = "Spam teleport deactivated! You have been teleported to the lobby.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})

local Button = Tab:CreateButton({
   Name = "Fling All v2 (Accurate)",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local char = lp.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if not hrp then return end

      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = v.Character.HumanoidRootPart
            -- Positioniere exakt im Spieler (kein Offset)
            local flingDuration = 2 -- seconds
            local startTime = tick()
            while tick() - startTime < flingDuration do
               hrp.CFrame = targetHRP.CFrame
               hrp.Velocity = Vector3.new(math.random(-8000,8000), math.random(2000,4000), math.random(-8000,8000))
               wait(0.02)
            end
         end
      end
      Rayfield:Notify({
         Title = "Fling All V2",
         Content = "Alle Spieler wurden direkt im Spieler geflingt!",
         Duration = 6.5,
         Image = 4483362458,
      })
   end,
})

local Button = Tab:CreateButton({
   Name = "Fling Murderer",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local char = lp.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if not hrp then return end

      local murderer = nil
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= lp then
            if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
               murderer = player
               break
            end
         end
      end

      if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
         local targetHRP = murderer.Character.HumanoidRootPart
         local flingDuration = 2 -- seconds
         local startTime = tick()
         while tick() - startTime < flingDuration do
            hrp.CFrame = targetHRP.CFrame
            hrp.Velocity = Vector3.new(math.random(-8000,8000), math.random(2000,4000), math.random(-8000,8000))
            wait(0.02)
         end
         Rayfield:Notify({
            Title = "Fling Murderer",
            Content = "The murderer has been flung!",
            Duration = 6.5,
            Image = 4483362458,
         })
      else
         Rayfield:Notify({
            Title = "Fling Murderer",
            Content = "No murderer found.",
            Duration = 6.5,
            Image = 4483362458,
         })
      end
   end,
})
