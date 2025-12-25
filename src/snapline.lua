-- gernoHUB Snapline Panel
-- by: sae
-- Lock: T | Panel toggle: RightAlt

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local FOV_RADIUS = 250
local SHOW_FOV = true
local PANEL_VISIBLE = true
local PANEL_TRANSPARENCY = 0.5
local TEXT_TRANSPARENCY = 0.5
local SnaplineColor = Color3.fromRGB(0,0,0)

-- DRAWING
local FOVCircle = Drawing.new("Circle")
FOVCircle.Radius = FOV_RADIUS
FOVCircle.Thickness = 1.5
FOVCircle.Color = Color3.fromRGB(0, 255, 0)
FOVCircle.Transparency = 1
FOVCircle.Filled = false
FOVCircle.Visible = SHOW_FOV

local Snapline = Drawing.new("Line")
Snapline.Thickness = 2
Snapline.Color = SnaplineColor
Snapline.Transparency = 1
Snapline.Visible = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "gernoHUBPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 280)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BackgroundTransparency = PANEL_TRANSPARENCY
MainFrame.BorderSizePixel = 0
MainFrame.Visible = PANEL_VISIBLE
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- ⚠️ Disclaimer
local Disclaimer = Instance.new("TextLabel")
Disclaimer.Size = UDim2.new(1, -10, 0, 30)
Disclaimer.Position = UDim2.new(0, 5, 0, 5)
Disclaimer.BackgroundTransparency = 1
Disclaimer.Text = "⚠️ Not a cheat. Visual/educational script only."
Disclaimer.TextColor3 = Color3.fromRGB(255, 200, 0)
Disclaimer.TextTransparency = TEXT_TRANSPARENCY
Disclaimer.Font = Enum.Font.GothamBold
Disclaimer.TextSize = 14
Disclaimer.TextWrapped = true
Disclaimer.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "gernoHUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextTransparency = TEXT_TRANSPARENCY
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Credits
local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, 0, 0, 20)
Credits.Position = UDim2.new(0,0,0,65)
Credits.BackgroundTransparency = 1
Credits.Text = "by: sae"
Credits.TextColor3 = Color3.fromRGB(180, 180, 180)
Credits.TextTransparency = TEXT_TRANSPARENCY
Credits.Font = Enum.Font.Gotham
Credits.TextSize = 14
Credits.Parent = MainFrame

-- Show FOV toggle button
local FOVButton = Instance.new("TextButton")
FOVButton.Size = UDim2.new(0, 200, 0, 40)
FOVButton.Position = UDim2.new(0.5, -100, 0, 90)
FOVButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
FOVButton.BackgroundTransparency = 0.3
FOVButton.Text = "FOV: ON"
FOVButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVButton.TextTransparency = TEXT_TRANSPARENCY
FOVButton.Font = Enum.Font.GothamBold
FOVButton.TextSize = 16
FOVButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = FOVButton

-- Snapline color sliders
local function createSlider(name, yPos, default, callback)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 50, 0, 20)
	label.Position = UDim2.new(0, 10, 0, yPos)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.TextTransparency = TEXT_TRANSPARENCY
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.Parent = MainFrame

	local slider = Instance.new("TextBox")
	slider.Size = UDim2.new(0, 100, 0, 20)
	slider.Position = UDim2.new(0, 70, 0, yPos)
	slider.Text = tostring(default)
	slider.ClearTextOnFocus = false
	slider.BackgroundColor3 = Color3.fromRGB(50,50,50)
	slider.TextColor3 = Color3.fromRGB(255,255,255)
	slider.TextTransparency = TEXT_TRANSPARENCY
	slider.Font = Enum.Font.Gotham
	slider.TextSize = 14
	slider.Parent = MainFrame

	slider.FocusLost:Connect(function()
		local val = tonumber(slider.Text)
		if val then
			val = math.clamp(val, 0, 255)
			callback(val)
			slider.Text = tostring(val)
		end
	end)
end

createSlider("R", 140, 0, function(v)
	SnaplineColor = Color3.fromRGB(v, SnaplineColor.G*255, SnaplineColor.B*255)
	Snapline.Color = SnaplineColor
end)

createSlider("G", 170, 0, function(v)
	SnaplineColor = Color3.fromRGB(SnaplineColor.R*255, v, SnaplineColor.B*255)
	Snapline.Color = SnaplineColor
end)

createSlider("B", 200, 0, function(v)
	SnaplineColor = Color3.fromRGB(SnaplineColor.R*255, SnaplineColor.G*255, v)
	Snapline.Color = SnaplineColor
end)

-- Keybind Cheat-Sheet
local CheatSheet = Instance.new("TextLabel")
CheatSheet.Size = UDim2.new(1, -20, 0, 50)
CheatSheet.Position = UDim2.new(0, 10, 0, 230)
CheatSheet.BackgroundTransparency = 1
CheatSheet.TextColor3 = Color3.fromRGB(255, 255, 255)
CheatSheet.TextTransparency = TEXT_TRANSPARENCY
CheatSheet.Font = Enum.Font.Gotham
CheatSheet.TextSize = 14
CheatSheet.TextWrapped = true
CheatSheet.Text = [[Keybinds:
T - Lock/Unlock Target
RightAlt - Show/Hide Panel]]
CheatSheet.Parent = MainFrame

-- DRAG
local dragging = false
local dragStart, startPos

Title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

Title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- SNAPLINE STATE
local LockedPlayer = nil

-- UTILS
local function getMousePos()
	return UserInputService:GetMouseLocation()
end

local function getClosestInFOV()
	local closest = nil
	local shortest = FOV_RADIUS
	local mousePos = getMousePos()

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer
			and player.Character
			and player.Character:FindFirstChild("HumanoidRootPart") then

			local hrp = player.Character.HumanoidRootPart
			local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

			if onScreen then
				local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
				if dist < shortest then
					shortest = dist
					closest = player
				end
			end
		end
	end

	return closest
end

-- INPUT
FOVButton.MouseButton1Click:Connect(function()
	SHOW_FOV = not SHOW_FOV
	FOVCircle.Visible = SHOW_FOV
	if SHOW_FOV then
		FOVButton.Text = "FOV: ON"
		FOVButton.BackgroundColor3 = Color3.fromRGB(0,180,0)
	else
		FOVButton.Text = "FOV: OFF"
		FOVButton.BackgroundColor3 = Color3.fromRGB(180,0,0)
	end
end)

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.T then
		if LockedPlayer then
			LockedPlayer = nil
			Snapline.Visible = false
		else
			LockedPlayer = getClosestInFOV()
		end
	end

	if input.KeyCode == Enum.KeyCode.RightAlt then
		PANEL_VISIBLE = not PANEL_VISIBLE
		MainFrame.Visible = PANEL_VISIBLE
	end
end)

-- RENDER
RunService.RenderStepped:Connect(function()
	local mousePos = getMousePos()
	FOVCircle.Position = mousePos

	if not LockedPlayer
		or not LockedPlayer.Character
		or not LockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		Snapline.Visible = false
		return
	end

	local hrp = LockedPlayer.Character.HumanoidRootPart
	local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

	if onScreen then
		Snapline.From = mousePos
		Snapline.To = Vector2.new(screenPos.X, screenPos.Y)
		Snapline.Color = SnaplineColor
		Snapline.Visible = true
	else
		Snapline.Visible = false
	end
end)
