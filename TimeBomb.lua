-- LocalScript (حط هذا السكربت داخل StarterPlayerScripts)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local noclipActive = false

-- دالة تفعيل/إيقاف Noclip
local function toggleNoclip()
    noclipActive = not noclipActive
end

-- إنشاء GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedNoclipGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 180)
mainFrame.Position = UDim2.new(0, 20, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- مربع كتابة السرعة
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 200, 0, 50)
speedBox.Position = UDim2.new(0, 25, 0, 10)
speedBox.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Font = Enum.Font.SourceSansBold
speedBox.TextSize = 22
speedBox.PlaceholderText = "اكتب السرعة هنا"
speedBox.ClearTextOnFocus = false
speedBox.Parent = mainFrame

-- زر تطبيق السرعة
local applySpeedButton = Instance.new("TextButton")
applySpeedButton.Size = UDim2.new(0, 200, 0, 40)
applySpeedButton.Position = UDim2.new(0, 25, 0, 70)
applySpeedButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
applySpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applySpeedButton.Font = Enum.Font.SourceSansBold
applySpeedButton.TextSize = 22
applySpeedButton.Text = "تطبيق السرعة"
applySpeedButton.Parent = mainFrame

applySpeedButton.MouseButton1Click:Connect(function()
    local speed = tonumber(speedBox.Text)
    if speed then
        humanoid.WalkSpeed = speed
    else
        speedBox.Text = "رقم غير صالح!"
    end
end)

-- زر Noclip
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0, 200, 0, 40)
noclipButton.Position = UDim2.new(0, 25, 0, 120)
noclipButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Font = Enum.Font.SourceSansBold
noclipButton.TextSize = 22
noclipButton.Text = "Noclip: إيقاف"
noclipButton.Parent = mainFrame

noclipButton.MouseButton1Click:Connect(function()
    toggleNoclip()
    noclipButton.Text = noclipActive and "Noclip: تشغيل" or "Noclip: إيقاف"
end)

-- تحديث Noclip كل إطار
RunService.Stepped:Connect(function()
    if noclipActive then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and not part.CanCollide then
                part.CanCollide = true
            end
        end
    end
end)
