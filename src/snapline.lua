-- Zee Hood Streamproof Snapline + Optional FOV
-- Lock key: T | Toggle FOV: Y

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- ================= SETTINGS =================

local FOV_RADIUS = 250
local SHOW_FOV = true

-- ================= DRAWING =================

local FOVCircle = Drawing.new("Circle")
FOVCircle.Radius = FOV_RADIUS
FOVCircle.Thickness = 1.5
FOVCircle.Color = Color3.fromRGB(0, 255, 0)
FOVCircle.Transparency = 1
FOVCircle.Filled = false
FOVCircle.Visible = SHOW_FOV

local Snapline = Drawing.new("Line")
Snapline.Thickness = 2
Snapline.Color = Color3.fromRGB(0, 0, 0)
Snapline.Transparency = 1
Snapline.Visible = false

-- ================= STATE =================

local LockedPlayer = nil

-- ================= UTILS =================

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

-- ================= INPUT =================

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

	if input.KeyCode == Enum.KeyCode.Y then
		SHOW_FOV = not SHOW_FOV
		FOVCircle.Visible = SHOW_FOV
	end
end)

-- ================= RENDER =================

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
		Snapline.Visible = true
	else
		Snapline.Visible = false
	end
end)
