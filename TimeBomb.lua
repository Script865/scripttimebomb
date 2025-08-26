-- LocalScript في StarterPlayerScripts
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- حجم مضاعف
local PLAYER_SCALE = 15 -- غير الرقم أكبر/أصغر حسب رغبتك
local BOMB_SCALE   = 15

-- دالة لإنشاء هيتبوكس
local function createHitbox(targetPart, scale, color)
	if not targetPart or not targetPart:IsA("BasePart") then return end
	
	-- لو فيه هيتبوكس قديم نحذفه
	if targetPart:FindFirstChild("FakeHitbox") then
		targetPart.FakeHitbox:Destroy()
	end

	local hitbox = Instance.new("Part")
	hitbox.Name = "FakeHitbox"
	hitbox.Size = targetPart.Size * scale
	hitbox.CFrame = targetPart.CFrame
	hitbox.Anchored = false
	hitbox.CanCollide = false
	hitbox.Transparency = 0.5
	hitbox.Color = color
	hitbox.Material = Enum.Material.Neon
	hitbox.Parent = targetPart

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = hitbox
	weld.Part1 = targetPart
	weld.Parent = hitbox
end

-- هيتبوكس اللاعب
local function applyPlayerHitbox(char)
	local root = char:WaitForChild("HumanoidRootPart")
	createHitbox(root, PLAYER_SCALE, Color3.fromRGB(180,180,180)) -- رمادي
end

-- هيتبوكس القنبلة
local function applyBombHitboxes()
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
			createHitbox(obj, BOMB_SCALE, Color3.fromRGB(255,255,255)) -- أبيض
		end
	end
end

-- لو نزلت قنبلة جديدة
Workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
		createHitbox(obj, BOMB_SCALE, Color3.fromRGB(255,255,255))
	end
end)

-- لو رسبن اللاعب
player.CharacterAdded:Connect(function(char)
	char:WaitForChild("HumanoidRootPart")
	task.wait(1)
	applyPlayerHitbox(char)
end)

-- تطبيق أول مرة
if player.Character then
	applyPlayerHitbox(player.Character)
end
applyBombHitboxes()
