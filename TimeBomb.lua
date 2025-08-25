local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- دالة لإنشاء هيتبوكس كبير متحرك
local function createLargeHitbox(parentPart, size)
    local box = Instance.new("Part")
    box.Anchored = true
    box.CanCollide = false
    box.Size = size -- حجم الهيتبوكس الكبير
    box.CFrame = parentPart.CFrame
    box.Transparency = 0.5
    box.Color = Color3.fromRGB(200, 200, 200)
    box.Parent = Workspace

    -- تحديث موقع الهيتبوكس كل إطار
    RunService.RenderStepped:Connect(function()
        if parentPart and parentPart.Parent then
            box.CFrame = parentPart.CFrame
        else
            box:Destroy()
        end
    end)
end

-- تكبير الهيتبوكس للاعب نفسه (مثلاً يغطي المنطقة الكبيرة)
createLargeHitbox(rootPart, Vector3.new(8, 3, 8)) -- عدّل القيم حسب حجم المنطقة الأحمر

-- تكبير الهيتبوكس للقنابل الموجودة
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        createLargeHitbox(obj, Vector3.new(8, 3, 8)) -- نفس الحجم
    end
end

-- القنابل الجديدة
Workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        createLargeHitbox(obj, Vector3.new(8, 3, 8))
    end
end)

-- إعادة الهيتبوكس بعد Respawn
player.CharacterAdded:Connect(function(char)
    local root = char:WaitForChild("HumanoidRootPart")
    createLargeHitbox(root, Vector3.new(8, 3, 8))
end)
