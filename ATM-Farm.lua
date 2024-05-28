
local Settings = {
    Graphics = {
        LowGFX = true;
    },
    Combat = {
        Equip = 'Knife';  -- Tool to equip for combat
    },
    Cash = {
        Collecting = false; -- Don't Touch
    }
}

if Settings.Graphics.LowGFX then
    loadstring(game:HttpGet('https://pastebin.com/raw/eHEfAR8z', true))()
    game:GetService("RunService"):Set3dRenderingEnabled(true)
end;

task.spawn(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/MercyfulSmoked/localhub/main/Dahood-Antiban'))()
end)

local VirtualUser = game:GetService('VirtualUser')
game:GetService('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local LocalPlayer = game.Players.LocalPlayer
local VIM = game:GetService('VirtualInputManager')
local Camera = workspace.CurrentCamera

local random = math.random(0, 1000000)
if not workspace.Players:FindFirstChild('Safespot') then
    local p = Instance.new('Part')
    p.Parent = workspace.Players
    p.Name = 'Safespot'
    p.Anchored = true
    p.Size = Vector3.new(20, 20, 20)
    p.CFrame = CFrame.new(random, 0, random)
end

function Alive()
    return LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('Humanoid') and true or false 
end 

function safespot()
    local player = game:GetService('Players').LocalPlayer
    local safespot = workspace:FindFirstChild('Players') and workspace.Players:FindFirstChild('Safespot')

    if Alive() and safespot then
        local hrp = player.Character:FindFirstChild('HumanoidRootPart')
        if hrp then
            hrp.CFrame = safespot.CFrame + Vector3.new(0, 10, 0)
        end
    end
end

function EquipCombatTool()
    if LocalPlayer and LocalPlayer.Backpack and Alive() then
        local combatTool = LocalPlayer.Backpack:FindFirstChild(Settings.Combat.Equip)
        if combatTool and combatTool:IsA('Tool') then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
            if humanoid and humanoid.Health > 0 then
                humanoid:EquipTool(combatTool)
            else
                humanoid:UnequipTools()
            end
        end
    end
end

function UnequipTools()
    if Alive() then
        LocalPlayer.Character.Humanoid:UnequipTools()
    end
end

function checkcash()
    local minDistance = math.huge
    local closestPart = nil
    for _, v in ipairs(workspace.Cashiers:GetChildren()) do
        for _, part in ipairs(workspace.Ignored.Drop:GetChildren()) do
            if part.Name == 'MoneyDrop' and LocalPlayer:DistanceFromCharacter(part.Position) < 17 then
                if part.Parent == nil then
                    return nil
                end
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - part.Position).magnitude
                minDistance = distance
                closestPart = part
            end
        end
    end
    
    return closestPart
end

function FindChild(parent, searchText)
    for _, child in ipairs(parent:GetChildren()) do
        if string.find(child.Name, searchText) then
            return child
        end
    end
    return nil
end

local LastCashier = nil
function Atms()
    task.spawn(function()

        if Settings.Combat.Equip == 'Knife' and Alive() then
            repeat task.wait()
                local Knife = FindChild(workspace.Ignored.Shop, 'Knife')
                if Knife:FindFirstChild('Head') and Knife:FindFirstChildOfClass('ClickDetector') then
                    fireclickdetector(Knife:FindFirstChildOfClass('ClickDetector'))
                    task.wait(0.05)
                    LocalPlayer.Character:MoveTo(Knife.Head.Position + Vector3.new(0,-7,0))
                end;
            until LocalPlayer.Backpack:FindFirstChild('[Knife]') or LocalPlayer.Character:FindFirstChild('[Knife]')
            Settings.Combat.Equip = '[Knife]'
        end;

        LocalPlayer.DevCameraOcclusionMode = 'Invisicam'
        while task.wait() do
            local CashierLocked = false
            for _, Cashier in ipairs(workspace.Cashiers:GetChildren()) do
                if Cashier:FindFirstChildOfClass('Humanoid') and Cashier.Humanoid.Health > 0 then
                    CashierLocked = true
                end
            end

            if not CashierLocked then
                Settings.Cash.Collecting = false
                safespot()
            end

            if checkcash() and Alive() then
                UnequipTools()
                repeat
                    local GotCash = false;
                    for _, v in pairs(workspace.Ignored.Drop:GetChildren()) do
                        if (v.Name == 'MoneyDrop') and (v:FindFirstChild('ClickDetector')) and LocalPlayer:DistanceFromCharacter(v.Position) < 17 then
                            Settings.Cash.Collecting = true
                            GotCash = true
                            LocalPlayer.CameraMinZoomDistance = 10
                            LocalPlayer.CameraMaxZoomDistance = 10
                            if LastCashier then
                                Camera.CameraSubject = LastCashier
                                LocalPlayer.Character:MoveTo(LastCashier.Position + Vector3.new(0, 3, 0))
                            end
                            fireclickdetector(v.ClickDetector)
                            task.wait(0.1)
                        end
                    end
                    if not GotCash then break end;
                    task.wait(0.1)
                until not checkcash()
                Camera.CameraSubject = LocalPlayer.Character.Humanoid
                Settings.Cash.Collecting = false
            else
                for _, cashier in ipairs(workspace.Cashiers:GetChildren()) do
                    if cashier:FindFirstChildOfClass('Humanoid') and cashier.Humanoid.Health > 0 and not Settings.Cash.Collecting then
                        if Alive() and not Settings.Cash.Collecting then
                            local char = LocalPlayer.Character
                            local hm = char.Humanoid
                            repeat
                                task.wait()
                                if checkcash() then break end
                                if cashier:FindFirstChildOfClass('Humanoid').Health <= 0 then
                                    safespot()
                                    break
                                end
                                if not char:FindFirstChild('Highlight') then
                                    safespot()
                                    EquipCombatTool()
                                    if LocalPlayer.Character:FindFirstChildOfClass('Tool') then
                                        LocalPlayer.Character:FindFirstChildOfClass('Tool'):Activate()
                                    end
                                else
                                    local BrokenCashier = cashier.Head.CFrame == CFrame.new(-626.998474, 24.9000168, -285.062164, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = cashier.Open.CFrame * (BrokenCashier and CFrame.new(3, -1.5, 0) or CFrame.new(-2, -1.5, 0))
                                    LastCashier = cashier.Open
                                end
                            until cashier:FindFirstChildOfClass('Humanoid').Health <= 0 or checkcash()
                        end
                    end
                end
            end
        end
    end)
end

task.spawn(function()
    while task.wait(0.04) do
        if Settings.Cash.Collecting then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position) * CFrame.Angles(math.rad(-180,180), math.rad(math.random(-180,180)), math.rad(math.random(-180,180)))
        end;
    end;
end)

Atms()
