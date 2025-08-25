-- LocalScript (حط هذا في StarterPlayerScripts)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- حفظ الحجم الأصلي
local originalSize = rootPart.Size

-- دالة لتكبير الهيتبوكس
local function scaleHitbox(part, scale)
    if part and part:IsA("BasePart") then
        part.Size = part.Size * scale
        -- لتجنب مشاكل التصادم يمكن تعيين CanCollide=false مؤقتاً أو حسب الحاجة
    end
end

-- تكبير الهيتبوكس للاعب نفسه
scaleHitbox(rootPart, 2)

-- تكبير الهيتبوكس للقنابل داخل Workspace
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        scaleHitbox(obj, 2)
    end
end

-- لو ظهرت قنابل جديدة أثناء اللعب، نكبرها تلقائياً
Workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        scaleHitbox(obj, 2)
    end
end)

-- لو الشخصية تتجدد (Respawn)، نكبر الهيتبوكس مجدداً
player.CharacterAdded:Connect(function(char)
    local root = char:WaitForChild("HumanoidRootPart")
    scaleHitbox(root, 2)
end)
