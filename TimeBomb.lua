local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- دالة لإنشاء Box لتحديد الهيتبوكس
local function createHitboxPart(parentPart, scale)
    local box = Instance.new("Part")
    box.Anchored = true
    box.CanCollide = false
    box.Size = parentPart.Size * scale
    box.CFrame = parentPart.CFrame
    box.Transparency = 0.5
    box.Color = Color3.fromRGB(200, 200, 200)
    box.Parent = Workspace
    
    -- تحديث مكان الهيتبوكس كل إطار
    game:GetService("RunService").RenderStepped:Connect(function()
        if parentPart and parentPart.Parent then
            box.CFrame = parentPart.CFrame
        else
            box:Destroy()
        end
    end)
    
    return box
end

-- تحديد الهيتبوكس للاعب نفسه
createHitboxPart(rootPart, 2)

-- تحديد الهيتبوكس للقنابل
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        createHitboxPart(obj, 2)
    end
end

-- القنابل الجديدة
Workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("BasePart") and (obj.Name == "Bomb" or obj.Name == "bomb") then
        createHitboxPart(obj, 2)
    end
end)

-- إعادة الهيتبوكس بعد Respawn
player.CharacterAdded:Connect(function(char)
    local root = char:WaitForChild("HumanoidRootPart")
    createHitboxPart(root, 2)
end)
