-- LocalScript (ضعه في StarterPlayerScripts)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- حفظ الحجم الأصلي
local originalSize = rootPart.Size

-- دالة لتكبير الهيتبوكس وتلوينه
local function scaleHitbox(part, scale)
    if part and part:IsA("BasePart") then
        part.Size = part.Size * scale
        part.Transparency = 0.5
        part.Color = Color3.fromRGB(200, 200, 200) -- رمادي فاتح
        part.CanCollide = false -- لتجنب مشاكل التصادم
    end
end

-- تكبير الهيتبوكس للاعب نفسه
scaleHitbox(rootPart, 2)

-- تكبير الهيتبوكس للقنابل الموجودة
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        scaleHitbox(obj, 2)
    end
end

-- تكبير القنابل الجديدة تلقائياً
Workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        scaleHitbox(obj, 2)
    end
end)

-- إعادة تكبير الهيتبوكس عند Respawn
player.CharacterAdded:Connect(function(char)
    local root = char:WaitForChild("HumanoidRootPart")
    scaleHitbox(root, 2)
end)
